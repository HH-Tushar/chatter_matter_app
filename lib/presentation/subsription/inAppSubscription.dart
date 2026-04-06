import 'package:chatter_matter_app/presentation/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InappSubscription extends StatefulWidget {
  const InappSubscription({super.key});

  @override
  State<InappSubscription> createState() => _InappSubscriptionState();
}

class _InappSubscriptionState extends State<InappSubscription> {
  List<Package> packages = [];
  bool isLoading = true;
  Package? selectedPackage;

  @override
  void initState() {
    super.initState();
    loadPackages();
  }

  Future<void> loadPackages() async {
    final offering = await PurchaseApi.fetchOffers();

    if (offering.isNotEmpty) {
      final allPackages = offering
          .map((e) => e.availablePackages)
          .expand((e) => e)
          .toList();

      setState(() {
        packages = allPackages;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> purchase() async {
    if (selectedPackage == null) return;

    final success = await PurchaseApi.purchasePackage(selectedPackage!);

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Purchase Successful ✅")));

      /// 👉 HERE: unlock feature (very important)
      await checkSubscriptionStatus();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Purchase Failed ❌")));
    }
  }

  Future<void> checkSubscriptionStatus() async {
    final info = await Purchases.getCustomerInfo();

    if (info.entitlements.active.isNotEmpty) {
      /// 🔥 USER IS SUBSCRIBED
      print("User subscribed");

      // 👉 Update your app state here
      // Example:
      // userBloc.updateSubscription("premium");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Plan')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : packages.isEmpty
          ? Center(child: Text("No plans found"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: packages.length,
                    itemBuilder: (context, index) {
                      final package = packages[index];
                      final product = package.storeProduct;

                      final isSelected = selectedPackage == package;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPackage = package;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(product.description),
                              SizedBox(height: 10),
                              Text(
                                product.priceString,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// PURCHASE BUTTON
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: selectedPackage == null ? null : purchase,
                      child: Text("Purchase"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
