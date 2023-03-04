import 'package:flutter/material.dart';
import '/screens/login.dart';
import '/screens/registro_Empresa.dart';
import '/screens/registro_Estudiante.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'V 0.1.0 Registro Empresas Agregado'),
      routes: {
        '/Login': (_) => const LoginScreen(),
        '/Registro_de_estudiantes': (_) => const RegistroEstudianteScreen(),
        '/Registro_de_empresas': (_) => const RegistroEmpresaScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          String itemName = '';
          switch (index) {
            case 0:
              itemName = 'Login Screen';
              break;
            case 1:
              itemName = 'Registro de Estudiantes Screen';
              break;
            case 2:
              itemName = 'Registro de Empresas Screen';
              break;
            default:
              itemName = 'Unknown';
              break;
          }
          return ListTile(
            title: Text(itemName),
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).pushNamed('/Login');
                  break;
                case 1:
                  Navigator.of(context).pushNamed('/Registro_de_estudiantes');
                  break;
                case 2:
                  Navigator.of(context).pushNamed('/Registro_de_empresas');
                  break;
                default:
              }
            },
          );
        },
        itemCount: 3,
      ),
    );
  }
}
