// lib/views/acerca_de_vista.dart

import 'package:flutter/material.dart';

class AcercaDeVista extends StatelessWidget {
  const AcercaDeVista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de Album Biblio"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Icono de la aplicación
            Icon(
              Icons.library_music,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            // Título
            const Text(
              "Album Biblio",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Versión
            const Text(
              "Versión 1.0 (Práctica Flutter)",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            // Créditos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Aplicación desarrollada como proyecto universitario con Flutter, siguiendo la guía del profesor.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}