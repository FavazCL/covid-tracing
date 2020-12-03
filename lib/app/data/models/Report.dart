import 'package:covid_app/app/data/models/EphId.dart';

class Report {

  int reportDate;
  EphId ephId;

  Report({ this.reportDate, this.ephId });

  Report.fromJson(Map<String, dynamic> json)
    : reportDate = json['createdAt'],
      ephId = json['EphId'];

  Map<String, dynamic> toJson() => {
    'reportDate': reportDate,
    'ephId': ephId.toJson()
  };

}