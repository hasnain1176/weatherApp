
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:weather_app/function/fetchrate.dart';
import 'package:weather_app/model/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
      
            
          
  var currently;
  ApiResponse? response;
  bool inProgress = false;
  String message = "Search for the location to get weather data";
     


  Widget _getWeatherImage(String? currently) {
    switch (currently) {
      case 'Cloudy':
        return Lottie.asset('assets/animation/cloudy.json',
            height: 110, width: 200);
      case 'Clear':
        return Lottie.asset('assets/animation/clear.json',
            height: 100, width: 200);
      case 'Snow':
        return Lottie.asset('assets/animation/snow.json',
            height: 100, width: 200);
      case 'Overcast':
        return Lottie.asset('assets/animation/overcast.json',
            height: 100, width: 200);
      case 'Rainy':
        return Lottie.asset('assets/animation/rainy.json',
            height: 100, width: 200);
      default:
        return Lottie.asset('assets/animation/clear.json',
            height: 100, width: 200);
    }
  }


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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // const Icon(
                //   Icons.location_on,
                //   size: 50,
                // ),
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
          // SizedBox(height: 70),
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
          // Text("Weather Deatails:",style: TextStyle(color: Colors.black),),
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
      
          // Center(
          //   child: SizedBox(
          //     height: 200,
          //     child: Image.network(
          //       "https:${response?.current?.condition?.icon}"
          //           .replaceAll("64x64", "128x128"),
          //       scale: 0.7,
          //     ),
          //   ),
          // ),
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
                    _dataAndTitleWidget("Local Date",
                        response?.location?.localtime?.split(" ").first ?? ""),
                  ],
                )
              ],
            ),
          )
        ],
      );
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
