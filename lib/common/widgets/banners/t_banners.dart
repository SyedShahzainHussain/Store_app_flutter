import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_bloc.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_events.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_state.dart';
import 'package:store/common/widgets/container/t_circular_container.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/controller/home_controller.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class TBanners extends StatefulWidget {
  const TBanners({
    super.key,
  });

  @override
  State<TBanners> createState() => _TBannersState();
}

class _TBannersState extends State<TBanners> {
  @override
  void initState() {
    super.initState();
    context.read<FetchBannersBloc>().add(FetchBanners());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBannersBloc, FetchBannersState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const ShimmerEffect(width: double.infinity, height: 190,radius: TSized.cardRadiusMd,);
          case Status.failure:
            return Center(
              child: Text(state.message),
            );
          case Status.success:
            return Consumer<HomeController>(
              builder: (context, value, _) => Column(
                children: [
                  CarouselSlider(
                    items: state.bannerList
                        .map((banner) => TRoundedImage(
                              onPressed: () {},
                              imageUrl: banner.imageUrl,
                              isNetworkImage: true,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      onPageChanged: (index, _) => value.setIndex(index),
                    ),
                  ),
                  const SizedBox(
                    height: TSized.spacebetweenItem,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i <= state.bannerList.length - 1; i++)
                          TCircularBorderRadius(
                            width: 20,
                            height: 4,
                            backgroundColor: value.currentIndex == i
                                ? TColors.primary
                                : TColors.grey,
                            margin: const EdgeInsets.only(right: 5),
                          )
                      ],
                    ),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}
