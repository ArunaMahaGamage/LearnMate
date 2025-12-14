import 'package:flutter/material.dart';
import '../core/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String language = AppConfig.supportedLanguages.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Language'),
          DropdownButton<String>(
            value: language,
            items: AppConfig.supportedLanguages.map((l) => DropdownMenuItem(value: l, child: Text(l.toUpperCase()))).toList(),
            onChanged: (val) {},
          ),
          const SizedBox(height: 16),
          SwitchListTile(title: const Text('Enable Offline Sync'), value: true, onChanged: (v) {}),
          const SizedBox(height: 16),
          SwitchListTile(title: const Text('Dark Theme'), value: false, onChanged: (v) {}),
        ],
      ),
    );
  }
}
