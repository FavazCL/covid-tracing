package ble;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattServer;
import android.bluetooth.BluetoothGattServerCallback;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.content.Context;

import utils.Contants_Ble;

public class GattServer {

  private static final String TAG = "GattServer";

  private BluetoothManager bluetoothManager;
  private BluetoothGattServer bluetoothGattServer;
  private BluetoothGattService bluetoothGattService;
  private BluetoothGattCharacteristic bluetoothGattCharacteristic;
  private Context context;

  public GattServer(Context context) {
    this.context = context;
  }

  public void createServer() {
    bluetoothManager = (BluetoothManager) this.context.getSystemService(Context.BLUETOOTH_SERVICE);
    if (bluetoothGattServer == null) {
      bluetoothGattServer = bluetoothManager.openGattServer(this.context,
              bluetoothGattServerCallback);

      if (bluetoothGattServer != null) {
        bluetoothGattService = new BluetoothGattService(Contants_Ble.GATT_SERVICE_UUID,
                BluetoothGattService.SERVICE_TYPE_PRIMARY);

        int permission = BluetoothGattCharacteristic.PERMISSION_WRITE |
                BluetoothGattCharacteristic.PERMISSION_READ;
        int property = BluetoothGattCharacteristic.PROPERTY_WRITE |
                BluetoothGattCharacteristic.PROPERTY_READ;

        bluetoothGattCharacteristic = new BluetoothGattCharacteristic(Contants_Ble.CHARACTERISTIC_UUID,
                property, permission);

        bluetoothGattService.addCharacteristic(bluetoothGattCharacteristic);
        bluetoothGattServer.addService(bluetoothGattService);
      }
    }
  }

  public synchronized void stopServer() {
    if (bluetoothGattServer != null) {
      bluetoothGattServer.close();
      bluetoothGattServer = null;
    }
  }

  public static BluetoothGattServerCallback bluetoothGattServerCallback =
          new BluetoothGattServerCallback() {
            @Override
            public void onConnectionStateChange(BluetoothDevice device, int status, int newState) {
              super.onConnectionStateChange(device, status, newState);

              // TODO implement..
            }

            @Override
            public void onServiceAdded(int status, BluetoothGattService service) {
              super.onServiceAdded(status, service);

              // TODO implement..
            }

            @Override
            public void onCharacteristicReadRequest(BluetoothDevice device, int requestId, int offset, BluetoothGattCharacteristic characteristic) {
              super.onCharacteristicReadRequest(device, requestId, offset, characteristic);

              // TODO implement..
            }

            @Override
            public void onCharacteristicWriteRequest(BluetoothDevice device, int requestId, BluetoothGattCharacteristic characteristic, boolean preparedWrite, boolean responseNeeded, int offset, byte[] value) {
              super.onCharacteristicWriteRequest(device, requestId, characteristic, preparedWrite, responseNeeded, offset, value);

              // TODO implement..
            }
          };

}
