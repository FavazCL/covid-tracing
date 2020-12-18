/*
 * Copyright (c) 2020 Ubique Innovation AG <https://www.ubique.ch>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * SPDX-License-Identifier: MPL-2.0
 */
package favaz.cl.covid_app.database;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import androidx.annotation.NonNull;

import favaz.cl.covid_app.models.Handshake;

public class Database {

  private static final String TAG = "Database";

  private DatabaseOpenHelper databaseOpenHelper;
  private DatabaseThread databaseThread;

  public Database(@NonNull Context context) {
    databaseOpenHelper = DatabaseOpenHelper.getInstance(context);
    databaseThread = DatabaseThread.getInstance(context);
  }

  public ContentValues addHanshake(Context context, Handshake handshake) {
    SQLiteDatabase db = databaseOpenHelper.getWritableDatabase();

    ContentValues values = new ContentValues();
    values.put(Handshakes.EPHID, handshake.getEphId().getData());
    values.put(Handshakes.TIMESTAMP, handshake.getTimestamp());
    values.put(Handshakes.TX_POWER_LEVEL, handshake.getTxPowerLevel());
    values.put(Handshakes.RSSI, handshake.getRssi());
    values.put(Handshakes.PHY_PRIMARY, handshake.getPrimaryPhy());
    values.put(Handshakes.PHY_SECONDARY, handshake.getSecondaryPhy());
    values.put(Handshakes.TIMESTAMP_NANOS, handshake.getTimestampNanos());
    databaseThread.post(() -> {
      db.insert(Handshakes.TABLE_NAME, null, values);
    });

    return values;
  }

}
