import 'package:covid_app/app/data/models/EphId.dart';

class Report {

  int reportDate;
  EphId ephId;

  Report({ this.reportDate, this.ephId });

  factory Report.fromJson(Map<dynamic, dynamic> json) => Report(
    reportDate: json['reportDate'],
      ephId: EphId.fromJson(json['ephId']
    )
  );

  Map<String, dynamic> toJson() => {
    'reportDate': reportDate,
    'ephId': ephId.toJson()
  };

}