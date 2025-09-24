import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart'; // 👈 para usar AppDrawer

class JuegoRPS extends StatefulWidget {
  const JuegoRPS({super.key});

  @override
  State<JuegoRPS> createState() => _JuegoRPSState();
}

class _JuegoRPSState extends State<JuegoRPS> {
  final List<String> opciones = ["Piedra", "Papel", "Tijera"];
  String eleccionUsuario = "";
  String eleccionApp = "";
  String resultado = "";
  int marcadorUsuario = 0;
  int marcadorApp = 0;

  void jugar(String eleccion) {
    final random = Random();
    String appChoice = opciones[random.nextInt(opciones.length)];

    setState(() {
      eleccionUsuario = eleccion;
      eleccionApp = appChoice;
      resultado = determinarGanador(eleccionUsuario, eleccionApp);
    });
  }

  String determinarGanador(String usuario, String app) {
    if (usuario == app) {
      return "Empate";
    } else if ((usuario == "Piedra" && app == "Tijera") ||
        (usuario == "Papel" && app == "Piedra") ||
        (usuario == "Tijera" && app == "Papel")) {
      marcadorUsuario++;
      return "¡Ganaste!";
    } else {
      marcadorApp++;
      return "Perdiste";
    }
  }

  void reiniciarMarcador() {
    setState(() {
      marcadorUsuario = 0;
      marcadorApp = 0;
      eleccionUsuario = "";
      eleccionApp = "";
      resultado = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Juego: Piedra, Papel o Tijera")),
      drawer: const AppDrawer(), // 👈 aquí agregamos el Drawer

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Elige tu jugada:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: opciones.map((opcion) {
                return ElevatedButton(
                  onPressed: () => jugar(opcion),
                  child: Text(opcion),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            if (eleccionUsuario.isNotEmpty && eleccionApp.isNotEmpty) ...[
              Text(
                "Tú elegiste: $eleccionUsuario",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "La app eligió: $eleccionApp",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                resultado,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 30),
            Text("Marcador:", style: const TextStyle(fontSize: 20)),
            Text(
              "Usuario: $marcadorUsuario - App: $marcadorApp",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: reiniciarMarcador,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Reiniciar marcador"),
            ),
          ],
        ),
      ),
    );
  }
}
