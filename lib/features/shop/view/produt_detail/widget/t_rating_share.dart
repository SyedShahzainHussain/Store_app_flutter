import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/utils/constants/size.dart';

class TRatingShare extends StatelessWidget {
  const TRatingShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ! Rating
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(
              width: TSized.spacebetweenItem / 2,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "5.0 ",
                      style: Theme.of(context).textTheme.bodyLarge),
                  const TextSpan(
                    text: "(199)",
                  ),
                ],
              ),
            )
          ],
        ),
        // ! Share Button
        TextButton(
          onPressed: () {},
          child: const Icon(Icons.share, size: TSized.iconMd),
        )
      ],
    );
  }
}
