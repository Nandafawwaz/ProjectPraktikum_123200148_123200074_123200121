import 'package:flutter/material.dart';
import 'package:tugas4/pages/bottom_navigation.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Pesan dan Kesan kami selama belajar mata kuliah Praktikum Teknologi Pemrograman Mobile :',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Card(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Setelah mengikuti perkuliahan Praktikum Teknologi Pemrograman Mobile, Saya sangat senang dengan mas mario karena dia sangat keren -Nanda',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
