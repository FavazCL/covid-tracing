import 'dart:typed_data';

class EphId {

  int createdAt;
  Uint8List data;

  EphId({ this.createdAt, this.data });

  EphId.fromJson(Map<String, dynamic> json)
    : createdAt = json['createdAt'],
      data = Uint8List.fromList(List<int>.from(json["data"].map((x) => x)));

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt,
    'data': data
  };

  Uint8List getData() {
    return data;
  }

}