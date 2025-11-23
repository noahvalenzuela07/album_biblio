// lib/views/album_list.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart';
import 'package:album_biblio/album_biblio.dart';
import 'package:album_biblio/views/album_list_item.dart';
import 'package:album_biblio/views/perfil_usuario.dart';
import 'package:album_biblio/views/acerca_de_vista.dart';
import 'package:album_biblio/views/album_form.dart'; // <--- NUEVA IMPORTACIÓN DEL FORMULARIO

// Enum para las opciones del menú emergente (sin cambios)
enum MenuOptions {
  profile,
  about,
}

// 1. CONVERSIÓN A STATEFULWIDGET
class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}
// CLASE DE ESTADO MODIFICADA
class _AlbumListState extends State<AlbumList> {
  // Mover la biblioteca al estado
  final AlbumBiblio biblioteca = AlbumBiblio(); 
  
  // 1. Variable para almacenar el Future de la carga de datos
  late Future<void> _loadFuture;

  // 2. Inicializar la data llamando a loadAlbumes
  @override
  void initState() {
    super.initState();
    // Llamamos al método de carga y asignamos el Future a la variable
    _loadFuture = _initializeData(); 
  }
  
  // Función asíncrona que gestiona la carga de datos
  Future<void> _initializeData() async {
    // Llama al método de AlbumBiblio para leer del archivo JSON
    await biblioteca.loadAlbumes(); 

    // Si la lista está vacía (es la primera vez que se ejecuta), 
    // añade algunos datos de demostración y los guarda.
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
      // Opcional: podrías agregar más álbumes de ejemplo aquí.
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

  // Método que se llamará desde el FloatingActionButton (sin cambios)
  void _navigateToAddAlbum() async {
    final newAlbum = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumForm(), 
      ),
    );

    if (newAlbum != null && newAlbum is Album) {
      // Usar setState para actualizar la lista después de la adición
      setState(() {
        biblioteca.addAlbum(newAlbum); // addAlbum ahora guarda automáticamente
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
      
      // 3. USO DE FUTUREBUILDER PARA MANEJAR LA CARGA
      body: FutureBuilder<void>(
        future: _loadFuture, // Esperamos que la inicialización termine
        builder: (context, snapshot) {
          // Si el Future está esperando o ha fallado
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga en el centro
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Manejo de errores durante la carga
            return Center(child: Text('Error al cargar datos: ${snapshot.error}'));
          } else {
            // Si el Future ha terminado (ConnectionState.done)
            return ListView.builder(
              itemCount: biblioteca.albumes.length, 
              itemBuilder: (BuildContext context, int index) {
                return AlbumListItem(
                  album: biblioteca.albumes[index],
                  index: index,
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