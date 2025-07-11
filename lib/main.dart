import 'package:flutter/material.dart';
import 'package:kusuri/repositories/local_medicine_repository.dart';
import 'package:kusuri/services/reminder_service.dart';
import 'package:kusuri/services/scan_service.dart';
import 'package:kusuri/services/suggestion_service.dart';
import 'package:kusuri/utils/theme/kusuri_theme.dart';
import 'package:kusuri/viewmodels/add_medicine_viewmodel.dart';
import 'package:kusuri/viewmodels/medicine_viewmodel.dart';
import 'package:kusuri/views/home_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initNotifications();

  runApp(KusuriApp());
}

class KusuriApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MedicineViewModel(
            repository: LocalMedicineRepository(),
          )..loadMedicines(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddMedicineViewModel(
            scanService: ScanService(),
            suggestionService: SuggestionService()..loadSuggestions(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kusuri',
        theme: KusuriTheme.lightTheme,
        home: HomeScreen(),
      ),
    );
  }
}
