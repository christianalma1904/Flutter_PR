import 'package:go_router/go_router.dart';

import 'pages/clinica_home_page.dart';
import 'pages/registro_paciente_page.dart';
import 'pages/presupuesto_tratamientos_page.dart';
import 'pages/agenda_page.dart';
import 'pages/tratamiento_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/tratamiento',
      builder: (context, state) => const BudgetScreen(),
    ),
    GoRoute(
      path: '/agenda',
      builder: (context, state) => const AgendaScreen(),
    ),
    GoRoute(
      path: '/presupuesto',
      builder: (context, state) => const TreatmentsListScreen(),
    ),
  ],
);

