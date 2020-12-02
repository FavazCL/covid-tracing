import 'EphId.dart';

class Report {

  DateTime reportDate;
  EphId ephId;

  Report({ this.reportDate, this.ephId });

  Report.fromJson(Map<String, dynamic> json)
    : reportDate = DateTime(json['createdAt']),
      ephId = EphId.fromJson(json['EphId']);

  Map<String, dynamic> toJson() => {
    'reportDate': reportDate,
    'ephId': ephId
  };

}