import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/brand/brand_bloc.dart';
import 'package:store/bloc/brand/brand_event.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_bloc.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/appBar/tapbar.dart';
import 'package:store/common/widgets/product_cart/product_cart_widget.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/view/store/widget/bottom_tab_bar.dart';
import 'package:store/features/shop/view/store/widget/sliver_app_bar.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/extension.dart';

import 'package:store/utils/helper/helper_function.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<BrandBloc>().add(GetBrand());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchCategoriesBloc, FetchCategoriesState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Text("Loading");
          case Status.failure:
            return Text(state.message);
          case Status.success:
            TabController tabController = TabController(
                length: state.featuresCategories.length, vsync: this);

            return Scaffold(
              backgroundColor: THelperFunction.isDarkMode(context)
                  ? TColors.black
                  : TColors.white,
              appBar: CustomAppBar(
                title: Text(
                  "Store",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                actions: [
                  ProductCartWidget(onPressed: () {}),
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) => [
                  SliverApp(
                    preferredSizeWidget: TabBars(
                        tabs: state.featuresCategories
                            .map((e) => Tab(
                                  text: e.name.capitalize(),
                                ))
                            .toList(),
                        controller: tabController),
                  ),
                ],
                body: BottomTabBarView(state: state, controller: tabController),
              ),
            );
        }
      },
    );
  }
}
