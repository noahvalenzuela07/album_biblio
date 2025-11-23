import 'package:flutter/material.dart';
// Solo importamos la lista
import 'package:album_biblio/views/album_list.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ahora no necesitamos inicializar la biblioteca aquí
    return MaterialApp(
      title: 'Album Biblio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      // home: Solo llamamos a AlbumList, que ya es Stateful
      home: const AlbumList(),
    );
  }
}