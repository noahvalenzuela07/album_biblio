// lib/views/album_list.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album_biblio.dart';
import 'package:album_biblio/views/album_list_item.dart';
// 1. Importamos la vista a la que vamos a navegar
import 'package:album_biblio/views/perfil_usuario.dart'; 

// 2. Enum para las opciones del menú emergente
enum MenuOptions {
  profile,
  about,
}

// Widget para la ventana de la lista de álbumes
class AlbumList extends StatelessWidget {
  final AlbumBiblio biblioteca;

  const AlbumList({super.key, required this.biblioteca});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. AppBar: Barra superior con el título.
      appBar: AppBar(
        title: const Text("Biblioteca de Álbumes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        // 3. Bloque actions: Aquí va el botón del menú
        actions: <Widget>[
          // PopupMenuButton crea el botón de los 3 puntos
          PopupMenuButton<MenuOptions>(
            // onSelected: Se llama al elegir una opción
            onSelected: (MenuOptions result) {
              if (result == MenuOptions.profile) {
                // Lógica de navegación a la pantalla PerfilUsuario
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder define la pantalla de destino
                    builder: (context) => const PerfilUsuario(),
                  ),
                );
              }
              // El else if para 'about' se puede dejar vacío por ahora
            },
            
            // itemBuilder: Define las opciones del menú
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.profile,
                child: Text('Perfil del usuario'),
              ),
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.about,
                child: Text('Acerca de'), // Placeholder para actividad complementaria
              ),
            ],
          ),
        ],
      ),
      
      // 4. body: Contenido principal (la lista de álbumes).
      body: ListView.builder(
        itemCount: biblioteca.albumes.length,
        itemBuilder: (BuildContext context, int index) {
          return AlbumListItem(
            album: biblioteca.albumes[index],
            index: index,
          );
        },
      ),
      
      // 5. FloatingActionButton: Botón flotante para agregar nuevos álbumes.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Botón flotante presionado: Agregar nuevo álbum.');
        },
        tooltip: 'Agregar álbum',
        child: const Icon(Icons.add),
      ),
    );
  }
}