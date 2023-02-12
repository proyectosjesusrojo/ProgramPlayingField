import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:programplayingfield/ui/home/providers/api_repository.dart';

part 'add_choose_field_event.dart';

part 'add_choose_field_state.dart';

final ApiRepository _apiRepository = ApiRepository();

class AddChooseFieldBloc
    extends Bloc<AddChooseFieldEvent, AddChooseFieldState> {
  late dynamic takeAVGCloud;

  AddChooseFieldBloc() : super(AddChooseFieldInitial()) {
    on<ChooseOptionEvent>((event, emit) async {
      final int? choose = event.choose;
      final dynamic data = event.data;
      emit(ChooseOptionState(choose, data));
    });

    on<GetWeatherEvent>((event, emit) async {
      try {
        takeAVGCloud =
        await _apiRepository.getWeatherData();
        emit(GetWeatherState(takeAVGCloud));
      } on NetworkError {
        debugPrint("problem with the server.");
      }
    });
  }
}
