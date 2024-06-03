import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/addition_info.dart';
import 'package:weather_app/hourly_forcast.dart';
import 'package:weather_app/secrets.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  dynamic temp = 0;
  dynamic windsp = 0;
  dynamic humidity = 0;
  dynamic pressure = 0;
  @override
  initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    const String city = "Patna";
    final res = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$weatherApiKey"),
    );
    final data = jsonDecode(res.body);
    //temp= data["list"][0]["main"]["temp"];
    return data;
  }
  IconData getIcon(String weather){
    switch (weather) {
      case "Clouds":
        return Icons.cloud;
      case "Clear":
        return Icons.sunny;
      case "Rain":
        return Icons.water;
      case "Snow":
        return Icons.snowing;  
      default:
       return Icons.sunny; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {setState(() {
              build(context);
            });},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            FutureBuilder(
                future: getCurrentWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  if (snapshot.hasError) {
                    return const Text("Error");
                  }
                  temp = snapshot.data["list"][0]["main"]["temp"];
                  return Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.blueGrey,
                    child: SizedBox(
                      width: double.infinity,
                      height: 230,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${double.parse((temp - 273.15).toStringAsFixed(2))} C",
                                style: const TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              const Padding(padding: EdgeInsets.all(8)),
                               Icon(
                                getIcon(snapshot.data["list"][0]["weather"][0]["main"]),
                                size: 60,
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                               Text(
                                "${snapshot.data["list"][0]["weather"][0]["main"]}",
                                style: const TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Weather Forcast",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
             FutureBuilder(
               future: getCurrentWeather(),
               builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return const CircularProgressIndicator.adaptive();
                 }
                 if (snapshot.hasError) {
                   return const Text("Error");
                 }
                 List n =snapshot.data["list"];
                 return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       for(int i=1;i<n.length;i++)
                         HourlyForcast(getIcon(snapshot.data["list"][i]["weather"][0]["main"]), "${((snapshot.data["list"][i]["dt_txt"]).toString()).substring(0,10)}\n${((snapshot.data["list"][i]["dt_txt"]).toString()).substring(11,16)}", "${snapshot.data["list"][i]["main"]["temp"]} k"),
                      
                     ],
                   ),
                 );
               },
             ),
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 8,
            ),
            FutureBuilder(
              future: getCurrentWeather(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                }
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                windsp = snapshot.data["list"][0]["wind"]["speed"];
                humidity = snapshot.data["list"][0]["main"]["humidity"];
                pressure = snapshot.data["list"][0]["main"]["pressure"];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionInfo(Icons.water_drop, "humidity", "$humidity"),
                    AdditionInfo(Icons.wind_power, "Wind Speed", "$windsp"),
                    AdditionInfo(Icons.umbrella, "Pressure", "$pressure")
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
