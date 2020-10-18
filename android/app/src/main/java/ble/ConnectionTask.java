/*
 * Copyright (c) 2020 Ubique Innovation AG <https://www.ubique.ch>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * SPDX-License-Identifier: MPL-2.0
 */
package ble;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothProfile;
import android.content.Context;
import android.os.Build;
import android.util.Log;

import java.util.Arrays;

import models.EphId;
import no.nordicsemi.android.support.v18.scanner.ScanResult;
import utils.Contants_Ble;

public class ConnectionTask {

  private static final String TAG = "ConnectionTask";

  private static final long GATT_READ_TIMEOUT = 10 * 1000L;
  private BluetoothDevice bluetoothDevice;
  private BluetoothGatt bluetoothGatt;
  private ScanResult scanResult;
  private Callback callback;
  private Context context;
  private long startTime;

  public ConnectionTask(Context context, BluetoothDevice bluetoothDevice, ScanResult scanResult, Callback callback) {
    this.context = context;
    this.bluetoothDevice = bluetoothDevice;
    this.scanResult = scanResult;
    this.callback = callback;
  }

  public void execute() {
    final BluetoothGattCallback gattCallback = new BluetoothGattCallback() {

      @Override
      public void onConnectionStateChange(BluetoothGatt gatt, int status, int newState) {
        super.onConnectionStateChange(gatt, status, newState);

        if (newState == BluetoothProfile.STATE_CONNECTING) {
        } else if (newState == BluetoothProfile.STATE_CONNECTED) {
          gatt.requestMtu(512);
        } else if (newState == BluetoothProfile.STATE_DISCONNECTED || newState == BluetoothProfile.STATE_DISCONNECTING) {
          finish();
        }
      }

      @Override
      public void onMtuChanged(BluetoothGatt gatt, int mtu, int status) {
        gatt.discoverServices();
      }

      @Override
      public void onServicesDiscovered(BluetoothGatt gatt, int status) {
        BluetoothGattService service = gatt.getService(Contants_Ble.GATT_SERVICE_UUID);

        if (service == null) {
          finish();
          return;
        }

        BluetoothGattCharacteristic characteristic = service.getCharacteristic(Contants_Ble.CHARACTERISTIC_UUID);

        boolean initiatedRead = gatt.readCharacteristic(characteristic);
        if (!initiatedRead) {
          Log.d(TAG, "Failed to initiate characteristic read");
        } else {
          Log.d(TAG, "Read initiated");
        }
      }

      @Override
      public void onCharacteristicRead(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
        Log.d(TAG, "onCharacteristicRead [status: " + status + "] " + characteristic.getUuid() + ": " +
                Arrays.toString(characteristic.getValue()));

        if (characteristic.getUuid().equals(Contants_Ble.CHARACTERISTIC_UUID)) {
          if (status == BluetoothGatt.GATT_SUCCESS) {
            Log.d(TAG, "Gatt Success :D");
            scanResult.getRssi();
          } else {
            Log.d(TAG, "Failed to read characteristic. Status: " + status);
          }
        }

        finish();
        Log.d(TAG, "Closed gatt connection");
      }
    };

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      bluetoothGatt = bluetoothDevice.connectGatt(this.context, false, gattCallback, BluetoothDevice.TRANSPORT_LE);
    } else {
      bluetoothGatt = bluetoothDevice.connectGatt(this.context, false, gattCallback);
    }

    startTime = System.currentTimeMillis();
  }

  public void checkForTimeout() {
    if (System.currentTimeMillis() - startTime > GATT_READ_TIMEOUT) {
      finish();
    }
  }

  public boolean isFinished() {
    return bluetoothGatt == null;
  }

  public void finish() {
    if (bluetoothGatt != null) {
      bluetoothGatt.disconnect();
      bluetoothGatt.close();
      bluetoothGatt = null;
    }
  }

  public interface Callback {
    void onEphIdRead(EphId ephId, BluetoothDevice device);
  }

}
