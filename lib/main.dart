import 'package:flutter/cupertino.dart';
import 'package:pre_assessment/view/page/home_page.dart';

Future<void> main() async {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}