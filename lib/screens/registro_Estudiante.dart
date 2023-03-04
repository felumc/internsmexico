import 'dart:ffi';

import 'package:flutter/material.dart';


class RegistroEstudianteScreen extends StatelessWidget {
  const RegistroEstudianteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de estudiante')),
      body: const RegistroEstudianteForm(),
    );
  }
}

class RegistroEstudianteForm extends StatefulWidget {
  const RegistroEstudianteForm({Key? key}) : super(key: key);

  @override
  _RegistroEstudianteFormState createState() => _RegistroEstudianteFormState();
}

class _RegistroEstudianteFormState extends State<RegistroEstudianteForm> {
  final _formKey = GlobalKey<FormState>();

  String? _nombre;
  String? _apellidopaterno;
  String? _apellidomaterno;
  String? _correo;
  String? _password;
  Int? _edad;
  String? _universidad;
  String? _carrera;
  String? _pais;
  String? _estado;
  String? _localidad;
  String? _url_cv;
  String? _url_foto;
  Int? _semestre;
  List<String> _aptitudes = [];
  List<String> _puesto_de_interes = [];
  String? _descripcion_personal;
  Int? _horas_total_practicas;
  String? _modalidad;
  String? _tipo_de_contrato;
  List<String> _contacto = [];
  String? _numero_celular;
  String? _numero_fijo;



 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
              onSaved: (value) {
                _nombre = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Apellido Paterno'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un apellido';
                }
                return null;
              },
              onSaved: (value) {
                _apellidopaterno = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Correo'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
                if (!value.contains('@')) {
                  return 'Por favor ingrese un correo válido';
                }
                return null;
              },
              onSaved: (value) {
                _correo = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Universidad'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una universidad';
                }
                return null;
              },
              onSaved: (value) {
                _universidad = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Carrera'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una carrera';
                }
                return null;
              },
              onSaved: (value) {
                _carrera = value;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Aquí puedes hacer lo que quieras con los datos del formulario
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
