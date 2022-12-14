class Movie2 {
  final String resume;
  final String genre;
  final String sortie;
  final String imdbId;
  final String urlImage;
  final String title;
  final String year;

  Movie2({ required this.imdbId, required this.urlImage,required this.title,required this.year,required this.sortie,required this.genre,required this.resume});

  factory Movie2.fromJson(Map<String, dynamic> json){
    return Movie2(
        sortie: json["Released"],
        genre: json["Genre"],
        resume: json["Plot"],
        imdbId: json["imdbID"],
        urlImage: json["Poster"],
        title: json["Title"],
        year: json["Year"]
    );
  }
}