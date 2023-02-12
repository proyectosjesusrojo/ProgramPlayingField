part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetScheduledFieldsEvent extends HomeEvent {
  final bool? dataExists;
  final List<String>? data;

  const GetScheduledFieldsEvent(this.dataExists, this.data);

  @override
  List<Object?> get props => [dataExists, data];
}
