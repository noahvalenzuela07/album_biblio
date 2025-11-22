import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de usuario"), 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, 
      ),
      body: Center( 
        child: Padding( 
          padding: const EdgeInsets.all(8.0),
          child: Container( 
            width: 400,
            height: 600,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary, 
              border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(50), 
              boxShadow: [ 
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container( 
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  child: ClipRRect( 
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.white, // Fondo del círculo (Blanco)
                      child: const Icon( // Icono de usuario de ejemplo[cite: 666].
                        Icons.person,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                
                // --- 2. NOMBRE DEL USUARIO ---
                const Text( // Muestra el nombre[cite: 660, 645].
                  "Noah Valenzuela", 
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const Divider(height: 30, thickness: 2, indent: 50, endIndent: 50), // [cite: 661]

                const Text( 
                  "Metalero Promedio",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
                
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    "En este perfil escuchamos metal, rock, baladas y aveces jose jose",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.black54),
                  ),
                ),

                const Divider(height: 40, thickness: 1, indent: 30, endIndent: 30),

                const Text( 
                  "Contacto:",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8), 
                const Text(
                  "Email: l21330812@hermosillo.tecnm.mx",
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
                const Text( 
                  "Tel: +52 6624267331",
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}