import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/controllers/registration_controller.dart';
import '../../../../../core/utils/constants.dart';

class RadioButton extends StatelessWidget {
  const RadioButton(
      {super.key,
      required this.controller,
      required this.text,
      required this.value});

  final RegistrationController controller;
  final String text;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: 30,
              child: Obx(() => Radio(
                  value: value,
                  groupValue: controller.radioVal.value,
                  activeColor: primaryColor,
                  onChanged: (int? val) {
                    controller.changeRadioVal(val!);
                  }))),
          Text(text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
