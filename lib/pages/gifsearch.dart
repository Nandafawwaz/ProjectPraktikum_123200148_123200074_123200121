import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas4/pages/login_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giphy Search',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: GiphySearchPage(),
    );
  }
}

class GiphySearchPage extends StatefulWidget {
  @override
  _GiphySearchPageState createState() => _GiphySearchPageState();
}
class _GiphySearchPageState extends State<GiphySearchPage> {
  final String apiKey = 'Pxgujn7EHDcD51sDJac1r0O2t3pfIP1X';
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _gifs = [];
  int _offset = 0;

  Future<void> _searchGifs(String query) async {
    final String url =
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=20&offset=$_offset';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        if (_offset == 0) {
          _gifs = jsonData['data'];
        } else {
          _gifs.addAll(jsonData['data']);
        }
        _offset += 20;
      });
    } else {
      throw Exception('Failed to load GIFs');
    }
  }

  Future<void> _loadMoreGifs() async {
    await _searchGifs(_searchController.text);
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('GIF URL copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.lightBlue,
                Colors.lightGreen,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Cari GIF yang di inginkan',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _offset = 0;
                        _searchGifs(_searchController.text);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollEndNotification &&
                        scrollInfo.metrics.extentAfter == 0) {
                      _loadMoreGifs();
                    }
                    return false;
                  },
                  child: GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: _gifs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final gif = _gifs[index];
                      final gifUrl = gif['images']['fixed_height']['url'];
                      final user = gif['user'];
                      final username = user != null ? user['username'] : 'Unknown User';
                      final userProfileUrl = user != null ? user['profile_url'] : null;
                      return Card(
                        elevation: 2.0,
                        child: GridTile(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  gifUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Username: $username',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.0),
                                    GestureDetector(
                                      onTap: () {
                                        if (userProfileUrl != null) {
                                          launch(userProfileUrl);
                                        }
                                      },
                                      child: Text(
                                        'Profile: $userProfileUrl',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  final int defIndex;
  final String name;
  final String description;

  Item({required this.defIndex, required this.name, required this.description});
}
