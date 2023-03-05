import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;


class RegistroEstudianteScreen extends StatefulWidget {
  const RegistroEstudianteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de estudiante')),
      //body: const RegistroEstudianteForm(),
    );
  }

  _RegistroEstudianteScreenState createState() =>
      _RegistroEstudianteScreenState();
}

class _RegistroEstudianteScreenState extends State<RegistroEstudianteScreen> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final _formKey_2 = GlobalKey<FormState>();
  String? _nombre;
  String? _apellidopaterno;
  String? _apellidomaterno;
  String? _mail;
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
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Registro de estudiante')),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () async {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              print('Completed');
              await generateAndSavePdf();
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
                        child: Text(isLastStep ? 'Confrim' : 'Next'),
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

Future<void> generateAndSavePdf() async {
  final pdf = pw.Document();

//   final image = pw.MemoryImage(
// (await rootBundle.load('assets/images/Logo.png')).buffer.asUint8List(),
// );

    // Add page to the PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          // Add header to the page
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('$_nombre $_apellidopaterno $_apellidomaterno', style: pw.TextStyle(fontSize: 30)),
                  // pw.Image(image),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text('Contact', style: pw.TextStyle(fontSize: 20)),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 10),
              pw.Text('Email: $_mail', style: pw.TextStyle(fontSize: 15)),
              pw.Text('Phone: $_mail', style: pw.TextStyle(fontSize: 15)),
            ],
          );
        },
      ),
    );
  // Mostrar el diálogo de selección de archivo y obtener la ruta de destino
  final path = await FilePicker.platform.getDirectoryPath();
  
  // Guardar el archivo PDF en la ruta seleccionada por el usuario
  if (path != null) {
    final file = File('$path/mi_archivo.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text('Cuenta'),
            content: Form(
              key: _formKey,
              child: Column(children: <Widget>[
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
                  decoration:
                      const InputDecoration(labelText: 'Apellido Paterno'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu apellido paterno';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _apellidopaterno = value;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Apellido Materno'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu apellido materno';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _apellidomaterno = value;
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
                    _mail = value;
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
                    if (!value.contains(
                        new RegExp(r'(?=.*?[!@#$%^&*(),.?":{}|<>])'))) {
                      return 'La contraseña debe contener al menos un símbolo especial';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                ),
              ]),
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('Cv'),
            content: Form(
              key: _formKey_2,
              child: Column(children: <Widget>[
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
                    'Name: ',
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
                  Text('Last Name: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_apellidopaterno ?? ''),
                      Text(_apellidomaterno ?? ''),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  Text(_mail ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Password: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  Text(_password ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Age: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  Text(_edad?.toString() ?? ''),
                ],
              ),
            ],
          ),
        )
      ];
}
