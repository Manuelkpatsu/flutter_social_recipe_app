import 'package:flutter/material.dart';
import 'package:fluttersocialrecipeapp/navigation/app_router.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'models/app_state_manager.dart';
import 'models/profile_manager.dart';
import 'models/grocery_manager.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  State<Fooderlich> createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final _appStateManager = AppStateManager();
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Fooderlich',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => _groceryManager),
          ChangeNotifierProvider(create: (context) => _profileManager),
          ChangeNotifierProvider(create: (context) => _appStateManager),
        ],
        child: Consumer<ProfileManager>(
          builder: (context, profileManager, child) {
            ThemeData theme;
            if (profileManager.darkMode) {
              theme = FooderlichTheme.dark();
            } else {
              theme = FooderlichTheme.light();
            }

            return MaterialApp(
              theme: theme,
              title: 'Fooderlich',
              home: Router(
                routerDelegate: _appRouter,
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
            );
          },
        ),
      ),
    );
  }
}
