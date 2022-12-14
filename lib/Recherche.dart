import 'package:flutter/material.dart';
import 'package:tp_mobile/Detail.dart';
import 'package:tp_mobile/Movie.dart';

class Recherche extends StatelessWidget{
  const Recherche({super.key, required this.movieList});

  final Future<List<Movie>> movieList;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('recherche'),
        ),
        body: Center(
            child: FutureBuilder(
                future: movieList,
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.hasData) {
                    return ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.black),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(
                                '${(snapshot.data as dynamic)[index].title}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 30),
                              ),
                              subtitle: Text(
                                '${(snapshot.data as dynamic)[index].year}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                              leading: (snapshot.data as dynamic)[index].urlImage != "N/A"? Image.network(
                                (snapshot.data)[index].urlImage,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ): Image.asset(
                                'assets/images/non_images.png',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (
                                      context) => Detail(imdbId: '${(snapshot.data as dynamic)[index].imdbId}')
                                  ),
                                );
                              }
                          );
                        }
                    );
                  }
                  else if(snapshot.hasError){
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                }
            )
        )
    );
  }
}



