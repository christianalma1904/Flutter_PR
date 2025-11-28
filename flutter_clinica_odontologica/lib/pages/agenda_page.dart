import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final List<TextEditingController> _dayControllers = List.generate(5, (_) => TextEditingController());
  final List<String> _days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];
  String _resultText = '';

  void _calculateSummary() {
    int total = 0;
    int daysWithData = 0;

    for (var controller in _dayControllers) {
      if (controller.text.isNotEmpty) {
        total += int.tryParse(controller.text) ?? 0;
        daysWithData++;
      }
    }

    double average = daysWithData > 0 ? total / daysWithData : 0;

    setState(() {
      _resultText = 'Total de citas: $total\nPromedio diario: ${average.toStringAsFixed(1)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda Semanal'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Ingrese cantidad de citas por día:'),
              const SizedBox(height: 10),
              ...List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextField(
                    controller: _dayControllers[index],
                    decoration: InputDecoration(
                      labelText: _days[index],
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateSummary,
                child: const Text('Calcular Resumen Semanal'),
              ),
              const SizedBox(height: 20),
              Text(
                _resultText,
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
