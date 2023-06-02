import 'package:flutter/material.dart';
import 'package:tugas4/pages/gifsearch.dart';
import 'package:tugas4/pages/login_page.dart';
import 'package:tugas4/pages/profile.dart';
import 'package:tugas4/pages/pesankesan.dart';
import '../const/color.dart';


class BottomNavigation extends StatefulWidget {
  final String? nama;
  const BottomNavigation({Key? key, this.nama}): super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  static List<Widget> _widgetOptions = [
    GiphySearchPage(),
    Help(),
    Profile(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Welcome ${widget.nama} !'),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ));
            },
            child:
                Text(style: TextStyle(fontStyle: FontStyle.italic), 'Logout'),
          )
        ],
      )),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book,
              ),
              label: 'Menu Utama'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.announcement_rounded,
            ),
            label: 'Pesan dan Kesan',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
        onTap: (index) {
          setState(
            () {
              selectedIndex = index;
            },
          );
        },
        selectedItemColor: primary,
        unselectedItemColor: secondary,
        currentIndex: selectedIndex,
      ),
    );
  }
}
