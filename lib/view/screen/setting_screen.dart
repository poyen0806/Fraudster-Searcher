import "package:flutter/cupertino.dart";
import "package:pre_assessment/view/screen/login_screen.dart";
import "package:pre_assessment/view/widget/auth_button.dart";
import "package:pre_assessment/view/widget/text_field_with_icon.dart";
import "package:pre_assessment/view_model/user_view_model.dart";
import "package:provider/provider.dart";
import "package:cached_network_image/cached_network_image.dart";

/// [SettingScreen] is a screen for user settings.
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller for email and password fields
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Consumer<UserViewModel>(
      builder: (context, userVM, child) => SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 64,
              ),
              GestureDetector(
                onTap: () async {
                  // TODO: Change the user"s photo
                },
                child: SizedBox(
                  width: 108,
                  height: 108,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: userVM.photoUrl != null
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: userVM.photoUrl,
                          )
                        : const Icon(CupertinoIcons.person),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              // Email field
              TextFieldWithIcon(
                icon: CupertinoIcons.mail,
                controller: email,
                readOnly: true,
                placeholder: userVM.email ?? "",
              ),
              const SizedBox(height: 24),
              // Password field
              TextFieldWithIcon(
                icon: CupertinoIcons.lock,
                controller: password,
                placeholder: "*" * userVM.password.toString().length,
              ),
              const SizedBox(height: 24),
              // Update and Sign out buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 120),
                  AuthButton(
                    text: "Update",
                    onPressed: () {
                      userVM.updateAccount(password.text);
                      password.clear();
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                "Update Successfully",
                                style: TextStyle(
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
                          });
                    },
                  ),
                  const SizedBox(width: 16),
                  AuthButton(
                    text: "Sign out",
                    color: CupertinoColors.systemOrange,
                    textColor: CupertinoColors.darkBackgroundGray,
                    onPressed: () {
                      userVM.signOut();
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                          CupertinoPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
