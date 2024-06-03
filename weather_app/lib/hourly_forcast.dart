import 'package:flutter/material.dart';

class HourlyForcast extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temp;
  const HourlyForcast(this.icon,this.time,this.temp,{super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.blueGrey,
      child: SizedBox(
        width: 100,
        height: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Icon(
                icon,
                size: 30,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Text(
                temp,
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}