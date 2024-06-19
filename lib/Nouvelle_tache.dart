import 'package:flutter/material.dart';
import 'package:flutter_layout/models/task.dart';

class NouvelleTache extends StatefulWidget {
  @override
  _NouvelleTacheState createState() => _NouvelleTacheState();
}

class _NouvelleTacheState extends State<NouvelleTache> {
  final _titreController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _statutSelectionne = TaskStatus.values.first.toString();

  // Fonction pour ajouter une nouvelle tâche et revenir à la page principale
  void _ajouterTache() {
    final nouvelleTache = Task(
      _titreController.text,
      _descriptionController.text,
      TaskStatus.fromString(_statutSelectionne),
    );
    Navigator.pop(context, nouvelleTache);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titreController,
              decoration:
                  InputDecoration(hintText: 'Entrer le titre de la tâche...'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Entrer la description de la tâche...'),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _statutSelectionne,
              items: TaskStatus.values
                  .map((status) => DropdownMenuItem<String>(
                        value: status.toString(),
                        child: Text(status.toString().split('.').last),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _statutSelectionne = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _ajouterTache,
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
