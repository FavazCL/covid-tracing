import 'package:covid_app/app/data/models/Handshake.dart';

class Contact {

  String id;
  int createdAt;
  List<Handshake> handshakes;
  int duration;

  Contact({ this.id, this.createdAt, this.handshakes, this.duration });

  Contact.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      createdAt = json['date'],
      handshakes = json['handshakes'],
      duration = json['duration'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'handshakes': handshakes,
    'duration': duration
  };

}