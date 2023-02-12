part of 'add_choose_field_bloc.dart';

@immutable
abstract class AddChooseFieldState extends Equatable {
  const AddChooseFieldState();
}

class AddChooseFieldInitial extends AddChooseFieldState {
  @override
  List<Object?> get props => [];
}

class ChooseOptionState extends AddChooseFieldState {
  final int? choose;
  final dynamic data;

  const ChooseOptionState(this.choose, this.data);

  @override
  List<Object?> get props => [choose, data];
}

class GetWeatherState extends AddChooseFieldState {
  final dynamic data;

  const GetWeatherState(this.data);

  @override
  List<Object?> get props => [data];
}
