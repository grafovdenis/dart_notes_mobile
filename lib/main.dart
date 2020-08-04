import 'package:dart_notes_mobile_v3/src/blocs/auth_bloc.dart';
import 'package:dart_notes_mobile_v3/src/blocs/core_bloc.dart';
import 'package:dart_notes_mobile_v3/src/storage.dart';
import 'package:dart_notes_mobile_v3/src/themes.dart';
import 'package:flutter/material.dart';

import 'src/blocs/bloc_provider.dart';
import 'src/pages/auth_page.dart';
import 'src/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final user = await getUserFromStorage();

  final initialRoute = (user != null) ? '/home' : '/auth';

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key key, this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart notes',
      theme: mainTheme,
      initialRoute: initialRoute,
      routes: {
        '/home': (context) => BlocProvider<CoreBloc>(
              bloc: CoreBloc(),
              child: HomePage(),
            ),
        '/auth': (context) => BlocProvider<AuthBloc>(
              bloc: AuthBloc(),
              child: AuthPage(),
            ),
      },
    );
  }
}
