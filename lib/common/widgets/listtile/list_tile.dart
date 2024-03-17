import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/image/t_circular_image.dart';
import 'package:store/features/personalizations/view/profile/profile.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/helper/helper_function.dart';

class TUserProdileTile extends StatelessWidget {
  const TUserProdileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        image: TImageString.userImage,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        "Syed Shahzain",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        "Abc@gmail.com",
        style:
            Theme.of(context).textTheme.bodySmall!.apply(color: TColors.white),
      ),
      trailing: IconButton(
          onPressed: () {
            THelperFunction.navigatedToScreen(context, const ProfileScreen());
          },
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          )),
    );
  }
}
