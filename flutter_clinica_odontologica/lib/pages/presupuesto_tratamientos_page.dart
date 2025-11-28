import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  String? _selectedTreatment;
  final _sessionsController = TextEditingController();
  String _resultText = '';

  // Tabla de precios ficticia
  final Map<String, double> _prices = {
    'Limpieza': 20.0,
    'Caries': 35.0,
    'Ortodoncia': 50.0,
    'Blanqueamiento': 40.0,
  };

  void _calculateBudget() {
    if (_selectedTreatment != null && _sessionsController.text.isNotEmpty) {
      final int sessions = int.tryParse(_sessionsController.text) ?? 0;
      final double price = _prices[_selectedTreatment] ?? 0;
      final double total = price * sessions;

      setState(() {
        _resultText = 'Tratamiento: $_selectedTreatment\n'
            'Costo por sesión: \$${price.toStringAsFixed(2)}\n'
            'Sesiones: $sessions\n'
            'TOTAL ESTIMADO: \$${total.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuesto de Tratamientos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Seleccione tratamiento'),
              value: _selectedTreatment,
              items: _prices.keys.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (value) => setState(() => _selectedTreatment = value),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sessionsController,
              decoration: const InputDecoration(labelText: 'Cantidad de sesiones'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBudget,
              child: const Text('Calcular Presupuesto'),
            ),
            const SizedBox(height: 30),
            Text(
              _resultText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}