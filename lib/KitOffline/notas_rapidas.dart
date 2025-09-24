import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotasRapidas extends StatefulWidget {
  const NotasRapidas({super.key});

  @override
  State<NotasRapidas> createState() => _NotasRapidasState();
}

class _NotasRapidasState extends State<NotasRapidas> {
  final TextEditingController _controller = TextEditingController();
  List<String> _notas = [];

  @override
  void initState() {
    super.initState();
    _cargarNotas();
  }

  // Carga las notas desde SharedPreferences
  Future<void> _cargarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notas = prefs.getStringList('notas') ?? [];
    });
  }

  // Guarda las notas en SharedPreferences
  Future<void> _guardarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notas', _notas);
  }

  void _agregarNota() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _notas.add(_controller.text);
      _controller.clear();
    });
    _guardarNotas();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Nota agregada')));
  }

  void _editarNota(int index) {
    _controller.text = _notas[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar nota'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nueva nota'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _controller.clear();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _notas[index] = _controller.text;
                  _controller.clear();
                });
                _guardarNotas();
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _borrarNota(int index) {
    setState(() {
      _notas.removeAt(index);
    });
    _guardarNotas();
  }

  void _borrarTodasNotas() {
    setState(() {
      _notas.clear();
    });
    _guardarNotas();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Todas las notas borradas')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas rápidas'),
        actions: [
          IconButton(
            onPressed: _borrarTodasNotas,
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Nueva nota'),
                  ),
                ),
                IconButton(
                  onPressed: _agregarNota,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _notas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notas[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editarNota(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _borrarNota(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
