package favaz.cl.covid_app.ble;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.bluetooth.le.AdvertiseCallback;
import android.bluetooth.le.AdvertiseData;
import android.bluetooth.le.AdvertiseSettings;
import android.bluetooth.le.AdvertisingSet;
import android.bluetooth.le.AdvertisingSetCallback;
import android.bluetooth.le.AdvertisingSetParameters;
import android.bluetooth.le.BluetoothLeAdvertiser;
import android.content.Context;
import android.os.Build;
import android.os.ParcelUuid;
import android.util.Log;

import androidx.annotation.RequiresApi;

public class Advertising {

  private static final String TAG = "Advertising";
  private AdvertisingSetCallback advertisingSetCallback;
  private BluetoothLeAdvertiser bluetoothLeAdvertiser;
  private AdvertiseCallback advertiseCallback;
  private BluetoothManager bluetoothManager;
  private BluetoothAdapter bluetoothAdapter;
  public boolean compatible = false;
  private Context context;

  public Advertising(Context context) {
    this.context = context;

    init();
  }

  public void init() {
    if (bluetoothLeAdvertiser == null) {
      bluetoothManager = (BluetoothManager) this.context.
              getSystemService(this.context.BLUETOOTH_SERVICE);

      if (bluetoothManager != null) {
        bluetoothAdapter = bluetoothManager.getAdapter();

        if (bluetoothAdapter != null) {
          bluetoothLeAdvertiser = BluetoothAdapter.getDefaultAdapter().getBluetoothLeAdvertiser();
        }
      }
    }
  }

  public void startAdvertising(byte[] ephid) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      //compatible = verifyBluetooth5();

      if (compatible) {
        Log.d(TAG, "Advertising API_LEVEL => 26, B5 COMPATIBILITY");

        AdvertisingSetParameters parameters = (new AdvertisingSetParameters.Builder())
                //.setLegacyMode(true)
                .setConnectable(true)
                .setInterval(AdvertisingSetParameters.INTERVAL_LOW)
                .setTxPowerLevel(AdvertisingSetParameters.TX_POWER_MEDIUM)
                .build();

        AdvertiseData data = (new AdvertiseData.Builder())
                .addServiceUuid(new ParcelUuid(Constants.GATT_SERVICE_UUID))
                .addServiceData(new ParcelUuid(Constants.GATT_SERVICE_UUID), getAdvertiseData(ephid))
                .build();

        AdvertiseData scanResponse = scanResponseAdvertise(ephid);
        advertisingSetCallback = new NewAdvertiseCallback();

        bluetoothLeAdvertiser.startAdvertisingSet(parameters, data, null,
                null, null, advertisingSetCallback);
      } else {
        Log.d(TAG, "Advertising API_LEVEL => 26, BUT NOT B5 COMPATIBILITY");

        AdvertiseSettings settings = buildAdvertiseSettings();
        AdvertiseData data = buildAdvertiseData(ephid);
        AdvertiseData scanResponse = scanResponseAdvertise(ephid);
        advertiseCallback = new ClassicAdvertiseCallback();

        bluetoothLeAdvertiser.startAdvertising(settings, data, scanResponse, advertiseCallback);
      }

    } else {
      if (advertiseCallback == null) {
        Log.d(TAG, "Advertising API_LEVEL < 26");

        AdvertiseSettings settings = buildAdvertiseSettings();
        AdvertiseData data = buildAdvertiseData(ephid);
        advertiseCallback = new ClassicAdvertiseCallback();

        if (bluetoothLeAdvertiser != null) {
          bluetoothLeAdvertiser.startAdvertising(settings, data, advertiseCallback);
        }
      }
    }
  }

  public void stopAdvertising() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && compatible) {
      bluetoothLeAdvertiser.stopAdvertisingSet(advertisingSetCallback);
    } else {
      bluetoothLeAdvertiser.stopAdvertising(advertiseCallback);
    }
  }

  @RequiresApi(26)
  public boolean verifyBluetooth5() {
    if (bluetoothAdapter.isMultipleAdvertisementSupported() && bluetoothAdapter.isLe2MPhySupported()
            && bluetoothAdapter.isLeExtendedAdvertisingSupported()
            && bluetoothAdapter.isLePeriodicAdvertisingSupported()) {
      return true;
    }
    return false;
  }

  private AdvertiseSettings buildAdvertiseSettings() {
    AdvertiseSettings.Builder settingsBuilder = new AdvertiseSettings.Builder();
    settingsBuilder.setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_POWER);
    settingsBuilder.setConnectable(true);
    settingsBuilder.setTimeout(0);
    settingsBuilder.setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_MEDIUM);

    return settingsBuilder.build();
  }

  private AdvertiseData buildAdvertiseData(byte[] ephid) {
    AdvertiseData.Builder dataBuilder = new AdvertiseData.Builder();
    dataBuilder.setIncludeDeviceName(false);
    dataBuilder.setIncludeTxPowerLevel(true);
    dataBuilder.addServiceUuid(new ParcelUuid(Constants.GATT_SERVICE_UUID));
    dataBuilder.addServiceData(new ParcelUuid(Constants.GATT_SERVICE_UUID), getAdvertiseData(ephid));

    return dataBuilder.build();
  }

  private AdvertiseData scanResponseAdvertise(byte[] ephid) {
    AdvertiseData.Builder dataBuilder = new AdvertiseData.Builder();
    dataBuilder.setIncludeTxPowerLevel(false);
    dataBuilder.setIncludeDeviceName(false);
    dataBuilder.addServiceData(new ParcelUuid(Constants.GATT_SERVICE_UUID), getAdvertiseData(ephid));

    return dataBuilder.build();
  }

  private byte[] getAdvertiseData(byte[] ephid) {
    if (ephid.length > 16) {
      stopAdvertising(); // TO DO.. handling error.
    }

    return ephid;
  }

  private class ClassicAdvertiseCallback extends AdvertiseCallback {

    @Override
    public void onStartSuccess(AdvertiseSettings settingsInEffect) {
      super.onStartSuccess(settingsInEffect);
        Log.d(TAG, "ON STAT SUCCES;" + settingsInEffect);
      // TODO..
    }

    @Override
    public void onStartFailure(int errorCode) {
      super.onStartFailure(errorCode);
      Log.d(TAG, "ON STAT FAILURE;" + errorCode);
      // TODO..
    }

  }

    @RequiresApi(26)
    public class NewAdvertiseCallback extends AdvertisingSetCallback {

    @Override
    public void onAdvertisingSetStarted(AdvertisingSet advertisingSet, int txPower, int status) {
      // TODO ..
      Log.d(TAG, "onAdvertisingSetStarted: " + advertisingSet + " txPower: " + txPower +" status: " + status);
    }

    @Override
    public void onAdvertisingDataSet(AdvertisingSet advertisingSet, int status) {
      // TODO ..
      Log.d(TAG, "onAdvertisingDataSet: " + advertisingSet + " status: " + status);
    }

    @Override
    public void onScanResponseDataSet(AdvertisingSet advertisingSet, int status) {
      // TODO ..
      Log.d(TAG, "onScanResponseDataSet: " + advertisingSet + " status: " + status);
    }

    @Override
    public void onAdvertisingSetStopped(AdvertisingSet advertisingSet) {
      // TODO ..
      Log.d(TAG, "onAdvertisingSetStopped: " + advertisingSet);
    }
  };

}
