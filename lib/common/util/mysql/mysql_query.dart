import "package:mysql1/mysql1.dart";

Future<List<Map>>? searchList(String keyword, DateTime selectedDay) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: "doboo.tplinkdns.com",
    port: 3306,
    user: "user",
    password: "2B@Dinterface",
    db: "mydb",
  ));

  var results = await conn.query("SELECT * FROM report WHERE 회의실 LIKE ?", ["%$keyword%"]);
  // var results = await conn.query(
  //     "SELECT *, Date_format(사용날짜, '%Y-%m-%d') as 날짜,(abs(TIMESTAMPDIFF(minute, 사용날짜, now())) < 60) and 신청여부 = '승인' as 시간 FROM report left join status on report.id = status.id left join tel on report.id = tel.id where 회의실 LIKE '%' and 회의실 LIKE '%' and replace(회의명, ' ', '') LIKE ? and 신청여부 LIKE '승인' and ((Date_format(사용날짜, '%H') > 12) + 1) <> ? and 사용날짜 between ? and ? order by 날짜 desc, sort, 사용날짜",
  //     ["%$keyword%"]);
  await conn.close();

  List<Map> data = [];
  for (var row in results) {
    data.add({
      "roomName": row[0],
      "useDate": row[1],
      "description": row[2],
      "departmentName": row[3],
      "applicant": row[4],
      "apply": row[5],
      "useTime": row[6],
      "sortNumber": row[7],
    });
  }

  return data;
}
