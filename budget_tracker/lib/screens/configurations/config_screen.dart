import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/general/drawer_default.dart';
import '../../widgets/general/theme_model.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({Key? key}) : super(key: key);
  static const String name = '/config_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerDefault(),
      body: Consumer<ThemeModel>(
        builder: (context, themeModel, _) => ListView(
          children: [
            ListTile(
              title: const Text('Modo Escuro'),
              trailing: Switch(
                value: themeModel.darkModeEnabled,
                onChanged: (value) {
                  themeModel.toggleDarkMode(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
