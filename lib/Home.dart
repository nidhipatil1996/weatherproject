

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/Controller/weather_api_client.dart';
import 'package:weather_app/Model/weather_model.dart';
import 'package:weather_app/Views/additional_information.dart';
import 'package:weather_app/Views/current_weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  WeatherApiClient client = WeatherApiClient();
  
  Weather? data;

  Future<void> getData() async{
    data = await client.getCurrentWeather("america");

  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
         builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
             return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          currentWeather(Icons.wb_sunny_rounded, "${data!.temp}", "${data!.cityName}"),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Additional Information",
            style: TextStyle(
                fontSize: 24.0,
                color: Color(0xFF212121),
                fontWeight: FontWeight.bold),
          ),
          Divider(),
          const SizedBox(
            height: 20.0,
          ),
          additionalInformation("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feels_like}")
        ],
      );

          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Container();
         })
      
      
      
      
     
      
    );
  }
}
