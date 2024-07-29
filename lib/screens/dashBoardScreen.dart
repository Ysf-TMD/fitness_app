import 'dart:convert';

import 'package:fitness_app/screens/DetailedCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboardscreen extends StatefulWidget {
  final String name;

  final String email;

  const Dashboardscreen({required this.name, required this.email});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  List<dynamic> exercises = [];
  String baseUrl = "http://10.0.2.2/fitness";

  Future<void> _fetchExercises() async {
    try {
      final apiUrl = '$baseUrl/ex.php';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          exercises = json.decode(response.body);
          print("this is response body " + response.body);
        });
      } else {
        throw Exception("Failed  to load Exercises");
      }
    } catch (e) {
      print("Erreur fetching exercises :  $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: exercises.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text("Welcom , ${widget.name}"),
                const Text("Exercice Liste : "),
                Expanded(
                  child: ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        final imageUrl = "$baseUrl/${exercise['image_url']}";
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailedcardScreen(
                                        imageUrl: imageUrl,
                                        name: exercise["name"],
                                        slogan: exercise["slogan"] ,
                                        second: int.parse(exercise["second"]),
                                        username: widget.name,
                                        usermail: widget.email,
                                    )),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(imageUrl),
                                ),
                                title: Text(exercise["name"]),
                                subtitle: Text(exercise["slogan"]),
                                trailing: Text("${exercise["second"]} second"),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
