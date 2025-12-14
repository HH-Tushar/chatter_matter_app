part of '../explore_view.dart';

const customLightBlue = Color(0xff95ADF3); //done
const customLightOrange = Color(0xffFFB29C); //done
const customLightTeal = Color(0xff97CCC4); //done
const customLightBrawn = Color(0xffD6A6B4); //done
const customLightLavender = Color(0xffE1B9E6); //done
const customLightOlive = Color(0xffA8B8A0); //done
const customGreyOlive = Color(0xffA0B8C3); //done
const customLightPink = Color(0xffF1A7D7); //done
const customLightYellow = Color(0xffE2D5A3); //done
const customLightPurple = Color(0xffC18DD9); //done

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

///
/// do not change anything here
///
const Map<String, CategoryTileConfig> categoryTileConfigs = {
  "customLightPurple": CategoryTileConfig(
    backgroundColor: customLightPurple,
    backgroundImage: "assets/category/reflection_of_the_day_bg.png",
    foregroundImage: "assets/category/reflection_of_the_day_fg.png",
  ),

  "customLightOrange": CategoryTileConfig(
    backgroundColor: customLightOrange,
    backgroundImage: "assets/category/strengthening_bg.png",
    foregroundImage: "assets/category/strengthening_fg.png",
  ),

  "customLightTeal": CategoryTileConfig(
    backgroundColor: customLightTeal,
    backgroundImage: "assets/category/exploring_bg.png",
    foregroundImage: "assets/category/exploring_fg.png",
  ),

  "customLightBlue": CategoryTileConfig(
    backgroundColor: customLightBlue,
    backgroundImage: "assets/category/fostering_bg.png",
    foregroundImage: "assets/category/fostering_fg.png",
  ),

  "customLightBrawn": CategoryTileConfig(
    backgroundColor: customLightBrawn,
    backgroundImage: "assets/category/encoraging_bg.png",
    foregroundImage: "assets/category/encoraging_fg.png",
  ),

  "customLightLavender": CategoryTileConfig(
    backgroundColor: customLightLavender,
    backgroundImage: "assets/category/encoraging_bg.png",
    foregroundImage: "assets/category/encoraging_fg.png",
  ),

  "customLightPink": CategoryTileConfig(
    backgroundColor: customLightPink,
    backgroundImage: "assets/category/imaginative_bg.png",
    foregroundImage: "assets/category/imaginative_fg.png",
  ),

  "customLightYellow": CategoryTileConfig(
    backgroundColor: customLightYellow,
    backgroundImage: "assets/category/celebrating_bg.png",
    foregroundImage: "assets/category/celebrating_fg.png",
  ),

  "customGreyOlive": CategoryTileConfig(
    backgroundColor: customGreyOlive,
    backgroundImage: "assets/category/celebrating_bg.png",
    foregroundImage: "assets/category/celebrating_fg.png",
  ),

  "customLightOlive": CategoryTileConfig(
    backgroundColor: customLightOlive,
    backgroundImage: "assets/category/self_bg.png",
    foregroundImage: "assets/category/self_fg.png",
  ),
};
