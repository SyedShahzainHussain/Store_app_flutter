import 'package:store/features/shop/model/payment_model/payment_model.dart';

sealed class SelectedPaymentEvent {}

class SelectedPayment extends SelectedPaymentEvent {
  PaymentModel paymentModel;
  SelectedPayment(this.paymentModel);
}
