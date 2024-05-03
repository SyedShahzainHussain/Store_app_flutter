import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/fetch_address/fetch_address_bloc.dart';
import 'package:store/bloc/fetch_address/fetch_address_event.dart';
import 'package:store/bloc/fetch_address/fetch_address_state.dart';
import 'package:store/bloc/selected_address/selected_bloc.dart';
import 'package:store/bloc/selected_address/selected_event.dart';
import 'package:store/bloc/selected_address/selected_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/personalizations/view/address/widget/single_address.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchAddressBloc>().add(FetchAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () {
          THelperFunction.navigatedToScreen(
              context, RouteName.addNewAddressScreen);
        },
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
      appBar:  CustomAppBar(
        title: Text(context.localizations!.address),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSized.defaultSpace),
        child: BlocBuilder<FetchAddressBloc, FetchAddressState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                return const Center(
                  child: TRoundedContainer(
                    padding: EdgeInsets.all(12),
                    width: 50,
                    height: 50,
                    backgroundColor: TColors.primary,
                    showBorder: true,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 3.0,
                    ),
                  ),
                );
              case Status.failure:
                return Center(
                  child: Text(state.message),
                );
              case Status.success:
                if (state.addressList.isEmpty) {
                  return const Center(
                    child: Text("No Address Found!"),
                  );
                } else {
                  return BlocBuilder<SelectedAddressBloc, SelectedAddressState>(
                    builder: (context, state2) {
                      if (state2.status == Status.loading) {
                        return const Center(
                          child: TRoundedContainer(
                            padding: EdgeInsets.all(12),
                            width: 50,
                            height: 50,
                            backgroundColor: TColors.primary,
                            showBorder: true,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 3.0,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SingleAddress(
                              selectedAddress: state.addressList[index],
                              onTap: () {
                                context.read<SelectedAddressBloc>().add(
                                    SeletectAddress(state.addressList[index]));
                              },
                            );
                          },
                          itemCount: state.addressList.length,
                        );
                      }
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
