import 'package:flutter/material.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';
import 'package:store/features/shop/view/home/widget/t_vertical_image_text.dart';
import 'package:store/utils/constants/size.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: TSized.defaultSpace),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => TVerticalImageText(
            onTap: () => categories[index].onTap!(context),
            image: categories[index].image,
            title: categories[index].title,
          ),
          itemCount: categories.length,
        ),
      ),
    );
  }
}
