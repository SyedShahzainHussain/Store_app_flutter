import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/selected_payment/selected_payment_bloc.dart';
import 'package:store/bloc/selected_payment/selected_payment_event.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/features/shop/model/payment_model/payment_model.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class PaymentTile extends StatelessWidget {
  final PaymentModel paymentModel;
  const PaymentTile({super.key, required this.paymentModel});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        context.read<SelectedPaymentBloc>().add(SelectedPayment(paymentModel));
        Navigator.pop(context);
      },
      child: ListTile(
        leading: TRoundedContainer(
          width: 60,
          height: 35,
          backgroundColor: isDark ? TColors.light : TColors.white,
          padding: const EdgeInsets.all(TSized.sm),
          child: Image(
            image: AssetImage(paymentModel.image),
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          paymentModel.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: const Icon(Iconsax.arrow_right_34),
      ),
    );
  }
}
