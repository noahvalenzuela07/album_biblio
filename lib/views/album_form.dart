// lib/views/album_form.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:album_biblio/album.dart'; 

// El formulario debe ser StatefulWidget para inicializar los campos
class AlbumForm extends StatefulWidget {
  // El formulario acepta un álbum opcional. Si es null, es Agregar. Si existe, es Editar.
  final Album? albumToEdit; 

  const AlbumForm({super.key, this.albumToEdit});

  @override
  State<AlbumForm> createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  final _formKey = GlobalKey<FormState>();

  // Variables para almacenar los datos del formulario
  late String _titulo;
  late String _cantante;
  late int _anio;
  late String _genero;
  
  // Usamos initState para inicializar las variables con el álbum existente (si lo hay)
  @override
  void initState() {
    super.initState();
    // 1. Si estamos editando, usamos los datos del álbum existente
    if (widget.albumToEdit != null) {
      _titulo = widget.albumToEdit!.titulo;
      _cantante = widget.albumToEdit!.cantante;
      _anio = widget.albumToEdit!.anio;
      _genero = widget.albumToEdit!.genero;
    } else {
      // 2. Si estamos agregando, inicializamos con valores vacíos (o predeterminados)
      _titulo = '';
      _cantante = '';
      _anio = 0; // Usaremos 0 como un placeholder inicial
      _genero = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definimos el texto del título basado en si estamos editando o agregando
    final isEditing = widget.albumToEdit != null;
    final titleText = isEditing ? "Editar Álbum" : "Agregar Nuevo Álbum";
    
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 1. Campo Título ---
              TextFormField(
                // Establece el valor inicial para el modo edición
                initialValue: isEditing ? widget.albumToEdit!.titulo : null,
                decoration: const InputDecoration(
                  labelText: 'Título del Álbum',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.album),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el título del álbum.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _titulo = value!;
                },
              ),
              const SizedBox(height: 20),

              // --- 2. Campo Cantante/Artista ---
              TextFormField(
                // Establece el valor inicial para el modo edición
                initialValue: isEditing ? widget.albumToEdit!.cantante : null,
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
                  _cantante = value!;
                },
              ),
              const SizedBox(height: 20),

              // --- 3. Campo Año ---
              TextFormField(
                // Establece el valor inicial para el modo edición (convertido a String)
                initialValue: isEditing ? widget.albumToEdit!.anio.toString() : null,
                decoration: const InputDecoration(
                  labelText: 'Año de Lanzamiento',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, 
                ],
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
                  _anio = int.parse(value!); // Usamos parse porque ya validamos
                },
              ),
              const SizedBox(height: 20),

              // --- 4. Campo Género ---
              TextFormField(
                // Establece el valor inicial para el modo edición
                initialValue: isEditing ? widget.albumToEdit!.genero : null,
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
                  _genero = value!;
                },
              ),
              const SizedBox(height: 40),

              // --- Botón de Guardar ---
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                    // Creamos el álbum, ya sea nuevo o con los datos actualizados
                    final savedAlbum = Album(
                      titulo: _titulo,
                      cantante: _cantante,
                      anio: _anio,
                      genero: _genero,
                    );
                    
                    // Regresamos el álbum guardado a la pantalla anterior (AlbumList)
                    // Nota: No distinguimos entre nuevo o editado aquí; AlbumList lo hará.
                    Navigator.pop(context, savedAlbum);
                  }
                },
                icon: const Icon(Icons.save),
                label: Text(isEditing ? 'Guardar Cambios' : 'Guardar Nuevo Álbum'),
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
                  // Regresa 'null' para indicar que no se agregó ni se editó nada
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