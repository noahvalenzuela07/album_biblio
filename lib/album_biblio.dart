// lib/album_biblio.dart

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:album_biblio/album.dart';
import 'package:flutter/foundation.dart'; // <--- SOLUCIÓN: Agregamos la importación para debugPrint

// Constante para el nombre del archivo
const String _fileName = 'albumes.json';

// Clase que gestiona la colección de álbumes
class AlbumBiblio {
  
  // Lista privada: Almacena los objetos Album.
  final List<Album> _listaAlbumes = [];

  // Constructor vacío
  AlbumBiblio();

  // 1. CONSTRUCTOR PARA DECODIFICAR DESDE JSON (Lista de Mapas)
  AlbumBiblio.fromJson(List<dynamic> jsonList) {
    // Itera sobre la lista de mapas JSON y crea un objeto Album por cada uno
    for (var jsonMap in jsonList) {
      _listaAlbumes.add(Album.fromJson(jsonMap as Map<String, dynamic>));
    }
  }

  // 2. MÉTODO PARA CODIFICAR A JSON (Lista de Mapas)
  // Devuelve una lista de mapas (JSON) de todos los álbumes
  List<Map<String, dynamic>> toJson() => 
      _listaAlbumes.map((album) => album.toJson()).toList();

  // Getter: Permite acceder a la lista desde fuera
  List<Album> get albumes => _listaAlbumes;
  
  // ----------------------------------------------------
  // MÉTODOS DE GESTIÓN DE ARCHIVOS
  // ----------------------------------------------------

  // Obtiene la ruta completa del archivo de documentos del dispositivo
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  // Guarda la lista de álbumes en el archivo JSON
  Future<void> _writeAlbumes() async {
    final file = File(await _getFilePath());
    // 1. Convierte la lista de álbumes a formato JSON (lista de Mapas)
    final jsonList = toJson();
    // 2. Convierte la lista de Mapas a un String JSON
    final jsonString = jsonEncode(jsonList);
    // 3. Escribe el string en el archivo
    await file.writeAsString(jsonString);
    debugPrint('Datos guardados en: ${file.path}');
  }

  // Lee la lista de álbumes desde el archivo JSON
  Future<List<Album>> _readAlbumes() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) {
        debugPrint('Archivo JSON no encontrado. Retornando lista vacía.');
        return [];
      }
      
      // 1. Lee el contenido del archivo como String
      final jsonString = await file.readAsString();
      // 2. Decodifica el String JSON a una lista de Mapas
      final List<dynamic> jsonList = jsonDecode(jsonString);
      
      // 3. Crea una instancia de AlbumBiblio a partir de la lista decodificada
      final loadedBiblio = AlbumBiblio.fromJson(jsonList);
      debugPrint('Datos cargados desde archivo: ${loadedBiblio.albumes.length} álbumes.');

      return loadedBiblio.albumes;
      
    } catch (e) {
      debugPrint("Error al leer el archivo JSON: $e");
      return []; // En caso de error, retorna una lista vacía
    }
  }

  // ----------------------------------------------------
  // MÉTODOS DE MODIFICACIÓN DE DATOS (AHORA PERSISTENTES)
  // ----------------------------------------------------

  // Agrega un álbum y guarda la lista
  void addAlbum(Album album) {
    _listaAlbumes.add(album);
    _writeAlbumes();
  }

  // NUEVO MÉTODO: Remueve un álbum y guarda la lista
  void removeAlbum(Album album) {
    // Es mejor usar removeWhere con múltiples campos, ya que Album no tiene un ID único.
    _listaAlbumes.removeWhere((a) => 
        a.titulo == album.titulo && 
        a.cantante == album.cantante && 
        a.anio == album.anio
    );
    _writeAlbumes(); // Guarda los cambios inmediatamente después de eliminar
  }
  
  // Método para cargar datos al inicio (usado por AlbumList)
  Future<void> loadAlbumes() async {
    _listaAlbumes.addAll(await _readAlbumes());
  }
}