package ble;

import android.bluetooth.BluetoothDevice;
import android.content.Context;
import android.os.Build;
import android.os.ParcelUuid;
import android.util.Log;

import androidx.annotation.NonNull;

import Database.Database;
import models.EphId;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import models.Handshake;
import no.nordicsemi.android.support.v18.scanner.BluetoothLeScannerCompat;
import no.nordicsemi.android.support.v18.scanner.ScanCallback;
import no.nordicsemi.android.support.v18.scanner.ScanFilter;
import no.nordicsemi.android.support.v18.scanner.ScanResult;
import no.nordicsemi.android.support.v18.scanner.ScanSettings;
import utils.Contants_Ble;

public class Scanning {

  private static final String TAG = "Scanning";

  public static final int EPHID_LENGTH = 16;
  private BluetoothLeScannerCompat scannerCompat = BluetoothLeScannerCompat.getScanner();
  private ConnectionThread connectionThread;
  private ScanSettings scanSettings;
  private ScanFilter scanFilter;
  private Context context;
  private HashMap<String, List<Handshake>> scanResultMap = new HashMap<>();
  private HashMap<String, EphId> connectedEphIdMap = new HashMap<>();


  public Scanning(Context context) {
    this.context = context;
    this.connectionThread = new ConnectionThread();
    this.connectionThread.start();
  }

  public void startScanning() {
    scannerCompat.startScan(buildScanFilters(), buildScanSettings(), scanCallback);
  }

  private ScanSettings buildScanSettings() {
    ScanSettings.Builder settings = new ScanSettings.Builder();
    settings.setScanMode(ScanSettings.SCAN_MODE_LOW_POWER);
    settings.setMatchMode(ScanSettings.MATCH_MODE_AGGRESSIVE);
    settings.setReportDelay(1000);
    settings.setNumOfMatches(ScanSettings.MATCH_NUM_MAX_ADVERTISEMENT);
    settings.setCallbackType(ScanSettings.CALLBACK_TYPE_ALL_MATCHES);
    settings.setUseHardwareBatchingIfSupported(true);

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      settings.setPhy(ScanSettings.PHY_LE_ALL_SUPPORTED);
      settings.setLegacy(true);
    }

    return settings.build();
  }

  private List<ScanFilter> buildScanFilters() {
    List<ScanFilter> scanFilters = new ArrayList<>();

    ScanFilter.Builder filters = new ScanFilter.Builder();
    filters.setServiceUuid(new ParcelUuid(Contants_Ble.GATT_SERVICE_UUID));
    //filters.setManufacturerData(0x004c, new byte[0]); TO DO.. Handling to IOS.
    scanFilters.add(filters.build());

    return scanFilters;
  }

  ScanCallback scanCallback = new ScanCallback() {
    @Override
    public void onScanResult(int callbackType, @NonNull ScanResult result) {
      if (result.getScanRecord() != null) {
        onDeviceFound(result);
      }
    }

    @Override
    public void onBatchScanResults(@NonNull List<ScanResult> results) {
      Log.d(TAG, "scan: " + results);
      for (ScanResult result : results) {
        onScanResult(0, result);
      }
    }

    @Override
    public void onScanFailed(int errorCode) {
      Log.d(TAG, "onScanFailed() - errorCode: " + errorCode);
    }
  };

  public synchronized void stopScanning() {
    connectionThread.terminate();
    scannerCompat.stopScan(scanCallback);
    scannerCompat = null;

    Database database = new Database(context);

    for (Map.Entry<String, List<Handshake>> entry : scanResultMap.entrySet()) {
      String device = entry.getKey();
      List<Handshake> handshakes = scanResultMap.get(device);
      if (connectedEphIdMap.containsKey(device)) {
        EphId ephId = connectedEphIdMap.get(device);
        for (Handshake handshake : handshakes) {
          handshake.setEphId(ephId);
          database.addHanshake(context, handshake);
        }
      } else {
        for (Handshake handshake : handshakes) {
          if (handshake.getEphId() != null) {
            database.addHanshake(context, handshake);
          }
        }
      }
    }
  }

  private void onDeviceFound(ScanResult scanResult) {
    try {
      BluetoothDevice bluetoothDevice = scanResult.getDevice();
      final String deviceAddress = bluetoothDevice.getAddress();

      int power = scanResult.getScanRecord().getTxPowerLevel();

      if (power == Integer.MIN_VALUE) {
        power = 12;
      }

      List<Handshake> handshakesForDevice = scanResultMap.get(deviceAddress);
      if (handshakesForDevice == null) {
        handshakesForDevice = new ArrayList<>();
        scanResultMap.put(deviceAddress, handshakesForDevice);
      }

      byte[] payload = scanResult.getScanRecord().getServiceData(new ParcelUuid(Contants_Ble.GATT_SERVICE_UUID));
      boolean correctPayload = payload != null && payload.length == EPHID_LENGTH;

      if (correctPayload) {
        handshakesForDevice.add(createHanshake(new EphId(payload), scanResult, power));
      } else {
        if (handshakesForDevice.isEmpty()) {
          connectionThread.addTask(new ConnectionTask(context, bluetoothDevice, scanResult,
                  (ephId, device) -> {
                    connectedEphIdMap.put(device.getAddress(), ephId);
                  }));
        }
        handshakesForDevice.add(createHanshake(null, scanResult, power));
      }

    } catch (Exception e) {
      Log.d(TAG, "Exception onDeviceFound: " + e);
    }
  }

  private Handshake createHanshake(EphId ephId, ScanResult scanResult, int power) {
    return new Handshake(-1, System.currentTimeMillis(), ephId, power, scanResult.getRssi(),
            BleCompat.getPrimaryPhy(scanResult), BleCompat.getSecondaryPhy(scanResult),
            scanResult.getTimestampNanos());
  }

}
