import 'package:flutter/material.dart';
import 'package:tugas4/pages/bottom_navigation.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileCard(
            name: 'M Fawwaz Firjatullah',
            imageUrl: 'assets/povnanda.jpg',
            email: '123200148@student.upnyk.ac.id',
            nim: '123200148',
            location: 'Jambi, Indonesia',
          ),
          ProfileCard(
            name: 'Edwinpras Wijaya',
            imageUrl: 'assets/povedwin.jpg',
            email: '123200074@student.upnyk.ac.id',
            nim: '123200074',
            location: 'Belitung, Indonesia',
          ),
          ProfileCard(
            name: 'Muhammad Fawwaz Ananda',
            imageUrl: 'assets/povfawwaz.jpg',
            email: '123200121@student.upnyk.ac.id',
            nim: '123200121',
            location: 'Medan, Indonesia',
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String email;
  final String nim;
  final String location;

  const ProfileCard({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.nim,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(imageUrl),
          ),
          SizedBox(height: 16.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(email),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(nim),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(location),
          ),
        ],
      ),
    );
  }
}
