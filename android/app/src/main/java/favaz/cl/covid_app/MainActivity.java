package favaz.cl.covid_app;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import services.TracingService;

public class MainActivity extends FlutterActivity {

  private static final String TAG = "MainActivity";
  private static final String CHANNEL = "samples.flutter.dev/covid";
  public static final int REQUEST_ENABLE_BT = 1;
  private boolean running = false;
  private BluetoothAdapter bluetoothAdapter;
  private static final String KEY = "Ephid";

  @Override
  protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    // TODO.. Implement BroadcastReceiver
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
              if (call.method.equals("start")) {
                byte[] res = call.argument("data");
                this.running = start(res);

                if (this.running) {
                  result.success(true);
                } else {
                  result.error(TAG, "Failed to start tracing", null);
                }
              }

              if (call.method.equals("stop")) {
                running = stop();

                if (this.running) {
                  result.success(true);
                } else {
                  result.error(TAG, "Failed to stop tracing", null);
                }
              }
            });
  }

  private boolean start(byte[] res) {
    bluetoothAdapter = ((BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE))
            .getAdapter();

    if (bluetoothAdapter != null) {
      if (bluetoothAdapter.isEnabled()) {
        if (bluetoothAdapter.isMultipleAdvertisementSupported()) {
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Intent intent = new Intent(this, TracingService.class);
            intent.putExtra(KEY, res);

            startForegroundService(intent);
            return true;
          } else {
            Intent intent = new Intent(this, TracingService.class);
            intent.putExtra(KEY, res);

            startService(intent);
            return true;
          }
        } else {
          return false;
        }
      } else {
        Intent enableBtn = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        startActivityForResult(enableBtn, REQUEST_ENABLE_BT);
        return false;
      }
    } else {
      return false;
    }
  }

  private boolean stop() {
    stopService(new Intent(this, TracingService.class));

    return true;
  }
}
