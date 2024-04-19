import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/google/google_bloc.dart';
import 'package:store/bloc/google/google_events.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SoicalButton extends StatelessWidget {
  const SoicalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {
                context.read<GoogleAuthBloc>().add(GoogleAuthLoginEvents());
              },
              icon: const Image(
                  height: TSized.iconMd,
                  width: TSized.iconMd,
                  image: AssetImage(TImageString.google)),
            )),
        const SizedBox(
          width: TSized.spacebetweenItem,
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {
                 FacebookAuth.instance.login(
                  permissions: ["public_profile", "email"]).then((value) {
                  FacebookAuth.instance.getUserData().then((userData) async {
                  }).onError((error, stackTrace) {
                  });
                });
              },
              icon: const Image(
                  height: TSized.iconMd,
                  width: TSized.iconMd,
                  image: AssetImage(TImageString.facebook)),
            ))
      ],
    );
  }
}
