import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tp_mobile/Movie.dart';
import 'package:http/http.dart' as http;
import 'package:tp_mobile/Movie2.dart';


Future<List<Movie2>> recupFilmDetail(imdbId) async{
  final reponse = await http.get(Uri.parse("https://www.omdbapi.com/?i="+imdbId+"&apikey=8a86d5b2"));

  if(reponse.statusCode == 200){
    final liste = json.decode("[" + reponse.body + "]") as List<dynamic>;
    return liste.map((data) => Movie2.fromJson(data)).toList();
  }
  else{
    throw Exception("Erreur lors de l'appel de l'API");
  }
}



class Detail extends StatelessWidget{
  Detail({super.key, required this.imdbId});

  final dynamic imdbId;
  late Future<List<Movie2>> filmDetail = recupFilmDetail(imdbId);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Center(
          child: FutureBuilder(
              future: filmDetail,
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return ListView(
                      children: <Widget>[
                        Container(
                        ),
                        Text("${(snapshot.data as dynamic)[0].title}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40.0)),
                        Text("${(snapshot.data as dynamic)[0].sortie}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black)),
                        Text("${(snapshot.data as dynamic)[0].genre}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black)),
                        (snapshot.data as dynamic)[0].urlImage != "N/A"? Image.network("${(snapshot.data as dynamic)[0].urlImage}",
                            width: 300, height: 300) : Image.asset('assets/images/non_images.png', width: 300, height: 300),
                        
                        (snapshot.data as dynamic)[0].resume != "N/A"? Text("${(snapshot.data as dynamic)[0].resume}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black)) : Text(""),

                        ]
                  );
                }
                else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }
          )
      ),
    );
  }
}

