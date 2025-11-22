import 'package:flutter/material.dart';
import 'package:album_biblio/album.dart'; // Importamos la clase Album

// 1. Clase AlbumVista (StatelessWidget)
class AlbumVista extends StatelessWidget {
  // 2. Propiedad 'album': Necesita recibir un objeto Album para mostrar sus datos.
  final Album album;

  // 3. Constructor: Requiere un objeto Album al ser creada.
  const AlbumVista({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Estructura base de la pantalla.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos del Album"), // Título: "Datos del Album"
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, // Color del contenedor terciario
      ),
      body: Center(
        child: Column( // Organiza todo verticalmente.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título: Se usa un Container con Row para el estilo del encabezado (Código 5-42)
            Container(
              color: Theme.of(context).colorScheme.tertiaryContainer, // Color de fondo del contenedor
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Título: ',
                    style: TextStyle (fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  // Muestra el título del álbum usando 'album.titulo'
                  Text(album.titulo, 
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20), // Separación

            // --- Campos de Información (Cantante, Año, Género) ---
            _buildDataRow(context, "Cantante:", album.cantante),
            _buildDataRow(context, "Año de lanzamiento:", album.anio.toString()), // Convertir int a String
            _buildDataRow(context, "Género:", album.genero),
          ],
        ),
      ),
    );
  }
  
  // Función auxiliar privada para construir las filas de datos con estilo uniforme
  Widget _buildDataRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacio entre etiqueta y valor
        children: [
          // Etiqueta (Ej. "Cantante:")
          Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // Valor (Ej. "Radiohead")
          Text(value,
            style: TextStyle(fontSize: 16.0, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}