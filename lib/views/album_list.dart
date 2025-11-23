// lib/views/album_list.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album_biblio.dart';
import 'package:album_biblio/views/album_list_item.dart';
import 'package:album_biblio/views/perfil_usuario.dart';
import 'package:album_biblio/views/acerca_de_vista.dart'; // <--- NUEVA IMPORTACIÓN

// Enum para las opciones del menú emergente
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
          PopupMenuButton<MenuOptions>(
            // onSelected: Se llama al elegir una opción
            onSelected: (MenuOptions result) {
              if (result == MenuOptions.profile) {
                // Navegación a Perfil del usuario
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PerfilUsuario(),
                  ),
                );
              } else if (result == MenuOptions.about) {
                // LÓGICA DE NAVEGACIÓN A "ACERCA DE..."
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AcercaDeVista(),
                  ),
                );
              }
            },
            
            // itemBuilder: Define las opciones del menú
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.profile,
                child: Text('Perfil del usuario'),
              ),
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.about,
                child: Text('Acerca de'),
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