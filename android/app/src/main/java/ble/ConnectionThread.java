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

import java.util.concurrent.LinkedBlockingQueue;

public class ConnectionThread extends Thread {

  private static final String TAG = "ConnectionThread";
  private boolean running = true;
  private LinkedBlockingQueue<ConnectionTask> bluetoothDevicesToConnect = new LinkedBlockingQueue<>();

  public ConnectionThread() { super("ConnectionThread"); }

  public void addTask(ConnectionTask task) {
    bluetoothDevicesToConnect.add(task);
  }

  @Override
  public void run() {
    while (running) {
      ConnectionTask task = null;
      try {
        task = bluetoothDevicesToConnect.take();
      } catch (InterruptedException e) {
        // Ignore
      }

      if (task != null) {
        task.execute();
        while (!task.isFinished()) {
          try {
            Thread.sleep(1000);
          } catch (InterruptedException e) {
            // Ignore
          }

          if (running) {
            task.checkForTimeout();
          } else {
            task.finish();
          }
        }
      }
    }
  }

  public void terminate() {
    running = false;
    interrupt();
  }

}
