import 'package:flutter/material.dart';
import 'package:kusuri/repositories/local_medicine_repository.dart';
import 'package:kusuri/services/scan_service.dart';
import 'package:kusuri/viewmodels/add_medicine_viewmodel.dart';
import 'package:kusuri/viewmodels/medicine_viewmodel.dart';
import 'package:provider/provider.dart';
import 'views/home_screen.dart';

void main() {
  runApp(KusuriApp());
}

class KusuriApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MedicineViewModel(repository: LocalMedicineRepository())..loadMedicines(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddMedicineViewModel(scanService: ScanService()),
        ),
      ],
      child: MaterialApp(
        title: 'Kusuri',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: HomeScreen(),
      ),
    );
  }
}
