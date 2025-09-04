import 'package:flutter/material.dart';
import 'practica3.dart';
import 'practica4.dart';
import 'Formulario.dart'; // 👈 nuevo import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prácticas Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prácticas Flutter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Practica3()),
                );
              },
              child: const Text('Ir a Práctica 3'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Practica4()),
                );
              },
              child: const Text('Ir a Práctica 4'),
            ),
            const SizedBox(height: 20),
            // 👇 Nuevo botón para ir al formulario
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Formulario()),
                );
              },
              child: const Text('Ir a Formulario'),
            ),
          ],
        ),
      ),
    );
  }
}
