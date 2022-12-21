import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havadurumubsz/utils/weather.dart';

class MainScreen extends StatefulWidget {

  final WeatherData weatherData;

  MainScreen({required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;
  late String country;
  late double temp_min;
  late double temp_max;
  late int humidity;
  String? description;

  void updateDisplayInfo(WeatherData weatherData){
    setState(() {
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      country = weatherData.country;
      temp_min = weatherData.temp_min;
      temp_max = weatherData.temp_max;
      humidity = weatherData.humidity;
      description = weatherData.description;
      WeatherDisplayData weatherDisplayData = weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;

    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height:270,),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(height:10,),
            Center(
              child: Text(city,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    letterSpacing: -1
                ),
              ),
            ),
            SizedBox(height:5,),
            Center(
              child: Text(country,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    letterSpacing: -1
                ),
              ),
            ),
            SizedBox(height:5,),
            Center(
              child: Text('$temperature°',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80.0,
                letterSpacing: 0
              ),
              ),
            ),
            SizedBox(height:0,),
            Center(
              child: Text(description??"",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    letterSpacing: 1
                ),
              ),
            ),
            SizedBox(height:1,),
            Center(
              child: Text('🌡️ Min Temp : $temp_min',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1
                ),
              ),
            ),
            SizedBox(height:1,),
            Center(
              child: Text('🌡️ Max Temp : $temp_max',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1
                ),
              ),
            ),
            SizedBox(height:1,),
            Center(
              child: Text('💧 Humidity : %$humidity',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
