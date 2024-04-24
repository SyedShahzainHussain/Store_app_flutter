import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/selected_payment/selected_payment_event.dart';
import 'package:store/bloc/selected_payment/selected_payment_state.dart';
import 'package:store/features/shop/model/payment_model/payment_model.dart';
import 'package:store/utils/constants/image_strings.dart';

class SelectedPaymentBloc
    extends Bloc<SelectedPaymentEvent, SelectedPaymentState> {
  SelectedPaymentBloc()
      : super(SelectedPaymentState(
            paymentModel:
                PaymentModel(image: TImageString.payPal, name: "Paypal"))) {
    on<SelectedPayment>(_selectedPayment);
  }

  _selectedPayment(SelectedPayment event, Emitter<SelectedPaymentState> emit) {
    emit(state.copyWith(paymentModel: event.paymentModel));
  }
}
