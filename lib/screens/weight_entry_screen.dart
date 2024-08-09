// lib/screens/weight_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weight_provider.dart';
import '../models/weight_entry.dart';

class WeightEntryScreen extends StatelessWidget {
  final TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enregistrer le Poids')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Poids (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final weight = double.parse(_weightController.text);
                final entry = WeightEntry(date: DateTime.now(), weight: weight);
                Provider.of<WeightProvider>(context, listen: false).addEntry(entry);
                Navigator.pop(context);
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
