import "package:flutter/cupertino.dart";
import "package:pre_assessment/view/screen/home_screen.dart";
import "package:pre_assessment/view_model/user_view_model.dart";
import "package:provider/provider.dart";

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Consumer<UserViewModel>(builder: (context, userVM, child) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Login"),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CupertinoTextField(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  controller: email,
                  placeholder: "Email",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CupertinoTextField(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  controller: password,
                  placeholder: "Password",
                  textAlign: TextAlign.center,
                ),
              ),
              CupertinoButton(
                child: const Text("Sign in"),
                onPressed: () async {
                  // Sign in with UserViewModel
                  final result = await userVM.signIn(email.text, password.text);
                  if(result && context.mounted) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
