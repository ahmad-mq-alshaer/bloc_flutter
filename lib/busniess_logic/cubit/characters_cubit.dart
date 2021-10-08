import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/data/models/characters.dart';
import 'package:bloc_flutter/data/models/quote.dart';
import 'package:bloc_flutter/data/repository/characters_repositor.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName){
    charactersRepository.getCharacterQuotes(charName).then((quotes){
      emit(QuotesLoaded(quotes));
    });
  }

}
