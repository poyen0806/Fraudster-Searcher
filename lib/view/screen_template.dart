import 'package:flutter/cupertino.dart';
import 'package:pre_assessment/view/screen/widget/fraud_line_id_screen.dart';
import 'package:pre_assessment/view/screen/widget/setting_screen.dart';

class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({super.key});

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  final view = [
    const FraudLineIdScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              child: view[index],
            );
          },
        );
      },
    );
  }
}
