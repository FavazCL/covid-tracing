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
    final dynamic ephId;
    final int txPowerLevel;
    final int rssi;
    final String primaryPhy;
    final String secondaryPhy;
    final int timestampNanos;

    factory Handshake.fromJson(Map<String, dynamic> json) => Handshake(
        id: json["id"],
        timestamp: json["timestamp"],
        ephId: json["ephId"],
        txPowerLevel: json["txPowerLevel"],
        rssi: json["rssi"],
        primaryPhy: json["primaryPhy"],
        secondaryPhy: json["secondaryPhy"],
        timestampNanos: json["timestampNanos"],
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
