import 'dart:typed_data';

import 'package:meta/meta.dart';

class Seed {
    Seed({
        @required this.createdAt,
        @required this.seedList,
    });

    final DateTime createdAt;
    final Uint8List seedList;

    factory Seed.fromJson(Map<String, dynamic> json) => Seed(
        createdAt: json["createdAt"],
        seedList: List<dynamic>.from(json["seedList"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "seedList": List<dynamic>.from(seedList.map((x) => x)),
    };
}
