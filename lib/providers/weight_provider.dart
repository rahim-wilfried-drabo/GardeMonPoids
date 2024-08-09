import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/weight_entry.dart';
import 'dart:convert';

class WeightProvider with ChangeNotifier {
  final _storage = FlutterSecureStorage();
  List<WeightEntry> _entries = [];

  List<WeightEntry> get entries => _entries;

  WeightProvider() {
    _loadEntries();
  }

  void addEntry(WeightEntry entry) {
    _entries.add(entry);
    _saveEntries();
    notifyListeners();
  }

  void _saveEntries() async {
    List<String> entriesJson = _entries.map((entry) => jsonEncode(entry.toJson())).toList();
    await _storage.write(key: 'weight_entries', value: jsonEncode(entriesJson));
  }

  void _loadEntries() async {
    String? entriesJson = await _storage.read(key: 'weight_entries');
    if (entriesJson != null) {
      List<dynamic> entriesList = jsonDecode(entriesJson);
      _entries = entriesList.map((entry) => WeightEntry.fromJson(jsonDecode(entry))).toList();
      notifyListeners();
    }
  }
}