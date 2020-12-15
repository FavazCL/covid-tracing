import 'package:covid_app/app/data/models/Handshake.dart';

class Contact {

  String id;
  int createdAt;
  List<Handshake> handshakes;
  int duration;
  int shared; // 0 False - 1 True

  Contact({ this.id, this.createdAt, this.handshakes, this.duration, this.shared });

  Contact.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      createdAt = json['date'],
      handshakes = json['handshakes'],
      duration = json['duration'],
      shared = json['shared'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'handshakes': handshakes,
    'duration': duration,
    'shared': shared
  };

}