import 'package:equatable/equatable.dart';
import 'package:store/features/shop/model/payment_model/payment_model.dart';

// ignore: must_be_immutable
class SelectedPaymentState extends Equatable {
  PaymentModel? paymentModel;

  SelectedPaymentState({this.paymentModel});

  SelectedPaymentState copyWith({PaymentModel? paymentModel}) {
    return SelectedPaymentState(
        paymentModel: paymentModel ?? this.paymentModel);
  }

  @override
  List<Object?> get props => [paymentModel];
}
