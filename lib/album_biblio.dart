// lib/album_biblio.dart

import 'package:album_biblio/album.dart'; // Importamos la clase Album

// 1. Clase que gestiona la colección de álbumes
class AlbumBiblio {
  
  // 2. Lista privada: Almacena los objetos Album.
  // El modificador 'final' significa que la lista en sí no puede ser reemplazada,
  // pero su contenido (los álbumes) sí puede ser modificado.
  final List<Album> _listaAlbumes = [];

  // Constructor vacío (no hace nada especial al inicializarse)
  AlbumBiblio();

  // 3. Getter: Permite acceder a la lista desde fuera, pero solo para lectura.
  // Esto protege la lista para que no sea modificada accidentalmente.
  List<Album> get albumes => _listaAlbumes;

  // 4. Método para agregar un álbum a la lista
  void addAlbum(Album album) {
    _listaAlbumes.add(album);
  }
}