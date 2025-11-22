import 'package:flutter/material.dart';
import 'package:album_biblio/views/perfil_usuario.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album Biblio', // Título que aparece en la barra de tareas.
      theme: ThemeData(
        // Puedes cambiar el tema aquí. Usaremos el tema base.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      // home: Define la primera pantalla que se muestra.
      // Aquí usamos nuestro nuevo widget PerfilUsuario.
      home: const PerfilUsuario(),
    );
  }
}