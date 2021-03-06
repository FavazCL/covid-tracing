import 'package:covid_app/app/data/models/EphId.dart';
import 'package:meta/meta.dart';

class Handshake {
    Handshake({
        @required this.id,
        @required this.timestamp,
        @required this.ephId,
        @required this.txPowerLevel,
        @required this.rssi,
        @required this.primaryPhy,
        @required this.secondaryPhy,
        @required this.timestampNanos,
    });

    final int id;
    final int timestamp;
    final EphId ephId;
    final int txPowerLevel;
    final int rssi;
    final String primaryPhy;
    final String secondaryPhy;
    final int timestampNanos;

    factory Handshake.fromJson(Map<String, dynamic> json) => Handshake(
        id: json["id"],
        timestamp: json["timestamp"],
        ephId: EphId.fromDB(json["ephID"]),
        txPowerLevel: json["tx_power_level"],
        rssi: json["rssi"],
        primaryPhy: json["phy_primary"],
        secondaryPhy: json["phy_secondary"],
        timestampNanos: json["timestamp_nanos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "timestamp": timestamp,
        "ephId": ephId,
        "txPowerLevel": txPowerLevel,
        "rssi": rssi,
        "primaryPhy": primaryPhy,
        "secondaryPhy": secondaryPhy,
        "timestampNanos": timestampNanos,
    };
}
