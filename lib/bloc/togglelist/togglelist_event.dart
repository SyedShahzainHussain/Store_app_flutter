import 'package:equatable/equatable.dart';

sealed class ViewModeEvent extends Equatable {
  const ViewModeEvent();

  @override
  List<Object?> get props => [];
}

// Define the event for toggling the view mode
class ToggleViewModeEvent extends ViewModeEvent {
  final bool isListView;
  const ToggleViewModeEvent(this.isListView);
}
