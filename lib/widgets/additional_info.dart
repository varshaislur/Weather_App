import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  late IconData icon;
  late String value;
  late String property;

  AdditionalInfo({super.key,
  required this.icon,
  required this.property,
  required this.value});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:150,
      width:150,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:16.0),
        child: Column(
          children: [
            Icon(icon,size:30),
            SizedBox(
                height:12
            ),

            Text(property),
            SizedBox(
                height:12
            ),

            Text(value,style: TextStyle(
                fontWeight:FontWeight.bold
            ),)

          ],
        ),
      ),
    );
  }
}
