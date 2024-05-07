class Reservation {
  final String roomName;
  final String useDate;
  final String description;
  final String departmentName;
  final String applicant;
  final String apply;
  final String useTime;
  final String sortNumber;
  final String rid;

  Reservation(
    this.roomName,
    this.useDate,
    this.description,
    this.departmentName,
    this.applicant,
    this.apply,
    this.useTime,
    this.sortNumber,
    this.rid,
  );

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      json["roomName"],
      json["useDate"],
      json["description"],
      json["departmentName"],
      json["applicant"],
      json["apply"],
      json["useTime"],
      json["sortNumber"],
      json["rid"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "roomName": roomName,
      "useDate": useDate,
      "description": description,
      "departmentName": departmentName,
      "applicant": applicant,
      "apply": apply,
      "useTime": useTime,
      "sortNumber": sortNumber,
    };
  }
}
