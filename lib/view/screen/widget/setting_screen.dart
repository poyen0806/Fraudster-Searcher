import "package:flutter/cupertino.dart";
import "package:pre_assessment/view/screen/login_screen.dart";
import "package:pre_assessment/view_model/user_view_model.dart";
import "package:provider/provider.dart";
import "package:cached_network_image/cached_network_image.dart";

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      readOnly: true,
                      placeholder: userVM.email,
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
                      placeholder: "*" * userVM.password.toString().length,
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
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.systemOrange,
                        ),
                      ),
                      onPressed: () {
                        userVM.updateAccount(password.text);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 96,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CupertinoColors.systemOrange,
                    ),
                    child: CupertinoButton(
                      child: const Text(
                        "Sign out",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.darkBackgroundGray,
                        ),
                      ),
                      onPressed: () {
                        userVM.signOut();
                        // Push to LoginScreen
                        if (context.mounted) {
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            // Remove all route until arrive the target
                            (route) => false,
                          );
                        }
                      },
                    ),
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
