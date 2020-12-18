class NotificationEphId {
  NotificationEphId({
    this.message,
    this.date,
  });

  String message;
  int date;

  factory NotificationEphId.fromJson(Map<String, dynamic> json) =>
      NotificationEphId(
        message: json["message"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "date": date,
      };
}
