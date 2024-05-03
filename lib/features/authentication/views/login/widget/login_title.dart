import 'package:flutter/material.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';

class LoginTitle extends StatefulWidget {
  const LoginTitle({
    super.key,
  });

  @override
  State<LoginTitle> createState() => _LoginTitleState();
}

class _LoginTitleState extends State<LoginTitle>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    opacity = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: opacity,
          child: const Image(
            height: 150,
            image: AssetImage(TImageString.logo),
          ),
        ),
        FadeTransition(
          opacity: opacity,
          child: Text(
            context.localizations!.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: TSized.sm),
        FadeTransition(
          opacity: opacity,
          child: Text(
            context.localizations!.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
