package favaz.cl.covid_app.services;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;

import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;

import com.example.covid_tracing.MainActivity;

public class Notifications {

  private static final String TAG = "Notifications";

  private static final String NOTIFICATION_CHANNEL_ID = "covid.tracing";
  private static final String channelName = "Background Service";

  public static Notification simpleChannel(Context context) {
    Intent notificationIntent = new Intent(context, MainActivity.class);

    PendingIntent pendingIntent = PendingIntent
            .getActivity(context, 0, notificationIntent, 0);

    Notification notification = new Notification.Builder(context)
            .setContentTitle("Covid Tracing")
            .setContentText("Buscando dispositivos cercanos...")
            .setSmallIcon(android.R.drawable.stat_sys_data_bluetooth)
            .setContentIntent(pendingIntent)
            .build();

    return notification;
  }

  @RequiresApi(26)
  public static Notification customChannel(Context context) {
    NotificationChannel nc = new NotificationChannel(NOTIFICATION_CHANNEL_ID,
            channelName, NotificationManager.IMPORTANCE_NONE);
    nc.setLightColor(Color.BLUE);
    nc.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);

    NotificationManager manager = (NotificationManager)
            context.getSystemService(Context.NOTIFICATION_SERVICE);
    assert manager != null;
    manager.createNotificationChannel(nc);

    NotificationCompat.Builder notificationBuilder =
            new NotificationCompat.Builder(context, NOTIFICATION_CHANNEL_ID);

    Notification notification = notificationBuilder.setOngoing(true)
            .setSmallIcon(android.R.drawable.stat_sys_data_bluetooth)
            .setContentTitle("Covid Tracing")
            .setStyle(new NotificationCompat.BigTextStyle().bigText("Buscando dispositivos cercanos."))
            .setContentText("Buscando dispositivos cercanos...")
            .setPriority(NotificationManager.IMPORTANCE_MIN)
            .setCategory(Notification.CATEGORY_SERVICE)
            .build();

    return notification;
  }

}
