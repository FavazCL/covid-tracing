class Report {

  int reportDate;
  dynamic ephId;

  Report({ this.reportDate, this.ephId });

  Report.fromJson(Map<String, dynamic> json)
    : reportDate = json['createdAt'],
      ephId = json['EphId'];

  Map<String, dynamic> toJson() => {
    'reportDate': reportDate,
    'ephId': ephId
  };

}