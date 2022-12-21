import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "65d7fa525cf0187f69d8bbd8b884d840";

class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData{
  WeatherData({required this.locationData});

  LocationHelper locationData;
  late double currentTemperature; //şuanki sıcaklık
  late int currentCondition; //şuanki durum
  late String city; //şehir
  late String country; //ülke
  late double temp_min; //minimum sıcaklık
  late double temp_max; //maksimum sıcaklık
  late int humidity; //nem
  String? description; //tanım

  Future<void> getCurrentTemperature() async{
      Response response = await get (Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&&appid=${apiKey}&units=metric"));

          if(response.statusCode == 200){
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try{
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
        country = currentWeather['sys']['country'];
        temp_min = currentWeather['main']['temp_min'];
        temp_max = currentWeather['main']['temp_max'];
        humidity = currentWeather['main']['humidity'];
        description = currentWeather['weather'][0]['description'];
      }catch(e){
        print(e);
      }
    }else{
      print("No value from API.");
    }
  }

  WeatherDisplayData getWeatherDisplayData(){
    if(currentCondition < 600) {
      //hava bulutlu
      return WeatherDisplayData(
          weatherIcon: Icon(
          FontAwesomeIcons.cloud,
          size: 75.0,
          color: Colors.white
      ),
          weatherImage: AssetImage('assets/bulutlu.png'));
    }
    else{
    //hava iyi
    //gece gündüz kontrolü
     var now = new DateTime.now();
     if(now.hour >=19){
      return WeatherDisplayData(
        weatherIcon: Icon(
           FontAwesomeIcons.moon,
            size: 75.0,
            color: Colors.white
        ),
        weatherImage: AssetImage('assets/gece.png'));
  }else{
     return WeatherDisplayData(
           weatherIcon: Icon(
               FontAwesomeIcons.sun,
               size: 75.0,
               color: Colors.white
           ),
           weatherImage: AssetImage('assets/gunesli.png'));
     }
  }
  }
  }

