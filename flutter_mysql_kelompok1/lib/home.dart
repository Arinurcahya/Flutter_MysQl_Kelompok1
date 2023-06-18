import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mysql_kelompok1/add.dart';
import 'package:flutter_mysql_kelompok1/edit.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Map<String, dynamic>> _get = [];

  final _lightColors = [
    Colors.amber.shade300,
    Colors.lightGreenAccent.shade200,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];


  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  Future<void> _getNotes() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.1.7/note_app/list.php"));
      
  if (response.statusCode == 200) {
      print(response.body);
        final data = jsonDecode(response.body);

        setState(() {
          _get = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note List'),
      ),
      body: _get.isNotEmpty
          ? MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: _get.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit(id: _get[index]['id'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: _lightColors[index % _lightColors.length],
                    child: Container(
                      constraints: BoxConstraints(minHeight: (index % 2 + 1) * 85),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_get[index]['date']}',
                                style:  const TextStyle(color: Colors.black),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                '${_get[index]['title']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No Data Available",
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Add()),
                      );
                  },
                ),
              );
            }
          }

                       