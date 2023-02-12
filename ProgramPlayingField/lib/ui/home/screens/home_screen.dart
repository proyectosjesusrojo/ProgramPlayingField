import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programplayingfield/ui/home/widgets/home_view.dart';

import '../bloc_add_choose_field/add_choose_field_bloc.dart';
import '../bloc_home/home_bloc.dart';

bool dataExists = false;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    return BlocProvider(
      create: (_) => homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetScheduledFieldsState) {
            return HomeView(isDataExists: state.dataExists, data: state.data);
          } else {
            return const HomeView();
          }
        },
      ),
    );
  }
}
