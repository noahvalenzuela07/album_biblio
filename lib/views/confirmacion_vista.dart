// lib/views/confirmacion_vista.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart';

class ConfirmacionVista extends StatelessWidget {
  final Album album;

  const ConfirmacionVista({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmar Eliminación"),
        backgroundColor: Theme.of(context).colorScheme.errorContainer, // Color que indica advertencia
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Estirar botones
            children: <Widget>[
              // Mensaje de advertencia
              const Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 20),
              
              // Texto principal de confirmación
              Text(
                "¿Está seguro de que desea eliminar el álbum:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18, 
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              
              // Nombre del álbum a eliminar (destacado)
              Text(
                '${album.titulo} de ${album.cantante}?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 40),

              // --- Botones de Acción ---
              
              // Botón 1: Confirmar Eliminación
              ElevatedButton.icon(
                onPressed: () {
                  // Retorna 'true' a la pantalla anterior (AlbumListItem)
                  // para indicar que SÍ se debe eliminar.
                  Navigator.pop(context, true); 
                },
                icon: const Icon(Icons.check),
                label: const Text("Confirmar Eliminación"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              const SizedBox(height: 15),

              // Botón 2: Cancelar
              OutlinedButton.icon(
                onPressed: () {
                  // Retorna 'false' a la pantalla anterior
                  // para indicar que NO se debe eliminar.
                  Navigator.pop(context, false); 
                },
                icon: const Icon(Icons.cancel),
                label: const Text("Cancelar"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}