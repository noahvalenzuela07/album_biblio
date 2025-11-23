// lib/views/album_form.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necesario para TextInputFormatter
import 'package:album_biblio/album.dart'; // Necesitamos el modelo Album

// StatelessWidget para el Formulario
class AlbumForm extends StatelessWidget {
  // Clave global para identificar y manipular el widget Form
  // ¡ES REQUERIDO POR EL DOCUMENTO DEL PROFESOR!
  final _formKey = GlobalKey<FormState>();

  // Variables para almacenar los datos del formulario
  String? _titulo;
  String? _cantante;
  int? _anio;
  String? _genero;

  AlbumForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Nuevo Álbum"),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      body: SingleChildScrollView( // Permite hacer scroll si el teclado cubre el formulario
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asignamos la llave global al widget Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 1. Campo Título ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Título del Álbum',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.album),
                ),
                // Validacion: No puede estar vacío
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el título del álbum.';
                  }
                  return null; // La validación es exitosa
                },
                // Al guardar: Asigna el valor a la variable
                onSaved: (value) {
                  _titulo = value;
                },
              ),
              const SizedBox(height: 20),

              // --- 2. Campo Cantante/Artista ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cantante / Artista',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre del artista.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cantante = value;
                },
              ),
              const SizedBox(height: 20),

              // --- 3. Campo Año ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Año de Lanzamiento',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                // Solo permite números
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Solo acepta dígitos
                ],
                // Validacion: Debe ser un número válido de 4 dígitos (simple)
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un año.';
                  }
                  if (int.tryParse(value) == null || value.length != 4) {
                    return 'Debe ser un año válido (4 dígitos).';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Guardar el valor como entero (int)
                  _anio = int.tryParse(value!);
                },
              ),
              const SizedBox(height: 20),

              // --- 4. Campo Género ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Género Musical',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.music_note),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el género.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _genero = value;
                },
              ),
              const SizedBox(height: 40),

              // --- Botón de Guardar ---
              ElevatedButton.icon(
                onPressed: () {
                  // 1. Validar el formulario usando la clave
                  if (_formKey.currentState!.validate()) {
                    // 2. Si es válido, guardar los datos en las variables
                    _formKey.currentState!.save();
                    
                    // 3. Crear el nuevo objeto Album
                    final newAlbum = Album(
                      titulo: _titulo!,
                      cantante: _cantante!,
                      anio: _anio!,
                      genero: _genero!,
                    );
                    
                    // 4. Regresar el nuevo álbum a la pantalla anterior (AlbumList)
                    Navigator.pop(context, newAlbum);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar Álbum'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              // --- Botón de Cancelar ---
              OutlinedButton.icon(
                onPressed: () {
                  // Regresa 'null' para indicar que no se agregó nada
                  Navigator.pop(context, null); 
                },
                icon: const Icon(Icons.cancel),
                label: const Text('Cancelar'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}