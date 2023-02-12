import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programplayingfield/ui/home/bloc_add_choose_field/add_choose_field_bloc.dart';
import 'package:programplayingfield/ui/home/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../global_widgets/button_widget.dart';
import 'home_view.dart';

int? soccerID = 1;
int? basketID = 2;
int? tennisID = 3;
int count = 0;
int? choosed;
List<String> listValidateCount = [];
List<String> listAllData = [];
Map<String, dynamic> listDate = {
  "date": "",
  "idField": 0,
  "name": "",
  "cloudAVG": ""
};
Map<String, dynamic> validateCount = {"date": "", "count": 0};
DateTime currentDate = DateTime.now();
final TextEditingController _controllerName = TextEditingController();

class AddChooseFieldView extends StatelessWidget {
  final int? choose;
  final dynamic data;

  const AddChooseFieldView({super.key, this.choose, this.data});

  @override
  Widget build(BuildContext context) {
    final heightCurrent = MediaQuery.of(context).size.height;
    final widthCurrent = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Constants.primaryWhite),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          ),
        ),
        backgroundColor: Constants.primaryGreen,
        title: const Text("Agendar mi cancha"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: heightCurrent * 0.20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                "Futball",
                style: TextStyle(
                  fontFamily: Constants.graphik,
                  fontSize: Constants.textFont12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: Constants.wordSpacingInText,
                  color: Constants.primaryGreen,
                ),
              ),
              Text(
                "Baloncesto",
                style: TextStyle(
                  fontFamily: Constants.graphik,
                  fontSize: Constants.textFont12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: Constants.wordSpacingInText,
                  color: Constants.primaryGreen,
                ),
              ),
              Text(
                "Tenis",
                style: TextStyle(
                  fontFamily: Constants.graphik,
                  fontSize: Constants.textFont12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: Constants.wordSpacingInText,
                  color: Constants.primaryGreen,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: choose == 1
                            ? Constants.primaryGrey
                            : Constants.primaryWhite,
                        width: 4),
                  ),
                  width: 70,
                  height: 150,
                  child: const Image(
                    image: AssetImage("assets/images/field_soccer.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                onTap: () {
                  choosed = soccerID;
                  BlocProvider.of<AddChooseFieldBloc>(context)
                      .add(ChooseOptionEvent(choosed, data));
                },
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: choose == 2
                            ? Constants.primaryGrey
                            : Constants.primaryWhite,
                        width: 4),
                  ),
                  width: 70,
                  height: 150,
                  child: const Image(
                    image: AssetImage("assets/images/field_basket.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                onTap: () {
                  choosed = basketID;
                  BlocProvider.of<AddChooseFieldBloc>(context)
                      .add(ChooseOptionEvent(choosed, data));
                },
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: choose == 3
                            ? Constants.primaryGrey
                            : Constants.primaryWhite,
                        width: 4),
                  ),
                  width: 70,
                  height: 150,
                  child: const Image(
                    image: AssetImage("assets/images/field_tennis.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                onTap: () {
                  choosed = tennisID;
                  BlocProvider.of<AddChooseFieldBloc>(context)
                      .add(ChooseOptionEvent(choosed, data));
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                "A",
                style: TextStyle(
                  fontFamily: Constants.graphik,
                  fontSize: Constants.textFont12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: Constants.wordSpacingInText,
                  color: Constants.primaryGreen,
                ),
              ),
              Text(
                "B",
                style: TextStyle(
                  fontFamily: Constants.graphik,
                  fontSize: Constants.textFont12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: Constants.wordSpacingInText,
                  color: Constants.primaryGreen,
                ),
              ),
              Text(
                "C",
                style: TextStyle(
                  fontFamily: Constants.graphik,
                  fontSize: Constants.textFont12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: Constants.wordSpacingInText,
                  color: Constants.primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: ButtonWidget(
        isCircle: false,
        widthButton: widthCurrent * 0.80,
        descriptionBtn: "Agendar Cancha",
        colorIcon: Constants.primaryWhite,
        sizeIcon: Constants.sizeIcon,
        onPress: () async {
          DateTime? dateSelect = await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: currentDate,
            lastDate: DateTime(2200),
          );
          if (dateSelect != null) {
            onShowSnackBar(
                context, "Porcentaje de lluvia para ese dia $data %");
            final prefs = await SharedPreferences.getInstance();
            final String dateChoose =
                "${dateSelect.day}-${dateSelect.month}-${dateSelect.year}";
            final List<String>? validateDate =
                prefs.getStringList('listAllData');
            final List<String>? validateCount =
                prefs.getStringList('listValidateCount');
            if (validateDate == null) {
              count = count + 1;
              _showTransparentDialog(context, dateChoose, choose);
            } else {
              validateDate.asMap().forEach((idx, val) async {
                if (json.decode(val)["date"] ==
                    "${dateSelect.day}-${dateSelect.month}-${dateSelect.year}") {
                  if (json.decode(val)["idField"] == choose) {
                    if (count >= 3) {
                      onShowSnackBar(context,
                          "No hay disponibilidad para agendar\n en este dia, porfavor seleccione otro");
                    } else {
                      if (count < 3) {
                        count = count + 1;
                        _showTransparentDialog(context, dateChoose, choose);
                      }
                    }
                  } else {
                    count = count + 1;
                    _showTransparentDialog(context, dateChoose, choose);
                  }
                } else {
                  count = count + 1;
                  _showTransparentDialog(context, dateChoose, choose);
                }
              });
            }
          } else {
            return;
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<dynamic> _showTransparentDialog<T>(
      BuildContext context, String? dateChoose, int? choose) async {
    await Future.delayed(const Duration(seconds: 3), () async {
      final heightCurrent = MediaQuery.of(context).size.height;
      final widthCurrent = MediaQuery.of(context).size.width;
      return await showDialog<T>(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              height: heightCurrent * 0.30,
              width: widthCurrent * 0.20,
              color: Constants.primaryWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Constants.sizeBoxSpacingHeight10),
                  const Center(
                    child: Text(
                      "Ingrese su nombre",
                      style: TextStyle(
                        fontFamily: Constants.graphik,
                        fontSize: Constants.textFont16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: Constants.wordSpacingInText,
                        color: Constants.primaryGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.sizeBoxSpacingHeight10),
                  Center(
                    child: SizedBox(
                      width: widthCurrent * 0.50,
                      child: TextFormField(
                        controller: _controllerName,
                        style: const TextStyle(
                          color: Constants.primaryGreen,
                          fontFamily: Constants.graphik,
                          fontSize: Constants.textFont16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.sizeBoxSpacingHeight20),
                  ButtonWidget(
                    isCircle: false,
                    widthButton: widthCurrent * 0.80,
                    descriptionBtn: "Guardar",
                    colorIcon: Constants.primaryWhite,
                    sizeIcon: Constants.sizeIcon,
                    onPress: () async {
                      final prefs = await SharedPreferences.getInstance();
                      listDate["name"] = _controllerName.text;
                      listDate["date"] = dateChoose;
                      listDate["idField"] = choose;
                      listDate["cloudAVG"] = "$data%";
                      String encodedMap = json.encode(listDate);
                      prefs.setString('encodedMap', encodedMap);
                      listAllData.add(encodedMap);
                      prefs.setStringList('listAllData', listAllData);
                      validateCount["date"] = dateChoose;
                      validateCount["count"] = count;
                      String encodedMapCount = json.encode(validateCount);
                      listValidateCount.add(encodedMapCount);
                      prefs.setStringList(
                          'listValidateCount', listValidateCount);
                      _controllerName.text = "";
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  onShowSnackBar(context, String? message) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: Constants.marginSnackBar,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Constants.primaryGrey,
        elevation: 0,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              height: Constants.sizeHeightBox36,
              child: Text(
                "$message",
                textAlign: TextAlign.start,
                maxLines: 3,
                style: const TextStyle(
                  color: Constants.primaryGreen,
                  fontFamily: Constants.graphik,
                  fontSize: Constants.textFont12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
              onTap: () =>
                  ScaffoldMessenger.of(context).removeCurrentSnackBar(),
              child: const Icon(
                Icons.close,
                color: Constants.primaryGreen,
                size: Constants.textFont12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
