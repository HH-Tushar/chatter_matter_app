part of '../explore_view.dart';

enum CategoryTileType {
  reflectingOnTheDay,
  strengtheningTrust,
  exploringEmotions,
  fosteringOpenness,
  encouragingGrowth,
  buildingFamilyConnections,
  imaginativeFunQuestions,
  celebratingAccomplishments,
  deepeningUnderstanding,
  selfWorthAndLove,
}

class CategoryTileConfig {
  final Color backgroundColor;
  final String backgroundImage;
  final String foregroundImage;

  const CategoryTileConfig({
    required this.backgroundColor,
    required this.backgroundImage,
    required this.foregroundImage,
  });
}

const Map<CategoryTileType, CategoryTileConfig> categoryTileConfigs = {
  CategoryTileType.reflectingOnTheDay: CategoryTileConfig(
    backgroundColor: Color(0xffC18DD9),
    backgroundImage: "assets/category/reflection_of_the_day_bg.png",
    foregroundImage: "assets/category/reflection_of_the_day_fg.png",
  ),

  CategoryTileType.strengtheningTrust: CategoryTileConfig(
    backgroundColor: Color(0xffF6AA93),
    backgroundImage: "assets/category/strengthening_bg.png",
    foregroundImage: "assets/category/strengthening_fg.png",
  ),

  CategoryTileType.exploringEmotions: CategoryTileConfig(
    backgroundColor: Color(0xff97CCC4),
    backgroundImage: "assets/category/exploring_bg.png",
    foregroundImage: "assets/category/exploring_fg.png",
  ),

  CategoryTileType.fosteringOpenness: CategoryTileConfig(
    backgroundColor: Color(0xff95ADF3),
    backgroundImage: "assets/category/fostering_bg.png",
    foregroundImage: "assets/category/fostering_fg.png",
  ),

  CategoryTileType.encouragingGrowth: CategoryTileConfig(
    backgroundColor: Color(0xffD6A6B4),
    backgroundImage: "assets/category/encoraging_bg.png",
    foregroundImage: "assets/category/encoraging_fg.png",
  ),

  CategoryTileType.buildingFamilyConnections: CategoryTileConfig(
    backgroundColor: Color(0xffE1B9E6),
    backgroundImage: "assets/category/encoraging_bg.png",
    foregroundImage: "assets/category/encoraging_fg.png",
  ),

  CategoryTileType.imaginativeFunQuestions: CategoryTileConfig(
    backgroundColor: Color(0xffF1A7D7),
    backgroundImage: "assets/category/imaginative_bg.png",
    foregroundImage: "assets/category/imaginative_fg.png",
  ),

  CategoryTileType.celebratingAccomplishments: CategoryTileConfig(
    backgroundColor: Color(0xffE2D5A3),
    backgroundImage: "assets/category/celebrating_bg.png",
    foregroundImage: "assets/category/celebrating_fg.png",
  ),

  CategoryTileType.deepeningUnderstanding: CategoryTileConfig(
    backgroundColor: Color(0xffA0B8C3),
    backgroundImage: "assets/category/celebrating_bg.png",
    foregroundImage: "assets/category/celebrating_fg.png",
  ),

  CategoryTileType.selfWorthAndLove: CategoryTileConfig(
    backgroundColor: Color(0xffB4C8B0),
    backgroundImage: "assets/category/self_bg.png",
    foregroundImage: "assets/category/self_fg.png",
  ),
};
