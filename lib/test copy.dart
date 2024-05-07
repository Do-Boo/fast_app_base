// 메모 리스트 출력
import 'package:fast_app_base/common/util/mysql/mysql_query.dart';
import 'package:flutter/foundation.dart';

Future<void> getMemoList() async {
  if (kDebugMode) {
    List memoList = [];
    // DB에서 메모 정보 호출
    var results = await listUpdate();

    print(results?.length);

    // 메모 리스트 저장
    for (final row in results) {
      var memoInfo = {
        "roomName": row[0],
        "useDate": row[1],
        "description": row[2],
        "departmentName": row[3],
        "applicant": row[4],
        "apply": row[5],
        "useTime": row[6],
        "sortNumber": row[7],
      };
      memoList.add(memoInfo);
    }

    print(memoList);
    context.read<MemoUpdator>().updateList(memoList);
  }
}
