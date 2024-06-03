import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/addition_info.dart';
import 'package:weather_app/hourly_forcast.dart';

class Weatherscreen extends StatelessWidget {
  const Weatherscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "300 °C ",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        Icon(
                          Icons.cloud,
                          size: 60,
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          "Rain",
                          style: TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Weather Forcast",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForcast(Icons.cloud,"09:00","300.5"),
                  HourlyForcast(Icons.cloud,"09:00","300.5"),
                  HourlyForcast(Icons.cloud,"09:00","300.5"),
                  HourlyForcast(Icons.cloud,"09:00","300.5"),
                  HourlyForcast(Icons.cloud,"09:00","300.5"),
                  HourlyForcast(Icons.cloud,"09:00","300.5"),
                ],
              ),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionInfo(Icons.water_drop, "humidity", "94"),
                AdditionInfo(Icons.wind_power, "Wind Speed", "10.00"),
                AdditionInfo(Icons.umbrella, "Pressure", "1006")
              ],
            )
          ],
        ),
      ),
    );
  }
}
