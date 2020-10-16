import 'package:meta/meta.dart';

class Code {
    Code({
        @required this.id,
        @required this.available,
        @required this.value,
    });

    final int id;
    final bool available;
    final String value;

    factory Code.fromJson(Map<String, dynamic> json) => Code(
        id: json["id"],
        available: json["available"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "available": available,
        "value": value,
    };
}
