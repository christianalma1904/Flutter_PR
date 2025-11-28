import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  String? _selectedTreatment;

  final List<String> _treatments = ['Limpieza', 'Ortodoncia', 'Endodoncia', 'Estética'];

  void _register() {
    if (_formKey.currentState!.validate() && _selectedTreatment != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paciente ${_nameController.text} registrado con éxito!')),
      );
    } else {
       if (_selectedTreatment == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor seleccione un tratamiento.')),
          );
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Paciente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Imagen / Icono
                const Icon(Icons.account_circle, size: 100, color: Colors.blue),
                const SizedBox(height: 20),
                
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre Completo'),
                  validator: (value) => value == null || value.isEmpty ? 'Ingrese el nombre' : null,
                ),
                const SizedBox(height: 10),
                
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'Documento / Cédula'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Ingrese el documento' : null,
                ),
                const SizedBox(height: 10),
                
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Tipo de Tratamiento'),
                  value: _selectedTreatment,
                  items: _treatments.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (value) => setState(() => _selectedTreatment = value),
                  validator: (value) => value == null ? 'Seleccione un tratamiento' : null,
                ),
                const SizedBox(height: 30),
                
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
