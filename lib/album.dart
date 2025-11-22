class Album {
  String titulo;
  String cantante;
  int anio;
  String genero;

  Album({
    required this.titulo,
    required this.cantante,
    required this.anio,
    required this.genero,
  });

  Album.porDefecto({
    this.titulo = "OK Computer",
    this.cantante = "Radiohead",
    this.anio = 1997,
    this.genero = "Rock",
  });
}