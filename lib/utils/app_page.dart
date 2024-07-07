import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:weather_app/screen/home_page.dart';
import 'package:weather_app/screen/home_viewmodel.dart';

import 'package:weather_app/utils/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.HomePage,
      page: () => HomePage(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeViewModel>(
          () => HomeViewModel(),
        );
      }),
    ),
  ];}
    
  