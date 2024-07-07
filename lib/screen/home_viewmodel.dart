import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app/function/fetchrate.dart';

class HomeViewModel extends GetxController {
  Rx<TextEditingController> location = TextEditingController().obs;

}