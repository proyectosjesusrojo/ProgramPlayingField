import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programplayingfield/ui/home/widgets/add_choose_field_view.dart';

import '../bloc_add_choose_field/add_choose_field_bloc.dart';

class AddChooseFieldScreen extends StatelessWidget {
  const AddChooseFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddChooseFieldBloc addChooseBloc = AddChooseFieldBloc();
    addChooseBloc.add(const GetWeatherEvent());
    return BlocProvider(
      create: (_) => addChooseBloc,
      child: BlocBuilder<AddChooseFieldBloc, AddChooseFieldState>(
        builder: (context, state) {
          if (state is ChooseOptionState) {
            return AddChooseFieldView(
              choose: state.choose,
              data: state.data,
            );
          } else if (state is GetWeatherState) {
            return AddChooseFieldView(
              data: state.data.current.cloudcover,
            );
          } else {
            return const AddChooseFieldView();
          }
        },
      ),
    );
  }
}
