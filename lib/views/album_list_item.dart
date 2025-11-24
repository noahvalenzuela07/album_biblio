// lib/views/album_list_item.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart';
import 'package:album_biblio/views/album_vista.dart';
import 'package:album_biblio/views/confirmacion_vista.dart';
import 'package:album_biblio/views/album_form.dart'; // <--- Importación del formulario

// Definición de un callback para la edición: recibe el álbum original y el álbum editado
typedef OnEditCallback = void Function(Album original, Album edited);

// Widget para representar una sola fila en la lista
class AlbumListItem extends StatelessWidget {
  final Album album;
  final int index;
  final void Function(Album) onDelete; 
  final OnEditCallback onEdit; // <--- NUEVO CALLBACK PARA EDICIÓN

  const AlbumListItem({
    super.key,
    required this.album,
    required this.index,
    required this.onDelete,
    required this.onEdit, // <--- REQUERIDO EN EL CONSTRUCTOR
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumVista(album: album),
                  ),
                );
              },
              color: Colors.blue,
            ),
            
            // Botón 2: Editar álbum (Implementación real)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                // Navegamos al formulario, pasando el álbum actual para editar
                final editedAlbum = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumForm(albumToEdit: album),
                  ),
                );
                
                // Si el formulario devuelve un objeto Album (es decir, se guardó)
                if (editedAlbum != null && editedAlbum is Album) {
                  // Llamamos al callback para que AlbumList actualice el estado
                  onEdit(album, editedAlbum); 

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Álbum "${editedAlbum.titulo}" ACTUALIZADO exitosamente.'),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              color: Colors.orange,
            ),
            
            // Botón 3: Eliminar álbum (ya implementado)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmacionVista(album: album),
                  ),
                );
                
                if (resultado == true) {
                  onDelete(album); 
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Álbum "${album.titulo}" ELIMINADO exitosamente.'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } else if (resultado == false) {
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