import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.changeTheme});

  final Function(int) changeTheme;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedTheme = 'System Mode';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Theme',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedTheme,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedTheme = newValue;
                        if (newValue == 'System Mode') {
                          widget.changeTheme(0);
                        } else if (newValue == 'Light Mode') {
                          widget.changeTheme(1);
                        } else if (newValue == 'Dark Mode') {
                          widget.changeTheme(2);
                        }
                      });
                    }
                  },
                  items: <String>['System Mode', 'Light Mode', 'Dark Mode']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Add more settings as needed
          ],
        ),
      ),
    );
  }
}
