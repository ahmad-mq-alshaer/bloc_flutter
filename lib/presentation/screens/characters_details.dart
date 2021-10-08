import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../busniess_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      thickness: 2,
      endIndent: endIndent,
      color: MyColors.myYellow,
    );
  }

  Widget characterIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuotesOrEmptySpace(state);
    } else {
      return showPrograseIndicator();
    }
  }

  Widget displayRandomQuotesOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: MyColors.myWhite, shadows: [
            Shadow(
                blurRadius: 7, color: MyColors.myYellow, offset: Offset(0, 0)),
          ]),
          child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [FlickerAnimatedText(quotes[randomQuoteIndex].quote)]),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showPrograseIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //استخدمنا join عشان جاي ليست سترينج فهاي الدالة بتفصل بينهم وبتعرض في نفس السطر
                      characterInfo('Jobs: ', character.jobs.join(' / ')),
                      buildDivider(315),
                      characterInfo(
                          'Appeared in: ', character.categoryOfTowSeries),
                      buildDivider(250),
                      characterInfo('Seasons: ',
                          character.appearanceOfSeasons.join(' / ')),
                      buildDivider(280),
                      characterInfo('Status: ', character.statusIfDeadOrAlive),
                      buildDivider(300),
                      character.betterCallSaulappearance.isEmpty
                          ? Container()
                          : characterInfo('Better Call Sual Seasons: ',
                              character.appearanceOfSeasons.join(' / ')),
                      character.betterCallSaulappearance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo('Actor / Actores: ', character.actorName),
                      buildDivider(235),
                      SizedBox(height: 20),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                        return characterIfQuotesAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
