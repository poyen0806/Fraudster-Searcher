import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:pre_assessment/view/screen/login_screen.dart';

/// [SplashScreen] is the initial screen displayed when the app starts.
///
/// It shows an animated logo and transitions to the login screen
/// after the animation completes.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Define bounce animation
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    // Start the animation
    _controller.forward();

    // Listen for animation status changes
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _controller.dispose();
        if (mounted) {
          // Close the splash screen and navigate to the login screen
          Navigator.of(context).pop();
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Set background color
      backgroundColor: CupertinoColors.darkBackgroundGray,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Apply bounce animation to the logo
            return Transform.scale(
              scale: _bounceAnimation.value,
              child: SizedBox(
                width: 108,
                height: 108,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    // Network image URL
                    imageUrl:
                        "https://as1.ftcdn.net/v2/jpg/02/06/74/22/1000_F_206742233_sxv7K1GPkN5VaUcZwRd07gU8fQ63nhTV.jpg",
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
