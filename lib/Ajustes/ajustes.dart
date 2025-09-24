import 'package:flutter/material.dart';
import '../main.dart';

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentMode, _) {
          // ✅ Si es system, vemos cómo está el sistema (oscuro o claro)
          bool isDark =
              currentMode == ThemeMode.dark ||
              (currentMode == ThemeMode.system &&
                  MediaQuery.of(context).platformBrightness == Brightness.dark);

          return ListView(
            children: [
              SwitchListTile(
                title: const Text('Modo oscuro'),
                subtitle: const Text('Activa o desactiva el tema oscuro'),
                value: isDark,
                onChanged: (val) {
                  themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Acerca de'),
                subtitle: const Text('Versión 1.0 - Autor: Jonathan Espinoza'),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Proyecto Flutter',
                    applicationVersion: '1.0',
                    applicationIcon: const Icon(Icons.flutter_dash, size: 50),
                    children: const [
                      Text(
                        'Esta aplicación fue desarrollada como práctica de Flutter por Jonathan Espinoza.',
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
