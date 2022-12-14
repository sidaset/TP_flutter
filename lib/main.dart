import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tp_mobile/Recherche.dart';
import 'package:tp_mobile/Movie.dart';




Future<List<Movie>> recupFilm(recherche) async{
  final response = await http.get(Uri.parse("https://www.omdbapi.com/?s="+recherche+"&apikey=5bfa4aa7"));

  if(response.statusCode == 200){
    final liste = json.decode(response.body)['Search'] as List;
    return liste.map((data) => Movie.fromJson(data)).toList();
  }
  else{
    throw Exception("Erreur lors de l'appel de l'API");
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Execution(),
    );
  }
}
class Execution extends StatefulWidget{
  const Execution({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}


class _AccueilState extends State<Execution>{
  final controller = TextEditingController();
  late Future<List<Movie>> movieList;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APIFilm"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 250,0,16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Nom du film',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              movieList = recupFilm(controller.text);
              //movieList = recupFilm();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Recherche(movieList: movieList)),
              );
            },
            child: Text('Rechercher'),

          ),
        ],
      ),
    );
  }

}
