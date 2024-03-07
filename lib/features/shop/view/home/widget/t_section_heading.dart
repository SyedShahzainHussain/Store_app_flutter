
import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';

// ignore: must_be_immutable
class TSectionHeading extends StatelessWidget {
  
  final Color? textColor;
  bool showActionButton;
  final String? title, buttontitle;
  final void Function()? onPressed;
  TSectionHeading(
      {super.key,
      this.textColor,
      this.showActionButton = true,
      this.title,
      this.buttontitle = "View All",
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(left: TSized.defaultSpace),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title!,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (showActionButton)
                TextButton(onPressed: () {}, child: Text(buttontitle!))
            ],
          )
        ],
      ),
    );
  }
}
