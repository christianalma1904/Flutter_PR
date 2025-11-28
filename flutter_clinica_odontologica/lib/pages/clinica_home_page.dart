import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clínica Odontológica')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido al sistema de gestión',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.go('/registro'),
              child: const Text('Registro de Paciente'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/tratamiento'),
              child: const Text('Presupuesto de Tratamiento'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/agenda'),
              child: const Text('Agenda de la Semana'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/presupuesto'),
              child: const Text('Lista de Tratamientos del Día'),
            ),
          ],
        ),
      ),
    );
  }
}