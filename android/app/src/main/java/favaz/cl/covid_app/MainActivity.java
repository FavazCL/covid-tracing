package favaz.cl.covid_app;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import favaz.cl.covid_app.services.TracingService;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "dev/tracing";
  private static final String TAG = "MainActivity";
  public static final int REQUEST_ENABLE_BT = 1;
  private BluetoothAdapter bluetoothAdapter;
  private static final String KEY = "Ephid";
  private boolean running = false;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    // TODO implement BroadcastReceiver...
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
              if (call.method.equals("start")) {
                byte[] res = call.argument("data");
                bluetoothAdapter = ((BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE))
            .getAdapter();
                if (bluetoothAdapter != null && bluetoothAdapter.isEnabled()) {
                  this.running = start(res);
                  System.out.println("working");
                  Log.d(TAG, res.toString());
                  if (this.running) {
                    result.success(true);
                  } else {
                    result.success(false);
                  }
                } else {
                  result.success(false);
                }
              }

              if (call.method.equals("stop")) {
                running = stop();

                if (this.running) {
                  System.out.println("finish");
                  result.success(true);
                } else {
                  result.success(false);
                }
              }
            });
  }

  private boolean start(byte[] res) {
    System.out.println("SUPONGO QUE NO");
    bluetoothAdapter = ((BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE))
            .getAdapter();

    if (bluetoothAdapter != null) {
      if (bluetoothAdapter.isEnabled()) {
        if (bluetoothAdapter.isMultipleAdvertisementSupported()) {
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Intent intent = new Intent(this, TracingService.class);
            intent.putExtra(KEY, res);
            Log.d(TAG, "SDK > 0");
            startForegroundService(intent);
            return true;
          } else {
            Intent intent = new Intent(this, TracingService.class);
            intent.putExtra(KEY, res);
            Log.d(TAG,"SDK < 0");
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
