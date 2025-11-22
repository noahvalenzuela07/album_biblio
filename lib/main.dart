import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart'; // Importamos el modelo
import 'package:album_biblio/album_biblio.dart'; // Importamos el gestor
import 'package:album_biblio/views/album_list.dart'; // Importamos la lista

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Inicializar la biblioteca de álbumes
    final AlbumBiblio biblioteca = AlbumBiblio();

    // 2. Agregar los álbumes de ejemplo (usando el constructor porDefecto)
    biblioteca.addAlbum(Album.porDefecto()); // OK Computer - Radiohead
    
    // Agregar más álbumes de ejemplo para llenar la lista (tomados de la Figura 6-42)
    biblioteca.addAlbum(
      Album(
        titulo: "The Dark Side of the Moon",
        cantante: "Pink Floyd",
        anio: 1973,
        genero: "Rock",
      ),
    );
    biblioteca.addAlbum(
      Album(
        titulo: "Pet Sounds",
        cantante: "The Beach Boys",
        anio: 1966,
        genero: "Rock",
      ),
    );
    biblioteca.addAlbum(
      Album(
        titulo: "Who's next",
        cantante: "The Who",
        anio: 1971,
        genero: "Rock",
      ),
    );
    biblioteca.addAlbum(
      Album(
        titulo: "Off the Wall",
        cantante: "Michael Jackson",
        anio: 1979,
        genero: "Pop",
      ),
    );


    return MaterialApp(
      title: 'Album Biblio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      // 3. Mostrar la nueva pantalla AlbumList, pasándole la biblioteca
      home: AlbumList(biblioteca: biblioteca),
    );
  }
}