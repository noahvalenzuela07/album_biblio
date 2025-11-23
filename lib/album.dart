// lib/album.dart

// Definición de la clase Album
class Album {
  String titulo;
  String cantante;
  int anio;
  String genero;

  // Constructor de la clase Album (ya existía)
  Album({
    required this.titulo,
    required this.cantante,
    required this.anio,
    required this.genero,
  });

  // Constructor de ejemplo por omisión (ya existía)
  Album.porDefecto({
    this.titulo = "OK Computer",
    this.cantante = "Radiohead",
    this.anio = 1997,
    this.genero = "Rock",
  });
  
  // 1. CONSTRUCTOR PARA DECODIFICAR DESDE JSON (MAPA)
  // Recibe un mapa (JSON) y asigna sus valores a los atributos
  Album.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'],
        cantante = json['cantante'],
        anio = json['anio'],
        genero = json['genero'];

  // 2. MÉTODO PARA CODIFICAR A JSON (MAPA)
  // Devuelve un mapa con los atributos de la clase
  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'cantante': cantante,
        'anio': anio,
        'genero': genero,
      };
}