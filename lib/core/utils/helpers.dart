import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Helper {
  //............ Toast Message ............
  static void toastMsg(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  // ............ Mobile No Validation ............
  static final phoneNORegex = RegExp(
    r'^(?:\+?88)?01[135-9]\d{8}$',
  );
  static String? validationPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone field is required!';
    } else if (!phoneNORegex.hasMatch(value)) {
      return 'Enter Valid Phone Number';
    } else {
      return null;
    }
  }
  //.............. Email Validation ............
  static final emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static String? validationEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email field is required!';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email!';
    } else {
      return null;
    }
  }

  static String? validationLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a link!';
    } else if (!Uri.parse(value).isAbsolute) {
      return 'Enter a valid url!';
    } else {
      return null;
    }
  }

  //........... Password Validation .................
  static String? validationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password field is required!';
    } else if (value.length < 8) {
      return 'Enter minimum 8 digit';
    } else {
      return null;
    }
  }

  static String? validationAverage(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required*';
    }  else {
      return null;
    }
  }
  
  static String? validationReview(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required*';
    } else if (value.length > 250) {
      return '${value.length} out of 250 Character';
    }  else if (value.length < 10) {
      return 'Enter minimum 10 Character';
    } else {
      return null;
    }
  }

  static String? noValidation(String? value){
    return null;
  }

}