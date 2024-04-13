import 'package:flutter_bloc/flutter_bloc.dart';
import 'togglelist_state.dart';
import 'togglelist_event.dart';

class ViewModeBloc extends Bloc<ViewModeEvent, ViewModeState> {
  ViewModeBloc() : super(const ViewModeState()) {
    on<ToggleViewModeEvent>((event, emit) {
      // Toggle between list and grid modes

      emit(ViewModeState(isListView: event.isListView));
    });
  }
}
