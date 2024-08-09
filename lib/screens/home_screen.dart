import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/weight_provider.dart';
import 'login_screen.dart';
import 'weight_entry_screen.dart';
import '../widgets/weight_chart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final weightProvider = Provider.of<WeightProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logoutUser(); // Logout the user
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text('Bienvenue, ${authProvider.loggedInUser}'), // Display logged-in user's name
          Expanded(child: WeightChart(entries: weightProvider.entries)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeightEntryScreen()),
              );
            },
            child: Text('Ajouter un Poids'),
          ),
        ],
      ),
    );
  }
}
