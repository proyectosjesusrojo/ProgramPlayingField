import 'package:flutter/material.dart';
import 'package:programplayingfield/constants.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPress;
  final bool? isCircle;
  final double? heightButton;
  final double? widthButton;
  final IconData? icon;
  final Color? colorIcon;
  final double? sizeIcon;
  final String? descriptionBtn;

  const ButtonWidget(
      {super.key,
      required this.onPress,
      this.isCircle,
      this.heightButton,
      this.widthButton,
      this.icon,
      this.colorIcon,
      this.sizeIcon,
      this.descriptionBtn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryWhite,
        shape: isCircle == true ? const CircleBorder() : null, //<-- SEE HERE
      ),
      child: Container(
        height: heightButton ?? Constants.sizeButtonHeightCircle,
        width: widthButton ?? Constants.sizeButtonWidthCircle,
        decoration: BoxDecoration(
          color: Constants.primaryGreen,
          shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: icon == null
            ? Center(
                child: Text(
                  descriptionBtn ?? "",
                  style: const TextStyle(
                    fontFamily: Constants.graphik,
                    fontSize: Constants.textFont16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: Constants.wordSpacingInText,
                    color: Constants.primaryWhite,
                  ),
                ),
              )
            : Icon(
                icon,
                color: colorIcon,
                size: sizeIcon,
              ),
      ),
    );
  }
}
