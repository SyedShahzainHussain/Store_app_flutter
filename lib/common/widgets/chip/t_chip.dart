import 'package:flutter/material.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helper/helper_function.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunction.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        backgroundColor: isColor ? THelperFunction.getColor(text) : null,
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        avatar: isColor
            ? TRoundedContainer(
                backgroundColor: THelperFunction.getColor(text),
                width: 50,
                height: 50,
              )
            : null,
        shape: isColor ? const CircleBorder() : null,
      ),
    );
  }
}
