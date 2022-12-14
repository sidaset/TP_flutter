class Movie{
  /*final String resume;
  final String genre;
  final String sortie;*/
  final String imdbId;
  final String urlImage;
  final String title;
  final String year;

  Movie({ required this.imdbId, required this.urlImage,required this.title,required this.year});

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      imdbId: json["imdbID"],
      urlImage: json["Poster"],
      title: json["Title"],
      year: json["Year"]
    );
  }
}