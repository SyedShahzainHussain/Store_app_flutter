import 'package:equatable/equatable.dart';

class ViewModeState extends Equatable {
  final bool isListView;

  const ViewModeState({this.isListView = true});

  @override
  List<Object?> get props => [isListView];
}
