// 필요한 패키지들을 가져옵니다.
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// 앱과 관련된 파일들을 가져옵니다.
import 'app.dart';
import 'common/data/preference/app_preferences.dart';

// 앱의 시작점인 main 함수입니다.
void main() async {
  // Flutter 엔진이 초기화되도록 합니다.
  final bindings = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: bindings);

  // EasyLocalization 패키지를 초기화합니다. 이 패키지는 앱의 다국어 지원을 돕습니다.
  await EasyLocalization.ensureInitialized();

  // 앱의 선호 설정을 초기화합니다.
  await AppPreferences.init();

  // 앱을 실행합니다. 여기서 EasyLocalization 위젯을 사용하여 앱의 다국어 지원을 설정합니다.
  runApp(EasyLocalization(
      // 지원하는 로케일을 설정합니다. 여기서는 영어와 한국어를 지원하도록 설정하였습니다.
      supportedLocales: const [Locale('en'), Locale('ko')],

      // 기본 로케일을 설정합니다. 여기서는 영어를 기본으로 설정하였습니다.
      fallbackLocale: const Locale('en'),

      // 번역 파일이 저장된 경로를 설정합니다.
      path: 'assets/translations',

      // 언어 코드만 사용하도록 설정합니다.
      useOnlyLangCode: true,

      // 앱의 루트 위젯을 설정합니다.
      child: const App()));
}
