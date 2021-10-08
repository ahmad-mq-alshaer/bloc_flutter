import 'package:bloc_flutter/busniess_logic/cubit/characters_cubit.dart';
import 'package:bloc_flutter/constants/strings.dart';
import 'package:bloc_flutter/data/models/characters.dart';
import 'package:bloc_flutter/data/repository/characters_repositor.dart';
import 'package:bloc_flutter/data/web_services/characters_web_services.dart';
import 'package:bloc_flutter/presentation/screens/characters_details.dart';
import 'package:bloc_flutter/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: CharactersScreen(),
                ));

      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: CharactersDetailsScreen(
              character: character,
            ),
          ),
        );
    }
  }
}
