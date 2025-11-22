// lib/views/album_list_item.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart'; // Necesitamos el modelo Album

// Widget para representar una sola fila en la lista
class AlbumListItem extends StatelessWidget {
  final Album album; // El objeto Album que esta fila va a mostrar
  final int index;   // El índice del álbum en la lista (para saber qué fila es)

  const AlbumListItem({
    super.key,
    required this.album,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Card: Un contenedor con esquinas redondeadas y sombra para destacar el elemento.
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 5, // Sombra
      child: ListTile(
        // 2. leading: Widget que va a la izquierda (usaremos un círculo con el índice)
        leading: CircleAvatar(
          child: Text(
            (index + 1).toString(), // Muestra el número de la posición
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        
        // 3. title: El título principal (Nombre del Álbum)
        title: Text(album.titulo, 
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        
        // 4. subtitle: Muestra la información debajo del título (Cantante, Año, Género)
        subtitle: Text(
          '${album.cantante}, Año: ${album.anio}.\nGénero: ${album.genero}',
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        
        // 5. trailing: Los widgets que van a la derecha (los botones de acción)
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // Hace que la Row ocupe el mínimo espacio
          children: <Widget>[
            // Botón 1: Ver detalles del álbum
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                debugPrint('Detalles del álbum: ${album.titulo}'); 
              },
              color: Colors.blue,
            ),
            // Botón 2: Editar álbum
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                debugPrint('Editar álbum: ${album.titulo}');
              },
              color: Colors.orange,
            ),
            // Botón 3: Eliminar álbum
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