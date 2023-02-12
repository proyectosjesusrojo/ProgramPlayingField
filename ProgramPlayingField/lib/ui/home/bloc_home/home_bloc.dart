
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetScheduledFieldsEvent>((event, emit) async {
      final bool? dataExists = event.dataExists;
      final List<String>? data = event.data;
      emit(GetScheduledFieldsState(dataExists, data));
    });
  }
}
