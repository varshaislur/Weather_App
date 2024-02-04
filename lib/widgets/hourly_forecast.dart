import "package:flutter/material.dart";

class HourlyForecast extends StatelessWidget {
  late IconData icon;
  late String time;
  late String temperature;


  HourlyForecast({super.key,
    required  this.icon,
    required  this.time,
    required this.temperature});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:120,
      width:120,
      child: Card(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(time,style:TextStyle(fontSize: 15)),
              SizedBox(height:10),
              Icon(icon,size:30),
              SizedBox(height:10),
              Text(temperature)
            ],
          ),
        ),
      ),
    );
  }
}

