import 'package:flutter/material.dart';
import '../Practicas_Previas/formulario.dart';
import '../Practicas_Previas/practica3.dart';
import '../Practicas_Previas/practica4.dart';
import '../Practicas_Previas/juego.dart';

class HubPracticas extends StatefulWidget {
  const HubPracticas({super.key});

  @override
  State<HubPracticas> createState() => _HubPracticasState();
}

class _HubPracticasState extends State<HubPracticas> {
  int _currentIndex = 0;

  final List<Widget> _modulos = [
    const Formulario(),
    const Practica3(),
    const Practica4(),
    const JuegoRPS(),
  ];

  final List<String> _titulos = [
    'Formulario',
    'Práctica 3',
    'Práctica 4',
    'Juego: Piedra, Papel o Tijera',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulos[_currentIndex]),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: _modulos[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_center),
            label: 'Formulario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: 'Práctica 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_4),
            label: 'Práctica 4',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Juego',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
