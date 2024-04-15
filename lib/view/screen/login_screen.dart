import "package:flutter/cupertino.dart";
import "package:pre_assessment/view/screen_template.dart";
import "package:pre_assessment/view_model/user_view_model.dart";
import "package:provider/provider.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Consumer<UserViewModel>(builder: (context, userVM, child) {
      return CupertinoPageScaffold(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 200),
              const Text(
                "🄳🄴🄼🄾",
                style: TextStyle(
                  color: CupertinoColors.systemOrange,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.mail,
                    color: CupertinoColors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 280,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      controller: email,
                      placeholder: "Email",
                      textAlign: TextAlign.center,
                      placeholderStyle: const TextStyle(
                        color: CupertinoColors.white,
                      ),
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.lock,
                    color: CupertinoColors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 280,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      controller: password,
                      placeholder: "Password",
                      textAlign: TextAlign.center,
                      placeholderStyle: const TextStyle(
                        color: CupertinoColors.white,
                      ),
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 120),
                  Container(
                    width: 96,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.systemOrange,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CupertinoButton(
                      onPressed: () async {
                        // Sign up with UserViewModel
                        final result =
                            await userVM.signUp(email.text, password.text);
                        if (result && context.mounted) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const ScreenTemplate(),
                            ),
                          );
                        } else {
                          if (context.mounted) {
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
                                          color: CupertinoColors
                                              .darkBackgroundGray,
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
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: CupertinoColors.systemOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 96,
                    height: 48,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemOrange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CupertinoButton(
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.darkBackgroundGray,
                        ),
                      ),
                      onPressed: () async {
                        // Sign in with UserViewModel
                        final result =
                            await userVM.signIn(email.text, password.text);
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
                          if (context.mounted) {
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
                                          color: CupertinoColors
                                              .darkBackgroundGray,
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
                      },
                    ),
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
