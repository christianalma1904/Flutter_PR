import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreatmentItem {
  final String patient;
  final String treatment;
  final double cost;

  TreatmentItem(this.patient, this.treatment, this.cost);
}

class TreatmentsListScreen extends StatefulWidget {
  const TreatmentsListScreen({super.key});

  @override
  State<TreatmentsListScreen> createState() => _TreatmentsListScreenState();
}

class _TreatmentsListScreenState extends State<TreatmentsListScreen> {
  final List<TreatmentItem> _treatmentsList = [];
  
  final _patientCtrl = TextEditingController();
  final _treatmentCtrl = TextEditingController();
  final _costCtrl = TextEditingController();

  String _billingResult = '';

  void _addTreatment() {
    if (_patientCtrl.text.isNotEmpty && _costCtrl.text.isNotEmpty) {
      setState(() {
        _treatmentsList.add(TreatmentItem(
          _patientCtrl.text, 
          _treatmentCtrl.text, 
          double.tryParse(_costCtrl.text) ?? 0.0
        ));
        // Limpiar campos
        _patientCtrl.clear();
        _treatmentCtrl.clear();
        _costCtrl.clear();
      });
    }
  }

  void _calculateBilling() {
    double total = 0;
    // Ciclo para recorrer la lista
    for (var item in _treatmentsList) {
      total += item.cost;
    }
    
    double average = _treatmentsList.isNotEmpty ? total / _treatmentsList.length : 0;

    setState(() {
      _billingResult = 'Total facturado: \$${total.toStringAsFixed(2)}\n'
          'Promedio por tratamiento: \$${average.toStringAsFixed(2)}\n'
          'Tratamientos registrados: ${_treatmentsList.length}';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tratamientos del Día'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(controller: _patientCtrl, decoration: const InputDecoration(labelText: 'Paciente')),
                    TextField(controller: _treatmentCtrl, decoration: const InputDecoration(labelText: 'Tratamiento')),
                    TextField(controller: _costCtrl, decoration: const InputDecoration(labelText: 'Costo'), keyboardType: TextInputType.number),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: _addTreatment, child: const Text('Agregar Tratamiento')),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _treatmentsList.length,
              itemBuilder: (context, index) {
                final item = _treatmentsList[index];
                return ListTile(
                  leading: const Icon(Icons.medical_services),
                  title: Text(item.patient),
                  subtitle: Text('${item.treatment} - \$${item.cost.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _treatmentsList.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          ElevatedButton(onPressed: _calculateBilling, child: const Text('Calcular Facturación')),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _billingResult, 
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
