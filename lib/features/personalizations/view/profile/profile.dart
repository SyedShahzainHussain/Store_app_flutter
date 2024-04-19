import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/bloc/authentication/authentication_bloc.dart';
import 'package:store/bloc/authentication/authentication_events.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_state.dart';
import 'package:store/bloc/upload_image/upload_image_bloc.dart';
import 'package:store/bloc/upload_image/upload_image_event.dart';
import 'package:store/bloc/upload_image/upload_image_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/image/t_circular_image.dart';
import 'package:store/features/personalizations/view/profile/change_name.dart';
import 'package:store/features/personalizations/view/profile/widget/profile_menu.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text("Profile"),
      ),
      body: BlocBuilder<FetchUserBloc, FetchUserState>(
        builder: (context, state) {
          if (state is FetchUserLoaded) {
            final networkImage = state.user?.profilePicture;
            final image = networkImage!.isNotEmpty
                ? networkImage
                : TImageString.userImage;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSized.defaultSpace),
                child: Column(
                  children: [
                    // ! Profile Picture
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          BlocBuilder<UploadImageBloc, UploadImageState>(
                            builder: (context, state) {
                              if (state is UploadImageLoading) {
                                return const ShimmerEffect(
                                  width: 80,
                                  height: 80,
                                  radius: 80,
                                );
                              } else {
                                return TCircularImage(
                                  isNetworkImage: networkImage.isNotEmpty,
                                  image: image,
                                  width: 80,
                                  height: 80,
                                );
                              }
                            },
                          ),
                          TextButton(
                            onPressed: () async {
                              final XFile? image =
                                  await THelperFunction.pickgalleryImage();
                              // ignore: use_build_context_synchronously
                              context
                                  .read<UploadImageBloc>()
                                  .add(UploadImage(image));
                            },
                            child: const Text("Change Profile Picture"),
                          ),
                        ],
                      ),
                    ),
                    // ! Details

                    const SizedBox(
                      height: TSized.spacebetweenItem / 2,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    // ! Heading Profile Info
                    TSectionHeading(
                      title: "Profile Information",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),

                    TProfileMenu(
                      title: "Name",
                      value: state.user?.fullName ?? "",
                      onPressed: () {
                        THelperFunction.navigatedToScreen(
                            context,
                            ChangeName(
                              firstName: state.user?.firstName ?? "",
                              lastName: state.user?.lastName ?? "",
                            ));
                      },
                    ),
                    TProfileMenu(
                      title: "Username",
                      value: state.user?.userName ?? "",
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),

                    // ! Personal Information
                    TSectionHeading(
                      title: "Personal Information",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    TProfileMenu(
                      title: "User Id",
                      value: state.user?.id ?? "",
                      icon: Iconsax.copy,
                      onPressed: () {
                        Clipboard.setData(
                                ClipboardData(text: state.user?.id ?? ""))
                            .then((value) => THelperFunction.showSnackbar(
                                "Copied to your clipboard !", context));
                      },
                    ),
                    TProfileMenu(
                      title: "E-mail",
                      value: state.user?.email ?? "",
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: "Phone Number",
                      value: state.user?.phoneNumber ?? "00000000000",
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: "Gender",
                      value: "Male",
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: "Date of Birth",
                      value: "10 Oct, 1823",
                      onPressed: () {},
                    ),
                    const Divider(),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          THelperFunction.showAlertDialog(
                              "Delete Account",
                              "Are you sure you want to delete your account permanently? This action is not reversable and all your data will be remove permanently.",
                              context,
                              true, () {
                            context
                                .read<AuthenticationBloc>()
                                .add(DeleteAccountEvent());
                          });
                        },
                        child: const Text(
                          "Close Account",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is FetchUserError) {
            return THelperFunction.showDelightToast(state.message);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
