import 'package:flutter/material.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/features/shop/view/orders/widget/order_list_item.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            Text(context.localizations!.order, style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSized.defaultSpace),
        // ! Orders
        child: OrderListItems(),
      ),
    );
  }
}
