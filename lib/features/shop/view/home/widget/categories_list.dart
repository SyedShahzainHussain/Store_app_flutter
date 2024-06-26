import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_bloc.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_event.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_state.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/view/home/widget/t_vertical_image_text.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';
import 'package:store/utils/shimmer/category_shimmer.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    super.initState();
    context.read<FetchCategoriesBloc>().add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localizations.localeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        left: localization.languageCode == "en" ? TSized.defaultSpace : 0.0,
        right: localization.languageCode == "en" ? 0.0 : TSized.defaultSpace,
      ),
      child: BlocBuilder<FetchCategoriesBloc, FetchCategoriesState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const CategoryShimmer();
            case Status.failure:
              return Center(
                child: Text(state.message),
              );
            case Status.success:
              return SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => TVerticalImageText(
                    onTap: () => THelperFunction.navigatedToScreen(
                      context,
                      RouteName.subCategory,
                      arguments: state.featuresCategories[index],
                    ),
                    image: state.featuresCategories[index].image,
                    title: state.featuresCategories[index].name.capitalize(),
                  ),
                  itemCount: state.featuresCategories.length,
                ),
              );
          }
        },
      ),
    );
  }
}
