import 'package:flutter/material.dart';
// Importamos la nueva pantalla de álbum
import 'package:album_biblio/views/album_vista.dart'; 
// Importamos el modelo de datos
import 'package:album_biblio/album.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Crear un objeto Album con los datos de ejemplo del profesor (OK Computer)
    final Album albumEjemplo = Album.porDefecto();

    return MaterialApp(
      title: 'Album Biblio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      // 2. Usar AlbumVista como home, pasándole el objeto creado
      home: AlbumVista(album: albumEjemplo),
    );
  }
}