import 'package:mysql1/mysql1.dart';

Future<List<Map>>? searchList(String keyword) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: "doboo.tplinkdns.com",
    port: 3306,
    user: "user",
    password: "2B@Dinterface",
    db: 'mydb',
  ));

  var results = await conn.query('SELECT * FROM report WHERE 회의실 LIKE ?', ['%$keyword%']);
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
