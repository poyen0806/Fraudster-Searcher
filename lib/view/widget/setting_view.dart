import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pre_assessment/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // TODO: Change the user's photo
                },
                child: SizedBox(
                  width: 108,
                  height: 108,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: userVM.photoUrl,
                      errorWidget: (context, url, error) {
                        if (kDebugMode) {
                          print(error);
                        }
                        return const Icon(
                          CupertinoIcons.person,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
