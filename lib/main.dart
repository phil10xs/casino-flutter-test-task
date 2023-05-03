import 'dart:io';

import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await MainDIModule().configure(GetIt.I);
  await HttpServer.bind(InternetAddress.loopbackIPv4, 0);

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPageBloc>(
          create: (BuildContext context) => MainPageBloc(
            GetIt.I<MainPageState>(),
            GetIt.I<CharactersRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Test app',
        home: CharactersScreen(),
        navigatorKey: navKey,
      ),
    );
  }
}
