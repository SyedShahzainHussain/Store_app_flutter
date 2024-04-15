import 'package:equatable/equatable.dart';

sealed class FetchCategoriesEvents extends Equatable {
  @override
  List<Object> get props => [];
}


class GetCategoriesEvent extends FetchCategoriesEvents{}