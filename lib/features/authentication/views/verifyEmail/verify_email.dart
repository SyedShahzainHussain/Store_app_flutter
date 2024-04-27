import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/authentication/authentication_bloc.dart';
import 'package:store/bloc/authentication/authentication_events.dart';
import 'package:store/bloc/authentication/authentication_state.dart';
import 'package:store/bloc/verification/verification_bloc.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/common/widgets/success_screen/success_screen.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/helper/helper_function.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    super.initState();
    context.read<VerificationBloc>().add(SendEmailVerificationIntial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                AuthenticationRepository().logout();
              },
              icon: const Icon(CupertinoIcons.clear),
            )
          ],
        ),
        body: PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            if (didPop) {
              AuthenticationRepository().logout();
            }
          },
          child: MultiBlocListener(
            listeners: [
              BlocListener<VerificationBloc, VerificationState>(
                listener: (context, state) {
                  if (state is VerificationSent) {
                    THelperFunction.showDelightToast("Email Verification Sent",
                        Iconsax.copy_success, Colors.green);
                  } else if (state is VerificationComplete) {
                    Navigator.push(
                      ContextUtility.context,
                      MaterialPageRoute(
                        builder: (_) => SuccessScreen(
                            image: TImageString.verificationJson,
                            onPressed: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(CheckAuthentication());
                            },
                            title:
                                context.localizations!.yourAccountCreatedTitle,
                            subTitle: context
                                .localizations!.yourAccountCreatedSubTitle),
                      ),
                    );
                  } else if (state is VerificationError) {
                    THelperFunction.showDelightToast(
                        state.message, Icons.error, Colors.red);
                  }
                },
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticatedVerified) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BottomNavigationScreen()),
                        (route) => false);
                  } else if (state is UnAuthenticatedVerified) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => VerifyEmail(
                                  email: FirebaseAuth
                                          .instance.currentUser?.email ??
                                      "",
                                )),
                        (route) => false);
                  }
                },
              ),
            ],
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSized.defaultSpace),
                child: Column(
                  children: [
                    // ! Image
                    Image(
                      width: TDeviceUtils.screenWidth(context) * 0.6,
                      image: const AssetImage(
                        TImageString.deleiveredImage,
                      ),
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenSections,
                    ),

                    // ! Title & Subtitle

                    Text(
                      context.localizations!.confirmEmail,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    Text(
                      THelperFunction.hideCentralCharacterEmail(widget.email),
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    Text(
                      context.localizations!.confirmEmailSubTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenSections,
                    ),

                    // ! Button

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<VerificationBloc>()
                              .add(CheckEmailVerifiedEvent());
                        },
                        child:
                            Text(context.localizations!.continues.capitalize()),
                      ),
                    ),

                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<VerificationBloc>()
                              .add(SendEmailVerificationEvent());
                        },
                        child: Text(context.localizations!.resendEmail),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
