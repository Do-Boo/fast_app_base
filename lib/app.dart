// 필요한 패키지들을 가져옵니다.
import "package:fast_app_base/common/common.dart";
import "package:fast_app_base/common/theme/custom_theme_app.dart";
import "package:fast_app_base/screen/main/s_main.dart";
import "package:flutter/material.dart";
import 'common/theme/custom_theme.dart';

// App 클래스는 StatefulWidget을 상속받습니다. StatefulWidget은 변경 가능한 상태를 가진 위젯을 만들 때 사용합니다.
class App extends StatefulWidget {
  // GlobalKey는 위젯 트리 전체에서 직접 특정 위젯에 액세스할 수 있게 해주는 역할을 합니다.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // 앱의 기본 테마를 설정합니다. 이 경우에는 CustomTheme.light가 기본값입니다.
  static const defaultTheme = CustomTheme.light;

  // 앱이 현재 포그라운드에 있는지(사용자에게 보이는 상태인지) 아닌지를 나타내는 플래그입니다.
  static bool isForeground = true;

  const App({super.key});

  // StatefulWidget은 createState() 메서드를 반드시 구현해야 합니다. 이 메서드는 위젯의 상태를 만들어냅니다.
  @override
  State<App> createState() => AppState();
}

// AppState 클래스는 State<App>을 상속받습니다. 이 클래스에서는 앱의 상태를 관리합니다.
class AppState extends State<App> with Nav, WidgetsBindingObserver {
  // navigatorKey를 반환하는 getter입니다.
  @override
  GlobalKey<NavigatorState> get navigatorKey => App.navigatorKey;

  // initState() 메서드는 위젯이 초기화될 때 한 번만 호출됩니다. 여기서는 WidgetsBindingObserver를 추가하고 있습니다.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // dispose() 메서드는 위젯이 제거될 때 호출됩니다. 여기서는 WidgetsBindingObserver를 제거하고 있습니다.
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // build() 메서드는 위젯의 UI를 만들어냅니다. 여기서는 MaterialApp 위젯을 반환하고 있습니다.
  @override
  Widget build(BuildContext context) {
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return MaterialApp(
          navigatorKey: App.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Image Finder',
          theme: context.themeType.themeData,
          home: const MainScreen(),
        );
      }),
    );
  }

  // didChangeAppLifecycleState() 메서드는 앱의 생명주기 상태가 변경될 때마다 호출됩니다.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        App.isForeground = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        App.isForeground = false;
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden: //Flutter 3.13 이하 버전을 쓰신다면 해당 라인을 삭제해주세요.
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
