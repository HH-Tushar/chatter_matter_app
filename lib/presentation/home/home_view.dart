import 'package:carousel_slider/carousel_slider.dart';
import 'package:chatter_matter_app/application/user/auth_bloc.dart';
import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:chatter_matter_app/common/see_%20loading.dart';
import 'package:chatter_matter_app/env.dart';
import 'package:chatter_matter_app/presentation/subsription/inAppSubscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../application/adds/add.dart';
import '../../common/custom_question_tile.dart';
import '../../providers/question_provider.dart';
import '../notification/notification_view.dart';
import '../subsription/subscription_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    call();
    super.initState();
  }

  void call() async {
    await myBanner.load();
    // showInterstitial();
  }

  @override
  Widget build(BuildContext context) {
    final QuestionProvider questionProvider = context.watch();
    final UserBloc userBloc = context.watch();
    final favList = userBloc.profile?.favoriteQuestionIds ?? [];
    final profile = userBloc.profile;

    return RefreshIndicator(
      onRefresh: () async => questionProvider.resetPaginator(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning",
                        style: bodyMedium(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Text(
                            profile?.name ?? "",
                            style: titleLarge(color: customBlack),
                          ),
                          Image.asset("assets/icons/hi.png"),
                        ],
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () => animatedNavigateTo(context, NotificationView()),
                  child: Container(
                    height: 40,
                    width: 40,

                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                    child: Icon(Icons.notifications, color: customLightPurple),
                  ),
                ),
              ],
            ),

            vPad20,

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          Image.asset("assets/icons/star.png"),
                          Text("Question of the Day", style: titleSmall()),
                        ],
                      ),
                      Text(
                        "Sunday , November 2,2025",
                        style: bodyMedium(color: customDarkGray),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 35,
                  width: 50,
                  decoration: BoxDecoration(
                    color: customWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: customLightGray),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${questionProvider.questionList.length}",
                        style: bodyLarge(color: customLightPurple),
                      ),
                      Text("/ ${questionProvider.questionList.length}"),
                    ],
                  ),
                ),
              ],
            ),

            vPad20,
            if (profile?.subscriptionType.name != SubscriptionType.vip.name)
              Card(
                color: customWhite,
                elevation: 2,
                child: ListTile(
                  onTap: () => animatedNavigateTo(context, SubscriptionView()),
                  title: Text("Unlock VIP Access"),
                  subtitle: Text("Unlimited que • No ads"),
                  leading: Image.asset("assets/icons/vip.png"),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: customLightPurple,
                    ),
                    child: Text(
                      "Upgrade",
                      style: titleSmall(color: customWhite),
                    ),
                  ),
                ),
              ),

            vPad20,

            SizedBox(
              // height: 400,
              child: questionProvider.isLoading
                  ? SizedBox(height: 350, child: cLoading())
                  : CarouselSlider(
                      items: List.generate(
                        questionProvider.questionList.length,
                        (i) => CustomQuestionTile(
                          index: i,
                          question: questionProvider.questionList[i],
                          isFavorite: favList.contains(
                            questionProvider.questionList[i].id,
                          ),
                          onTapFav: () async => userBloc.addFavQuestion(
                            questionProvider.questionList[i].id,
                          ),
                        ),
                      ),

                      options: CarouselOptions(
                        aspectRatio: 1,
                        height: 350,
                        viewportFraction: 1,
                        enlargeCenterPage: true,

                        onPageChanged: (ind, e) {
                          if (questionProvider.questionList.length - 2 < ind &&
                              profile?.subscriptionType.name ==
                                  SubscriptionType.vip.name) {
                            questionProvider.getQuestion();
                          }
                        },
                      ),
                    ),
            ),

            vPad20,
            profile?.subscriptionType.name != SubscriptionType.vip.name
                ? Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      color: customLightYellow,
                      border: Border.all(color: Colors.yellow),
                    ),

                    child: Row(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.error_outline, color: customBrawn),
                        Expanded(
                          child: Text(
                            "You've reached your daily limit. Upgrade to continue !",
                            style: bodyMedium(color: customBrawn),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      color: customLightYellow,
                      border: Border.all(color: customGreen),
                    ),

                    child: Center(
                      child: Text(
                        "You're enjoying the VIP status",
                        style: bodyMedium(color: customGreen),
                      ),
                    ),
                  ),

            vPad20,
            if (profile?.subscriptionType.name == SubscriptionType.free.name)
              Container(
                alignment: Alignment.center,
                width: myBanner.size.width.toDouble(),
                height: myBanner.size.height.toDouble(),
                child: AdWidget(ad: myBanner),
              ),

            vPad35,

            ElevatedButton(
              onPressed: () {
                // Navigate to the new Subscription Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InappSubscription(), // Your new IAP subscription page
                  ),
                );
              },
              child: Text("In-App Purchase"),
            ),
            vPad35,
          ],
        ),
      ),
    );
  }

  Future fetchOffer() async {
    final offering = await PurchaseApi.fetchOffers();
    if (offering.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No plan Found ')));
    } else {
      final offer = offering
          .map((e) => e.availablePackages)
          .expand((pair) => pair)
          .toList();

      Utils.showSheet(
        context,
        (e) => PaywallWidget(
          packages: offer,
          title: 'Upgrade your plan ',
          description: 'Upgrade with a package with you choice ',
          onClickedPackage: (package) async {
            await PurchaseApi.purchasePackage(package);
            Navigator.pop(context);
          },
        ),
      );
    }
  }
}

class PurchaseApi {
  static const _apikey = 'goog_XZDWpspqpPpWwGewqzCGEEblRzh';

  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apikey);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offering = await Purchases.getOfferings();
      print('........... The offer is this >>>>>>>>>>>>> $offering');
      // final current = offering.current;
      // return current == null ? [] : [current];
      final allOfferings = offering.all.values.toList();
      return allOfferings;
    } on PlatformException catch (e) {
      print('!!!!!!!!! Error fetching offers $e');
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }
}

// utill...
class Utils {
  static Future<void> showSheet(
    BuildContext context,
    Widget Function(BuildContext) builder,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: builder(context),
            );
          },
        );
      },
    );
  }
}

// pay wall
class PaywallWidget extends StatelessWidget {
  final List<Package> packages;
  final String title;
  final String description;
  final Function(Package) onClickedPackage;

  const PaywallWidget({
    super.key,
    required this.packages,
    required this.title,
    required this.description,
    required this.onClickedPackage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Drag Handle
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          SizedBox(height: 16),

          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 8),

          Text(description, textAlign: TextAlign.center),

          SizedBox(height: 20),

          /// Packages List
          Expanded(
            child: ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                final product = package.storeProduct;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(product.title),
                    subtitle: Text(product.description),
                    trailing: Text(product.priceString),
                    onTap: () => onClickedPackage(package),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// my part ..
