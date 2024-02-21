import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:weather_app/secrets/secrets.dart';
import 'package:weather_app/widgets/additional_info.dart';
import 'package:weather_app/widgets/hourly_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 //late Future<Map<String,dynamic>> weather;
  Future<Map<String,dynamic>> getWeatherData() async {
    try {
      String url = "http://api.openweathermap.org/data/2.5/forecast?id=524901&appid=${API_KEY}";
      final Response = await http.get(Uri.parse(url));
      final encodedData = Response.body;
      Map<String, dynamic> data2 = jsonDecode(encodedData);
      if (data2['cod'] != "200") {
        throw "unexpected error occured";
      }


      return data2;
    }
    catch(e){

      throw "Error occured";

    }
  }


  @override
  void initState() {
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.refresh)),
        ],
      ),
      body:
        FutureBuilder(
          future:getWeatherData(),
          builder: (context,snapshot)
          { if (snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Text("Error has occured");
          }
            else{
              final data= snapshot.data!;

              final main=data['list'][0]["main"];
              final weather=data['list'][0]["weather"];
              final List hourlyforecast=data['list'];

            return
            Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               SizedBox(
                 width:double.infinity,
                 child: Card(
                   color:Color.fromRGBO(42, 52, 57, 50),
                   shape:RoundedRectangleBorder(
                     borderRadius:BorderRadius.circular(15)
                   ),
                   child:ClipRRect(
                     borderRadius: BorderRadius.circular(15),
                     child: BackdropFilter(

                       filter: ImageFilter.blur(
                         sigmaX: 40,
                         sigmaY: 40,
                       ),
                       child: Padding(
                         padding: EdgeInsets.symmetric(vertical: 10),
                         child: Column(
                           children:[
                             Text("${main["temp"].toString()}K",style:TextStyle(fontSize:35,fontWeight: FontWeight.bold)),
                             SizedBox(
                               height:10
                             ),
                            weather[0]["main"]=="Clouds"? Icon(Icons.cloud,size: 45,):( weather[0]["main"]=="Snow"? Icon(Icons.cloudy_snowing,size:45):Icon(Icons.sunny)),
                             SizedBox(
                                 height:10
                             ),
                             weather[0]["main"]=="Clouds"?Text("Rain",style:TextStyle(fontSize:20)):( weather[0]["main"]=="Snow"? Text("Snow",style:TextStyle(fontSize:20)):Text("Sunny",style:TextStyle(fontSize:20))),

                           ]

                         ),
                       ),
                     ),
                   )
                 ),
               ),
                SizedBox(height:20),
                Text("Hourly Forecast",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
               SizedBox(
                 height:120,
                 child: SizedBox(
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     itemCount: hourlyforecast.length-1,
                       itemBuilder: (context,index){
                         final hourlyforecastsky=hourlyforecast[index+1]["weather"][0]["main"];
                       return
                           HourlyForecast(icon: hourlyforecastsky=="Clouds"?( Icons.cloud): (weather[0]["main"]=="Snow")? (Icons.cloudy_snowing):Icons.sunny,
                                time: "time", temperature: "temp");
                       }),
                 ),
               ),
                SizedBox(height:20),

                Text("Additional Information",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   AdditionalInfo(icon:Icons.sailing, property: "Humidity", value:"100"),
                    AdditionalInfo(icon: Icons.air, property: "Windspeed", value: "200 km/hr"),
                    AdditionalInfo(icon: Icons.terrain, property: "pressure", value:"100mg" ),
                  ],
                ),

              ],
            ),
          );}
          }
        )
    );
  }
}
