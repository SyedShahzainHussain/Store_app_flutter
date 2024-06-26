import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_state.dart';
import 'package:store/common/widgets/image/t_circular_image.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';

class TUserProdileTile extends StatelessWidget {
  const TUserProdileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchUserBloc, FetchUserState>(
      builder: (context, state) {
        if (state is FetchUserLoaded) {
                     final networkImage = state.user?.profilePicture;
            final image =
                networkImage!.isNotEmpty ? networkImage : TImageString.userImage;
          return ListTile(
            leading: TCircularImage(
              image: image,
              width: 50,
              height: 50,
              padding: 0,
              isNetworkImage: networkImage.isNotEmpty,
            ),
            title: Text(
              state.user?.fullName ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
            ),
            subtitle: Text(
              state.user?.email ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: TColors.white),
            ),
            trailing: IconButton(
                onPressed: () {
                  THelperFunction.navigatedToScreen(
                      context,RouteName.profileScreen);
                },
                icon: const Icon(
                  Iconsax.edit,
                  color: TColors.white,
                )),
          );
        } else if (state is FetchUserError) {
          return THelperFunction.showDelightToast(state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
