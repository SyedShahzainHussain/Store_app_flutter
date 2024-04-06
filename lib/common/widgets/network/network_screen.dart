import 'package:flutter/material.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:restart_app/restart_app.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSized.defaultSpace),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                TImageString.noInternet,
                width: TDeviceUtils.screenWidth(context) * 0.7,
                height: TDeviceUtils.screenHeight(context) * 0.3,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              Text(
                "Ooops!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              Text(
                "Slow or no Internet connection.\n Check your internet settings.",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.red),
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final isConnect = await NetworkManager().isConnected();
                    if (isConnect) {
                      Restart.restartApp();
                    } else {
                      THelperFunction.showDelightToast(
                          "No Internet Connected", Icons.error, Colors.red);
                    }
                  },
                  child: const Text("Retry"))
            ],
          ),
        ),
      ),
    );
  }
}
