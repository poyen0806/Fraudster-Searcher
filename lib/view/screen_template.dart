import "package:flutter/cupertino.dart";
import "package:pre_assessment/view/screen/fraud_line_id_screen.dart";
import "package:pre_assessment/view/screen/setting_screen.dart";

/// [ScreenTemplate] is a stateful widget that provides a template for a tabbed navigation.
///
/// It contains two tabs: one for [FraudLineIdScreen] and one for [SettingScreen].
class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({super.key});

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  // List of views for the tabs
  // Add any new screens here
  final view = [
    const FraudLineIdScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      // Tab bar configuration
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: "Profile",
          ),
        ],
      ),
      // Tab builder to return the appropriate view based on the selected tab
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
