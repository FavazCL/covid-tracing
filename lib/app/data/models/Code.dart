import 'package:cloud_firestore/cloud_firestore.dart';

class Code {
    Code({
        this.id,
        this.available,
        this.value,
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
        "available": available,
        "value": value,
    };
}
