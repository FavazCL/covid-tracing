package favaz.cl.covid_app.services;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.os.PowerManager;
import android.util.Log;

import androidx.annotation.Nullable;

import favaz.cl.covid_app.ble.Advertising;
import favaz.cl.covid_app.ble.GattServer;
import favaz.cl.covid_app.ble.Scanning;

public class TracingService extends Service {

  private static final String TAG = "TracingService";
  private static final String KEY = "Ephid";
  private PowerManager.WakeLock wakeLock;
  private Advertising advertising;
  private GattServer gattServer;
  private Scanning scanning;

  @Override
  public void onCreate() {
    super.onCreate();
    Log.d(TAG, "actiate");
  }

  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {
    Log.d(TAG, "onstartcommand");
    if (wakeLock == null) {
      PowerManager powerManager = (PowerManager) getSystemService(Context.POWER_SERVICE);
      wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK,
              getPackageName() + ":TracingServiceWakeLock");
      wakeLock.acquire();
    }

    if (intent != null) {
      byte[] res = intent.getByteArrayExtra(KEY);

      if (res != null) {
        Log.d(TAG, "AVAILABLE");
        startGattServer();
        startScanning();
        startAdvertising(res);
      } else {
        Log.d(TAG, "destroy");
        onDestroy();
      }
    }

    return START_REDELIVER_INTENT;
  }

  @Override
  public void onDestroy() {
    super.onDestroy();

    stopGattServer();
    stopScanning();
    stopAdvertising();
  }

  @Nullable
  @Override
  public IBinder onBind(Intent intent) {
    return null;
  }

  private void startGattServer() {
    stopGattServer();

    gattServer = new GattServer(this);
    gattServer.createServer();
  }

  private void stopGattServer() {
    if (gattServer != null) {
      gattServer.stopServer();
      gattServer = null;
    }
  }

  private void startAdvertising(byte[] ephid) {
    stopAdvertising();

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      startForeground(Constants.CUSTOM_FOREGROUND_NOTIFICATION_ID,
              Notifications.customChannel(this));
    } else {
      startForeground(Constants.SIMPLE_FOREGROUND_NOTIFICATION_ID,
              Notifications.simpleChannel(this));
    }

    advertising = new Advertising(this);
    advertising.startAdvertising(ephid);
  }

  private void stopAdvertising() {
    if (advertising != null) {
      advertising.stopAdvertising();
      advertising = null;
    }
  }

  private void startScanning() {
    stopScanning();

    scanning = new Scanning(this);
    scanning.startScanning();
  }

  private void stopScanning() {
    if (scanning != null) {
      scanning.stopScanning();
      scanning = null;
    }
  }

}
