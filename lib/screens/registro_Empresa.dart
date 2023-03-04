import 'package:flutter/material.dart';

class RegistroEmpresaScreen extends StatefulWidget {
  const RegistroEmpresaScreen({Key? key}) : super(key: key);

  @override
  _RegistroEmpresaScreenState createState() => _RegistroEmpresaScreenState();
}

class _RegistroEmpresaScreenState extends State<RegistroEmpresaScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _industries = [
    'Tecnología',
    'Transporte',
    'Alimentos',
    'Construcción',
    'Educación',
    // add more industries as needed
  ];
  // Define a list of Mexican states
  final List<String> estados = [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'Coahuila',
    'Colima',
    'Durango',
    'Estado de México',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco',
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas',
  ];

// Define a variable to hold the selected state
  String? _selectedState;
  String? _selectedIndustry;

  String _nombre = '';
  String _industria = '';
  DateTime? _fundacion;
  String _rfc = '';
  String _ciudad = '';
  String _pais = 'Mexico';
  String _calle = '';
  String _codigoPostal = '';
  List<String> _areasDeInteres = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Empresa'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
              onSaved: (value) {
                _nombre = value!;
              },
            ),
            DropdownButtonFormField<String>(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Industria',
              ),
              value: _selectedIndustry,
              onChanged: (newValue) {
                setState(() {
                  _selectedIndustry = newValue!;
                });
              },
              items: _industries
                  .map((industry) => DropdownMenuItem<String>(
                        value: industry,
                        child: Text(industry),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione una industria';
                }
                return null;
              },
              onSaved: (value) {
                _industria = value!;
              },
            ),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Fundación',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una fecha de fundación';
                }
                return null;
              },
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _fundacion = picked;
                  });
                }
              },
              readOnly: true,
              controller: TextEditingController(
                text: _fundacion != null
                    ? "${_fundacion!.day}/${_fundacion!.month}/${_fundacion!.year}"
                    : "",
              ),
            ),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'RFC',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un RFC';
                }
                return null;
              },
              onSaved: (value) {
                _rfc = value!;
              },
            ),
            DropdownButtonFormField<String>(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Ciudad',
              ),
              value: _selectedState,
              onChanged: (String? value) {
                setState(() {
                  _selectedState = value;
                });
              },
              items: estados.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione una ciudad';
                }
                return null;
              },
              onSaved: (value) {
                _ciudad = value!;
              },
            ),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'País',
              ),
              initialValue: 'Mexico',
              readOnly: true,
            ),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Calle',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una calle';
                }
                return null;
              },
              onSaved: (value) {
                _calle = value!;
              },
            ),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Código postal',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un código postal';
                }
                return null;
              },
              onSaved: (value) {
                _codigoPostal = value!;
              },
            ),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Áreas de interés',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese al menos un área de interés';
                }
                return null;
              },
              onSaved: (value) {
                _areasDeInteres = value!.split(',');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Here you can do something with the saved data, for example,
                  // send it to a backend server or save it to a local database.

                  Navigator.of(context).pop();
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
