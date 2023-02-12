part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

class GetScheduledFieldsState extends HomeState {
  final bool? dataExists;
  final List<String>? data;

  const GetScheduledFieldsState(this.dataExists, this.data);

  @override
  List<Object?> get props => [dataExists, data];
}
