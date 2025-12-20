// lib/views/settings_screen.dart (UPDATED & SIMPLIFIED)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings.dart';
import '../viewmodels/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // --- 1. General Preferences ---
          const _SettingsSectionTitle(title: 'General Preferences'),

          _ThemeModeSettingTile(settings: settings, notifier: notifier),

          ListTile(
            title: const Text('Language'),
            subtitle: Text(settings.preferredLanguage),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () async {
              final selected = await _showLanguagePicker(
                context,
                settings.preferredLanguage,
              );
              if (selected != null && context.mounted) {
                notifier.setPreferredLanguage(selected);
              }
            },
          ),

          const Divider(height: 30),

          // --- 2. About ---
          const _SettingsSectionTitle(title: 'About'),

          ListTile(
            title: const Text('Version'),
            trailing: Text(
              '1.0.0',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const Divider(height: 30),

          // --- 3. Account ---
          const _SettingsSectionTitle(title: 'Account'),

          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

// ---------------- HELPER WIDGETS ----------------

class _SettingsSectionTitle extends StatelessWidget {
  final String title;
  const _SettingsSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _ThemeModeSettingTile extends StatelessWidget {
  final Settings settings;
  final SettingsNotifier notifier;

  const _ThemeModeSettingTile({
    required this.settings,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('App Theme'),
      subtitle: Text(
        settings.themeMode.toString().split('.').last.toUpperCase(),
      ),
      trailing: const Icon(Icons.style),
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Select Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: AppThemeMode.values.map((mode) {
                return RadioListTile<AppThemeMode>(
                  title: Text(mode.toString().split('.').last),
                  value: mode,
                  groupValue: settings.themeMode,
                  onChanged: (newMode) {
                    if (newMode != null) {
                      notifier.setThemeMode(newMode);
                      Navigator.pop(ctx);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

// ---------------- LANGUAGE PICKER ----------------

Future<String?> _showLanguagePicker(
  BuildContext context,
  String current,
) async {
  const languages = ['English', 'Tamil', 'Sinhala'];

  return await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: languages.map((lang) {
          return RadioListTile<String>(
            title: Text(lang),
            value: lang,
            groupValue: current,
            onChanged: (newLang) {
              if (newLang != null) {
                Navigator.pop(ctx, newLang);
              }
            },
          );
        }).toList(),
      ),
    ),
  );
}

// ---------------- LOGOUT DIALOG ----------------

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            debugPrint('User logged out');
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
