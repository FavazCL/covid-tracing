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

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.NonNull;

class DatabaseOpenHelper extends SQLiteOpenHelper {

  private static final String TAG = "DatabaseOpenHelper";

  private static final int DATABASE_VERSION = 1;
  private static final String DATABASE_NAME = "covidapp.db";

  private static DatabaseOpenHelper instance;

  static DatabaseOpenHelper getInstance(@NonNull Context context) {
    if (instance == null) {
      instance = new DatabaseOpenHelper(context);
    }

    return instance;
  }

  private DatabaseOpenHelper(@NonNull Context context) {
    super(context, DATABASE_NAME, null, DATABASE_VERSION);
  }

  @Override
  public void onCreate(SQLiteDatabase db) {
    recreateTables(db);
  }

  @Override
  public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
    // TO DO..
  }

  @Override
  public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
    onCreate(db); //do as we create a new table
  }

  public void recreateTables(@NonNull SQLiteDatabase db) {
    new Transaction(db,
            Handshakes.drop(),
            Handshakes.create()
    ).run();
  }

}
