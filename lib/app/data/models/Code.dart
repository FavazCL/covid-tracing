import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Code {
    Code({
        @required this.id,
        @required this.available,
        @required this.value,
    });

    String id;
    bool available;
    String value;

    Code.fromDocumentSnapshot(DocumentSnapshot doc) {
      id = doc.id;
      available = doc["available"];
      value = doc["value"];
    }

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
