import 'package:flutter/material.dart';
import '../KitOffline/notas_rapidas.dart';
import '../KitOffline/imc.dart';
import '../KitOffline/galeria.dart';
import '../KitOffline/juego_par_impar.dart';
import '../main.dart'; // Solo si necesitas AppDrawer

class KitOffline extends StatefulWidget {
  const KitOffline({super.key});

  @override
  State<KitOffline> createState() => _KitOfflineState();
}

class _KitOfflineState extends State<KitOffline> {
  int _currentIndex = 0;

  final List<Widget> _modulos = [
    const NotasRapidas(),
    const CalculadoraIMC(),
    const GaleriaLocal(),
    const JuegoParImpar(),
  ];

  final List<String> _titulos = [
    'Notas rápidas',
    'Calculadora IMC',
    'Galería local',
    'Juego Par/Impar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titulos[_currentIndex])),
      drawer: AppDrawer(currentRoute: '/kitoffline'), // Drawer dinámico
      body: _modulos[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notas'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'IMC'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Galería'),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Juego'),
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
