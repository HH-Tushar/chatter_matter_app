import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';

part 'custom_tile.dart';
part 'components/custom_tile.dart';
part 'components/custom_style.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),

      child: Column(
        spacing: 15,
        children: [
          Column(
            children: [
              Text("Explore", style: heading()),
              Text(
                "Find the perfect conversation",
                style: bodyMedium(color: customDarkGray),
              ),
              vPad10,
            ],
          ),
          // vPad20,
          customTile(CategoryTileType.reflectingOnTheDay),
          customTile(CategoryTileType.fosteringOpenness),
          customTile(CategoryTileType.strengtheningTrust),
          customTile(CategoryTileType.exploringEmotions),
          customTile(CategoryTileType.encouragingGrowth),
          customTile(CategoryTileType.buildingFamilyConnections),
          customTile(CategoryTileType.imaginativeFunQuestions),
          customTile(CategoryTileType.celebratingAccomplishments),
          customTile(CategoryTileType.deepeningUnderstanding),
          customTile(CategoryTileType.selfWorthAndLove),

          vPad35,
          // customTile(CategoryTileType.selfWorthAndLove),
        ],
      ),
    );
  }
}
