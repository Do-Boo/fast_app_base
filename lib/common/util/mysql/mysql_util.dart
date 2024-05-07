import "package:flutter/foundation.dart";
import "package:mysql1/mysql1.dart";

Future<MySqlConnection?> getConnection() async {
  if (kDebugMode) {
    print("Connecting to mysql server...");

    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: "doboo.tplinkdns.com",
      port: 3306,
      user: "user",
      password: "2B@Dinterface",
      db: 'mydb',
    ));

    print("Connected");

    await conn.close();
  }
  return null;
}
