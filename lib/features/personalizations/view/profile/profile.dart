import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/image/t_circular_image.dart';
import 'package:store/features/personalizations/view/profile/widget/profile_menu.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              // ! Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(
                      image: TImageString.userImage,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
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
                value: "Syed Shahzain",
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Username",
                value: "syed_shahzain",
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
                value: "45454",
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "E-mail",
                value: "syed_shahzain",
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Phone Number",
                value: "+92-332-2123232",
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
                  onPressed: () {},
                  child: const Text(
                    "Close Account",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
