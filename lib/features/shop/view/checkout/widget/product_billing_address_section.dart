import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_address/fetch_address_bloc.dart';
import 'package:store/bloc/fetch_address/fetch_address_event.dart';
import 'package:store/bloc/fetch_address/fetch_address_state.dart';
import 'package:store/bloc/selected_address/selected_bloc.dart';
import 'package:store/bloc/selected_address/selected_state.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductBillingAddressSection extends StatefulWidget {
  const ProductBillingAddressSection({super.key});

  @override
  State<ProductBillingAddressSection> createState() =>
      _ProductBillingAddressSectionState();
}

class _ProductBillingAddressSectionState
    extends State<ProductBillingAddressSection> {
  @override
  void initState() {
    super.initState();
    context.read<FetchAddressBloc>().add(FetchAddress());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAddressBloc, FetchAddressState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Text("Loading");
        } else if (state.status == Status.failure) {
          return Text(state.message);
        } else {
          return BlocBuilder<SelectedAddressBloc, SelectedAddressState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    title: "Shopping Address",
                    buttontitle: "Change",
                    onPressed: () async {
                      await THelperFunction.showAddressDialog();
                    },
                  ),
                  Text(
                    state.status == Status.loading
                        ? "Loading"
                        : state.isAddressSeleted?.name ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: TSized.spacebetweenItem / 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: TSized.spacebetweenItem,
                      ),
                      Text(
                        state.status == Status.loading
                            ? "Loading"
                            : '+92-${state.isAddressSeleted!.phoneNumber}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: TSized.spacebetweenItem / 2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_history,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: TSized.spacebetweenItem,
                      ),
                      Flexible(
                        child: Text(
                          state.status == Status.loading
                              ? "Loading"
                              : '${state.isAddressSeleted!.postalCode} ${state.isAddressSeleted!.street} ${state.isAddressSeleted!.city} ${state.isAddressSeleted!.country}',
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}
