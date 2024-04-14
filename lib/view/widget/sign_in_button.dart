import 'package:flutter/cupertino.dart';
import 'package:pre_assessment/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userVM, child) {
        return CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text(
            (userVM.user == null) ? "Sign in with Line" : "Hi, ${userVM.user!.name}",
            style: const TextStyle(
              color: CupertinoColors.white,
            ),
          ),
          onPressed: () async {
            await userVM.signInWithLine();
          },
        );
      },
    );
  }
}
