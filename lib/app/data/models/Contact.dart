import 'dart:convert';

class Contact {

  int id;
  int createdAt;
  List<dynamic> handshakes;
  int duration;
  int shared; // 0 False - 1 True

  Contact({ this.id, this.createdAt, this.handshakes, this.duration, this.shared });

  Contact.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      createdAt = json['createdAt'],
      handshakes = jsonDecode(json['handshakes']),
      duration = json['duration'],
      shared = json['shared'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'handshakes': jsonEncode(handshakes),
    'duration': duration,
    'shared': shared
  };

}