// lib/views/album_list_item.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart';
// 1. Importamos la vista a la que vamos a navegar
import 'package:album_biblio/views/album_vista.dart'; 

// Widget para representar una sola fila en la lista
class AlbumListItem extends StatelessWidget {
  final Album album;
  final int index;

  const AlbumListItem({
    super.key,
    required this.album,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        
        title: Text(album.titulo, 
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        
        subtitle: Text(
          '${album.cantante}, Año: ${album.anio}.\nGénero: ${album.genero}',
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Botón 1: Ver detalles del álbum
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                // 2. Lógica de Navegación: Enviamos el álbum a la nueva pantalla
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Creamos la AlbumVista y le PASAMOS el objeto 'album'
                    // que pertenece a esta fila específica.
                    builder: (context) => AlbumVista(album: album),
                  ),
                );
              },
              color: Colors.blue,
            ),
            // Botón 2: Editar álbum (Sin acción aún)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                debugPrint('Editar álbum: ${album.titulo}');
              },
              color: Colors.orange,
            ),
            // Botón 3: Eliminar álbum (Sin acción aún)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                debugPrint('Eliminar álbum: ${album.titulo}');
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}