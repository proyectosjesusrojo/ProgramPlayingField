part of 'add_choose_field_bloc.dart';

@immutable
abstract class AddChooseFieldEvent extends Equatable {
  const AddChooseFieldEvent();
}

class ChooseOptionEvent extends AddChooseFieldEvent {
  final int? choose;
  final dynamic data;

  const ChooseOptionEvent(this.choose, this.data);

  @override
  List<Object?> get props => [choose, data];
}

class GetWeatherEvent extends AddChooseFieldEvent {
  const GetWeatherEvent();

  @override
  List<Object?> get props => [];
}
