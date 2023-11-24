import 'champion_card.dart';
import 'package:flutter/material.dart';
import 'champion_model.dart';

class ChampionList extends StatelessWidget {
  final List<Champion> champions;
  const ChampionList(this.champions, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: champions.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return ChampionCard(champions[int]);
      },
    );
  }
}
