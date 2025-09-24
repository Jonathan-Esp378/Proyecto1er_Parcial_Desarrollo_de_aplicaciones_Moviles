import 'package:flutter/material.dart';

// Importar tus pantallas
import 'Practicas_Previas/Formulario.dart';
import 'Practicas_Previas/practica3.dart';
import 'Practicas_Previas/practica4.dart';
import 'Practicas_Previas/juego.dart';

import 'Hubs/kitoffline.dart';
import 'Ajustes/ajustes.dart';
import 'Hubs/hub_practicas.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Proyecto Flutter',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const HubScreen(),
            '/formulario': (context) => const Formulario(),
            '/practica3': (context) => const Practica3(),
            '/practica4': (context) => const Practica4(),
            '/juego': (context) => const JuegoRPS(),
            '/kitoffline': (context) => const KitOffline(),
            '/ajustes': (context) => const AjustesScreen(),
            '/practicas': (context) => const HubPracticas(),
          },
        );
      },
    );
  }
}

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Principal')),
      drawer: const AppDrawer(),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCard(context, Icons.assignment, 'Prácticas', '/practicas'),
          _buildCard(
            context,
            Icons.apps,
            'Proyecto: Kit Offline',
            '/kitoffline',
          ),
          _buildCard(context, Icons.settings, 'Ajustes', '/ajustes'),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, this.currentRoute = '/'});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Text(
              "Menú de prácticas",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          // ✅ Formularios y prácticas
          _drawerItem(
            context,
            icon: Icons.format_align_center,
            text: 'Formulario',
            route: '/formulario',
          ),
          _drawerItem(
            context,
            icon: Icons.looks_3,
            text: 'Práctica 3',
            route: '/practica3',
          ),
          _drawerItem(
            context,
            icon: Icons.looks_4,
            text: 'Práctica 4',
            route: '/practica4',
          ),
          _drawerItem(
            context,
            icon: Icons.sports_esports,
            text: 'Juego: Piedra, Papel o Tijera',
            route: '/juego',
          ),

          const Divider(),

          //Proyecto (Kit Offline)
          _drawerItem(
            context,
            icon: Icons.workspaces_outline,
            text: 'Proyecto: Kit Offline',
            route: '/kitoffline',
          ),

          const Divider(),

          //Inicio
          _drawerItem(context, icon: Icons.home, text: 'Inicio', route: '/'),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.pop(context); // cierra el drawer primero
        if (ModalRoute.of(context)?.settings.name != route) {
          // navega solo si no estamos en la ruta actual
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}
