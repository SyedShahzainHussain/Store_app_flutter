import 'package:flutter/material.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/container/t_primary_header_container.dart';
import 'package:store/common/widgets/listtile/list_tile.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          // ! Header
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              CustomAppBar(
                title: Text(
                  "Account",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white),
                ),
              ),

              // ! User Profile Card
              const TUserProdileTile(),

              const SizedBox(
                height: TSized.spacebetweenSections,
              ),
            ],
          ))
        ],
      )),
    );
  }
}
