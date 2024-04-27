import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_bloc.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_events.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_state.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/data/status/status.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/shimmer/shimmer.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class TBanners extends StatefulWidget {
  const TBanners({
    super.key,
  });

  @override
  State<TBanners> createState() => _TBannersState();
}

class _TBannersState extends State<TBanners> {
  final List<double> imageRotations = [
    0.0,
    -0.2,
    0.2,
  ];
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
            return const ShimmerEffect(
              width: double.infinity,
              height: 190,
              radius: TSized.cardRadiusMd,
            );
          case Status.failure:
            return Center(
              child: Text(state.message),
            );
          case Status.success:
            return SizedBox(
                width: TDeviceUtils.screenWidth(context) * .8 + 20,
                height: TDeviceUtils.screenHeight(context) / 4 + 10,
                child: AppinioSwiper(
                  swipeOptions:
                      const SwipeOptions.only(left: true, right: true),
                  backgroundCardOffset: const Offset(0, 20),
                  loop: true,
                  cardBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.topCenter,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateZ(imageRotations[index]),
                          child: TRoundedImage(
                            imageUrl: state.bannerList[index].imageUrl,
                            isNetworkImage:
                                state.bannerList[index].imageUrl.isNotEmpty,
                          ),
                        ));
                  },
                  cardCount: state.bannerList.length,
                ));
        }
      },
    );
  }
}
