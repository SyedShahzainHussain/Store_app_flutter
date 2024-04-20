import 'package:cached_network_image/cached_network_image.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/global_context/context_utils.dart';

class THelperFunction {
  THelperFunction._();

  static Color? getColor(String value) {
    value = value.toLowerCase();
    if (value == "green") {
      return Colors.green;
    } else if (value == "red") {
      return Colors.red;
    } else if (value == "blue") {
      return Colors.blue;
    } else if (value == "purple") {
      return Colors.purple;
    } else if (value == "pink") {
      return Colors.pink;
    } else if (value == "grey") {
      return Colors.grey;
    } else if (value == "black") {
      return Colors.black;
    } else if (value == "white") {
      return Colors.white;
    } else if (value == "yellow") {
      return Colors.yellow;
    } else {
      return null;
    }
  }

  static showSnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlertDialog(
      String title, String message, BuildContext context,
      [bool isAction = false, void Function()? onPressed]) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                if (isAction)
                  ElevatedButton(
                      onPressed: onPressed, child: const Text("Delete")),
              ],
            ));
  }

  static void navigatedToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void navigatedToScreenWithPop(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (context) => false,
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static showDelightToast(String message,
      [IconData icon = Icons.info, Color color = Colors.white]) {
    DelightToastBar.removeAll();
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: const Duration(milliseconds: 3000),
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        leading: Icon(
          icon,
          size: 28,
          color: color,
        ),
        title: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    ).show(ContextUtility.navigator!.overlay!.context);
  }

  static String hideCentralCharacterEmail(String email) {
    var nameuser = email.split("@");
    var emailcharacter = email.replaceRange(
        2, nameuser[0].length, "#" * (nameuser[0].length - 2));
    return emailcharacter;
  }

  static Future<XFile?> pickgalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image;
    } else {
      return null;
    }
  }

  static showFullScreenDialog(String imageUrl) {
    Navigator.of(ContextUtility.context).push(MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSized.defaultSpace * 2,
                        horizontal: TSized.defaultSpace),
                    child: CachedNetworkImage(imageUrl: imageUrl),
                  ),
                  const SizedBox(
                    height: TSized.spacebetweenItem,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(ContextUtility.context);
                          },
                          child: const Text("Close")),
                    ),
                  )
                ],
              ),
            )));
  }

  static showToaster({required message}) {
    ScaffoldMessenger.of(ContextUtility.context).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.transparent,
        content: Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: THelperFunction.isDarkMode(ContextUtility.context)
            ? TColors.darkerGrey.withOpacity(0.9)
            : TColors.grey.withOpacity(0.9),
      ),
      child: Center(
        child: Text(
          message,
          style: Theme.of(ContextUtility.context).textTheme.labelLarge,
        ),
      ),
    )));
  }
}
