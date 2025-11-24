// lib/views/album_list.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart';
import 'package:album_biblio/album_biblio.dart';
import 'package:album_biblio/views/album_list_item.dart';
import 'package:album_biblio/views/perfil_usuario.dart';
import 'package:album_biblio/views/acerca_de_vista.dart';
import 'package:album_biblio/views/album_form.dart'; 

// Enum para las opciones del menú emergente
enum MenuOptions {
  profile,
  about,
}

// CONVERTIDO A STATEFULWIDGET
class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  final AlbumBiblio biblioteca = AlbumBiblio(); 
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _initializeData(); 
  }
  
  // Función asíncrona que gestiona la carga inicial de datos
  Future<void> _initializeData() async {
    await biblioteca.loadAlbumes(); 

    // Si la lista está vacía, añade datos de demostración y los guarda.
    if (biblioteca.albumes.isEmpty) {
      biblioteca.addAlbum(Album.porDefecto()); 
      biblioteca.addAlbum(
        Album(
          titulo: "The Dark Side of the Moon",
          cantante: "Pink Floyd",
          anio: 1973,
          genero: "Rock",
        ),
      );
    }
  }

  // Función para manejar la navegación del menú (sin cambios)
  void _onMenuSelected(MenuOptions result) {
    if (result == MenuOptions.profile) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PerfilUsuario()),
      );
    } else if (result == MenuOptions.about) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AcercaDeVista()),
      );
    }
  }

  // Método que se llamará desde el FloatingActionButton (Agregar)
  void _navigateToAddAlbum() async {
    // Al agregar, NO pasamos albumToEdit, por lo que es null
    final newAlbum = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AlbumForm(), 
      ),
    );

    if (newAlbum != null && newAlbum is Album) {
      // Es una adición
      setState(() {
        biblioteca.addAlbum(newAlbum); 
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Álbum "${newAlbum.titulo}" agregado exitosamente.'),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
  
  // NUEVA FUNCIÓN: Maneja el resultado de la edición
  void _handleAlbumEdit(Album originalAlbum, Album editedAlbum) {
    setState(() {
      biblioteca.updateAlbum(originalAlbum, editedAlbum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biblioteca de Álbumes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
          PopupMenuButton<MenuOptions>(
            onSelected: _onMenuSelected, 
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<MenuOptions>>[
              PopupMenuItem<MenuOptions>(
                value: MenuOptions.profile,
                child: Text('Perfil del usuario'),
              ),
              PopupMenuItem<MenuOptions>(
                value: MenuOptions.about,
                child: Text('Acerca de'),
              ),
            ],
          ),
        ],
      ),
      
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar datos: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: biblioteca.albumes.length, 
              itemBuilder: (BuildContext context, int index) {
                final album = biblioteca.albumes[index];
                return AlbumListItem(
                  album: album,
                  index: index,
                  // ELIMINACIÓN (ya implementada)
                  onDelete: (albumToDelete) { 
                    setState(() { 
                      biblioteca.removeAlbum(albumToDelete); 
                    });
                  },
                  // EDICIÓN (nueva implementación)
                  onEdit: _handleAlbumEdit, 
                );
              },
            );
          }
        },
      ),
      
      // Conectar el botón flotante a la función _navigateToAddAlbum
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddAlbum, 
        tooltip: 'Agregar álbum',
        child: const Icon(Icons.add),
      ),
    );
  }
}