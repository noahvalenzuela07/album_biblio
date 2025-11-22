// lib/views/album_list.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album_biblio.dart'; // Necesitamos la clase gestora
import 'package:album_biblio/views/album_list_item.dart'; // Necesitamos el item de la lista

// Widget para la ventana de la lista de álbumes
class AlbumList extends StatelessWidget {
  final AlbumBiblio biblioteca; // Recibe la instancia del gestor de álbumes

  const AlbumList({super.key, required this.biblioteca});

  @override
  Widget build(BuildContext context) {
    // 1. Scaffold: Estructura base de la pantalla.
    return Scaffold(
      // 2. AppBar: Barra superior con el título.
      appBar: AppBar(
        title: const Text("Biblioteca de Álbumes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      
      // 3. body: Contenido principal (la lista de álbumes).
      body: ListView.builder(
        // itemCount: Determina cuántos elementos se van a construir.
        // Lo obtenemos del número de álbumes en nuestra biblioteca.
        itemCount: biblioteca.albumes.length,
        // itemBuilder: La función que construye cada elemento de la lista.
        itemBuilder: (BuildContext context, int index) {
          // Devuelve nuestro widget personalizado AlbumListItem
          return AlbumListItem(
            album: biblioteca.albumes[index], // Pasa el álbum correspondiente
            index: index, // Pasa el índice para numerar
          );
        },
      ),
      
      // 4. FloatingActionButton: Botón flotante para agregar nuevos álbumes.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Aquí irá la navegación a la ventana de agregar álbum.
          debugPrint('Botón flotante presionado: Agregar nuevo álbum.');
        },
        tooltip: 'Agregar álbum',
        child: const Icon(Icons.add),
      ),
    );
  }
}