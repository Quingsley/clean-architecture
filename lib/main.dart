import 'package:clean_architecture/features/advice/presentation/pages/advice_page.dart';
import 'package:clean_architecture/services/theme_service.dart';
import 'package:clean_architecture/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'injection.dart' as di;

Future<void> main() async {
  /// Initialize the plugin.
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDarkModeOn = ref.watch(themeService);
    return MaterialApp(
      themeMode: isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AdvicePageWrapperProvider(),
    );
  }
}
