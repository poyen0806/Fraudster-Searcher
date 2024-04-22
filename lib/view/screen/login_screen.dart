import "package:flutter/cupertino.dart";
import "package:pre_assessment/view/screen_template.dart";
import "package:pre_assessment/view/widget/auth_button.dart";
import "package:pre_assessment/view/widget/text_field_with_icon.dart";
import "package:pre_assessment/view_model/user_view_model.dart";
import "package:provider/provider.dart";

/// [LoginScreen] displays the login UI for the application.
///
/// It provides text fields for email and password input,
/// and buttons to sign up or sign in.
///
/// The screen uses the [Consumer] widget to listen to changes
/// in the [UserViewModel] for user authentication.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // If authentication is successful, navigate to the home screen.
  // Otherwise, display an error dialog.
  void handleAuthResult(
    BuildContext context,
    UserViewModel userVM,
    bool result,
    TextEditingController email,
    TextEditingController password,
  ) {
    if (result && context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ScreenTemplate(),
        ),
      );
    } else {
      email.clear();
      password.clear();
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              userVM.error,
              style: const TextStyle(
                color: CupertinoColors.darkBackgroundGray,
                fontSize: 16,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: CupertinoColors.darkBackgroundGray,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Text editing controllers for email and password fields
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Consumer<UserViewModel>(builder: (context, userVM, child) {
      return CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 200),
              // Application logo
              const Text(
                "🄳🄴🄼🄾",
                style: TextStyle(
                  color: CupertinoColors.systemOrange,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100),
              // Email input field
              TextFieldWithIcon(
                icon: CupertinoIcons.mail,
                placeholder: "Email",
                controller: email,
              ),
              const SizedBox(height: 24),
              // Password input field
              TextFieldWithIcon(
                icon: CupertinoIcons.lock,
                placeholder: "Password",
                controller: password,
              ),
              const SizedBox(height: 24),
              // Sign up and sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 120),
                  // Sign up button
                  AuthButton(
                    text: "Sign up",
                    onPressed: () async {
                      final result = await userVM.signUp(
                        email.text,
                        password.text,
                      );
                      if (context.mounted) {
                        handleAuthResult(
                          context,
                          userVM,
                          result,
                          email,
                          password,
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  // Sign in button
                  AuthButton(
                    text: "Sign in",
                    onPressed: () async {
                      final result = await userVM.signIn(
                        email.text,
                        password.text,
                      );
                      if (context.mounted) {
                        handleAuthResult(
                          context,
                          userVM,
                          result,
                          email,
                          password,
                        );
                      }
                    },
                    color: CupertinoColors.systemOrange,
                    textColor: CupertinoColors.darkBackgroundGray,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
