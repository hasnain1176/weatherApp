//
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

import 'package:weather_app/function/fetchrate.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/screen/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  //  HomePage({Key? key, required this.data,})
  //     : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
              
}

class _HomePageState extends State<HomePage> {
  var snapshot;
  
// final ApiResponse da;
  // var data;
  // var weather;
  ApiResponse? response;
  Rx<TextEditingController> location = TextEditingController().obs;

  final HomeVM = Get.find<HomeViewModel>();
  bool inProgress = false;
  String message = "Search for the location to get weather data";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchWidget(),
            const SizedBox(height: 20),
            if (inProgress)
              CircularProgressIndicator()
            else
              Expanded(
                  child: SingleChildScrollView(child: _buildWeatherWidget())),
          ],
        ),
      ),
    ));
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      keyboardType: TextInputType.name,
      autoFocus: true,
      leading: Icon(Icons.search),
      hintText: "Search any city",
      onSubmitted: (value) {
        _getWeatherData(value);
      },
    );
  }

  Widget _buildWeatherWidget() {
    if (response == null) {
      return Text(message);
    } else {
      return Stack(children: [
        Lottie.asset(
            snapshot.data!.weather[0].main == 'Clear'
                ? 'assets/lottie/clear.json'
                : snapshot.data!.weather[0].main == 'Clouds'
                    ? 'assets/lottie/cloudy.json'
                    : snapshot.data!.weather[0].main == 'Rain'
                        ? 'assets/lottie/rainy.json'
                        : snapshot.data!.weather[0].main == 'Snow'
                            ? 'assets/lottie/snow.json'
                            : 'assets/lottie/windy.json',
            fit: BoxFit.cover),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        response?.location?.name ?? "",
                        style: const TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                response?.location?.localtime?.split(" ").first ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (response?.current?.tempC.toString() ?? "") + "°C",
                      style: const TextStyle(
                        fontSize: 65,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "---------------------",
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            Center(
              child: Text(
                (response?.current?.condition?.text.toString() ?? ""),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Weather Details:",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              color: Colors.transparent,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _dataAndTitleWidget("Humidity",
                          response?.current?.humidity?.toString() ?? ""),
                      _dataAndTitleWidget("Wind Speed",
                          "${response?.current?.windKph?.toString() ?? ""} km/h")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _dataAndTitleWidget(
                          "Cloud", response?.current?.uv?.toString() ?? ""),
                      _dataAndTitleWidget("Percipitation",
                          "${response?.current?.precipMm?.toString() ?? ""} mm")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _dataAndTitleWidget("Local Time",
                          response?.location?.localtime?.split(" ").last ?? ""),
                      _dataAndTitleWidget(
                          "Local Date",
                          response?.location?.localtime?.split(" ").first ??
                              ""),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ]);
    }
  }

  Widget _dataAndTitleWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      setState(() {
        message = "Failed to get weather ";
        response = null;
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
