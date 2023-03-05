import 'package:flutter/material.dart';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

class RegistroEmpresaScreen extends StatefulWidget {
  const RegistroEmpresaScreen({Key? key}) : super(key: key);

  @override
  _RegistroEmpresaScreenState createState() => _RegistroEmpresaScreenState();
}

class _RegistroEmpresaScreenState extends State<RegistroEmpresaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKey_2 = GlobalKey<FormState>();
  int currentStep = 0;
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

  final List<String> _areasInteres = [
    'Ingeniería',
    'Medicina',
    'Arquitectura',
    'Derecho',
    'Ciencias económicas',
    'Educación',
    'Ciencias sociales',
    'Arte y diseño',
    'Comunicación',
    'Otro',
  ];
  List<String> _selectedAreas = [];
// Define a variable to hold the selected state
  String? _selectedState;
  String? _selectedIndustry;
  bool _showPassword = false;
  String? _password;
  String? _email;
  String? _nombre = '';
  String? _industria = '';
  DateTime? _fundacion;
  String? _rfc = '';
  String? _ciudad = '';
  String? _pais = 'Mexico';
  String? _calle = '';
  String? _codigoPostal = '';
  List<String> _areasDeInteres = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Registro de Empresa')),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () async {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              print('Completed');
            } else {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() {
                  currentStep += 1;
                });
              }
            }
          },
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder:
              (BuildContext context, ControlsDetails controlsDetails) {
            final isLastStep = currentStep == getSteps().length - 1;
            return Container(
                margin: EdgeInsets.only(top: 50),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: controlsDetails.onStepContinue,
                        child: Text(isLastStep ? 'Confirm' : 'Next'),
                      ),
                    ),
                    if (currentStep != 0)
                      TextButton(
                        onPressed: controlsDetails.onStepCancel,
                        child: const Text('Back'),
                      ),
                  ],
                ));
          },
        ),
      );

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Cuenta'),
          content: Form(
            key: _formKey,
            child: Column(children: <Widget>[
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
                  _nombre = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un correo electrónico válido';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor ingresa un correo electrónico válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                  // Save the email input to a variable
                },
              ),
              TextFormField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      semanticLabel: _showPassword
                          ? 'Ocultar contraseña'
                          : 'Mostrar contraseña',
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  if (value.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres';
                  }
                  if (!value.contains(new RegExp(r'(?=.*?[A-Z])'))) {
                    return 'La contraseña debe contener al menos una letra mayúscula';
                  }
                  if (!value.contains(new RegExp(r'(?=.*?[a-z])'))) {
                    return 'La contraseña debe contener al menos una letra minúscula';
                  }
                  if (!value
                      .contains(new RegExp(r'(?=.*?[!@#$%^&*(),.?":{}|<>])'))) {
                    return 'La contraseña debe contener al menos un símbolo especial';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
            ]),
          ),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('Información de la empresa'),
            content: Form(
              key: _formKey_2,
              child: Column(children: <Widget>[
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
                const SizedBox(height: 16.0),
                ExpansionTile(
                  title: const Text('Áreas de interés'),
                  children: _areasInteres.map((area) {
                    return CheckboxListTile(
                      title: Text(area),
                      value: _selectedAreas.contains(area),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            _selectedAreas.add(area);
                          } else {
                            _selectedAreas.remove(area);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ]),
            )),
        Step(
          isActive: currentStep >= 2,
          title: Text('Listo'),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nombre: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_nombre ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_email ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_password ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Industria: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_industria?.toString() ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fundación: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_fundacion?.toString() ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RFC: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_rfc?.toString() ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ciudad: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_ciudad?.toString() ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'País: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_pais?.toString() ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Calle: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_calle?.toString() ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Código Postal: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_codigoPostal?.toString() ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Areás de Interés: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 Text(_selectedAreas.toString() ?? ''),
                ],
              ),
            ],
          ),
        )
      ];
}
