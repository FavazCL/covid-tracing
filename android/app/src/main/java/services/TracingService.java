package services;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.os.PowerManager;

import androidx.annotation.Nullable;

import ble.Advertising;
import ble.GattServer;
import ble.Scanning;
import utils.Constants_Notification;

public class TracingService extends Service {

    private static final String TAG = "TracingService";
    private static final String KEY = "Ephid";
    private Advertising advertising;
    private Scanning scanning;
    private GattServer gattServer;
    private PowerManager.WakeLock wakeLock;

  @Override
  public void onCreate() {
    super.onCreate();
  }

  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {
    if (wakeLock == null) {
      PowerManager powerManager = (PowerManager) getSystemService(Context.POWER_SERVICE);
      wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK,
              getPackageName() + ":TracingServiceWakeLock");
      wakeLock.acquire();
    }

    if (intent != null) {
      byte[] res = intent.getByteArrayExtra(KEY);

      if (res != null) {
        startGattServer();
        startScanning();
        startAdvertising(res);
      } else {
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
      startForeground(Constants_Notification.CUSTOM_FOREGROUND_NOTIFICATION_ID,
              Notifications.customChannel(this));
    } else {
      startForeground(Constants_Notification.SIMPLE_FOREGROUND_NOTIFICATION_ID,
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
