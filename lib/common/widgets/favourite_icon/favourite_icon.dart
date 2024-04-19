import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/favourite/favourite_bloc.dart';
import 'package:store/bloc/favourite/favourite_event.dart';
import 'package:store/bloc/favourite/favourite_state.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';

class FavouriteIcon extends StatelessWidget {
  final String productId;
  const FavouriteIcon({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return TCircularIcons(
          icon: state.favourite.containsKey(productId)
              ? Iconsax.heart5
              : Iconsax.heart,
          color: Colors.red,
          onPressed: () {
            context.read<FavouriteBloc>().add(ToggleFavourite(productId));
             context.read<FavouriteBloc>().add(GetAllFavourite());
          },
        );
      },
    );
  }
}
