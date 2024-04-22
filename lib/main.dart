import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pre_assessment/firebase_options.dart';
import 'package:pre_assessment/view/screen/splash_screen.dart';
import 'package:pre_assessment/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

/// [Main] entry point of the application.
///
/// Initializes Flutter widgets mechanism and Firebase.
/// Configures providers for application state management.
Future<void> main() async {
  // Ensure the mechaism of Flutter widgets is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(
    // MultiProvider provides access to multiple providers.
    MultiProvider(
      providers: [
        // Provider for UserViewModel to manage user-related state.
        ChangeNotifierProvider<UserViewModel>(
          create: (_) => UserViewModel(),
        ),
        // Add any new view models or providers here.
      ],
      child: const Main(),
    ),
  );
}

/// [Main] is the root widget of the application.
///
/// Sets up the initial screen and theme.
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      // Disable debug banner
      debugShowCheckedModeBanner: false,
      // Set SplashScreen as the initial screen
      home: SplashScreen(),
      // Define the app's theme
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
        primaryColor: CupertinoColors.systemOrange,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}
