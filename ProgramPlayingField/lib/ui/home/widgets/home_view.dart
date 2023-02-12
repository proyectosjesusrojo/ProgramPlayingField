import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programplayingfield/ui/global_widgets/button_widget.dart';
import 'package:programplayingfield/ui/home/screens/add_choose_field_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../bloc_home/home_bloc.dart';

late List<String>? validateDate;
bool dataExists = false;

class HomeView extends StatelessWidget {
  final bool? isDataExists;
  final List<String>? data;

  const HomeView({super.key, this.isDataExists, this.data});

  @override
  Widget build(BuildContext context) {
    final heightCurrent = MediaQuery.of(context).size.height;
    final widthCurrent = MediaQuery.of(context).size.width;
    findDataList(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryGreen,
        title: const Text("Lista de agendados"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Constants.sizeBoxSpacingHeight21),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dataExists == false)
                      SizedBox(height: heightCurrent * 0.50),
                    if (dataExists == false)
                      const Text(
                        "No hay canchas agendadas",
                        style: TextStyle(
                          fontFamily: Constants.graphik,
                          fontSize: Constants.textFont16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: Constants.wordSpacingInText,
                          color: Constants.primaryGreen,
                        ),
                      ),
                    if (dataExists == true)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data?.length ?? 0,
                        itemBuilder: (context, index) {
                          if (data?.length != null) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: heightCurrent * 0.2),
                                    Container(
                                      height: 100,
                                      width: widthCurrent * 0.85,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(40),
                                        ),
                                        border: Border.all(
                                          width: 3,
                                          color: Constants.primaryGrey,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                json.decode(data![index])[
                                                            "idField"] ==
                                                        1
                                                    ? "Cancha A"
                                                    : json.decode(data![index])[
                                                                "idField"] ==
                                                            2
                                                        ? "Cancha B"
                                                        : "Cancha C",
                                                style: const TextStyle(
                                                  fontFamily: Constants.graphik,
                                                  fontSize:
                                                      Constants.textFont12,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: Constants
                                                      .wordSpacingInText,
                                                  color: Constants.primaryGreen,
                                                ),
                                              ),
                                              Text(
                                                json.decode(
                                                    data![index])["date"],
                                                style: const TextStyle(
                                                  fontFamily: Constants.graphik,
                                                  fontSize:
                                                      Constants.textFont12,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: Constants
                                                      .wordSpacingInText,
                                                  color: Constants.primaryGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Agendada por: ${json.decode(data![index])["name"]}",
                                                style: const TextStyle(
                                                  fontFamily: Constants.graphik,
                                                  fontSize:
                                                      Constants.textFont12,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: Constants
                                                      .wordSpacingInText,
                                                  color: Constants.primaryGreen,
                                                ),
                                              ),
                                              Text(
                                                "Probabilidad de lluva ${json.decode(data![index])["cloudAVG"]}",
                                                style: const TextStyle(
                                                  fontFamily: Constants.graphik,
                                                  fontSize:
                                                      Constants.textFont12,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: Constants
                                                      .wordSpacingInText,
                                                  color: Constants.primaryGreen,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ButtonWidget(
        isCircle: true,
        icon: Icons.add,
        colorIcon: Constants.primaryWhite,
        sizeIcon: Constants.sizeIcon,
        onPress: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AddChooseFieldScreen(),
          ),
        ),
      ),
    );
  }

  findDataList(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    validateDate = prefs.getStringList('listAllData');
    validateDate != null ? dataExists = true : dataExists = false;
    BlocProvider.of<HomeBloc>(context)
        .add(GetScheduledFieldsEvent(dataExists, validateDate));
  }
}
