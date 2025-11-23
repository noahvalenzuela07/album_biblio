// lib/views/album_list_item.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart';
import 'package:album_biblio/views/album_vista.dart'; 
import 'package:album_biblio/views/confirmacion_vista.dart'; // <--- NUEVA IMPORTACIÓN

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
            // Botón 1: Ver detalles del álbum (Ejercicio 15)
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
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
            
            // Botón 3: Eliminar álbum (Ejercicio 16)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async { // <--- FUNCIÓN ASÍNCRONA
                // 1. Navegamos a la vista de confirmación y ESPERAMOS el resultado
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmacionVista(album: album),
                  ),
                );
                
                // 2. Verificamos el resultado devuelto (true para confirmar, false para cancelar)
                if (resultado == true) {
                  // Muestra el mensaje "toast" (SnackBar) para eliminación confirmada
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Álbum "${album.titulo}" ELIMINADO exitosamente.'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } else if (resultado == false) {
                  // Muestra el mensaje "toast" (SnackBar) para eliminación cancelada
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Eliminación del álbum "${album.titulo}" CANCELADA.'),
                      backgroundColor: Colors.blueGrey,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}