import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:tcllibraryapp_develop/screens/pricing/controller/pricing_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppPurchaseScreen extends StatelessWidget {
  const InAppPurchaseScreen({super.key, required this.package, required this.id});

  final Package package;
  final String id;

  @override
  Widget build(BuildContext context) {
    PricingController controller = Get.find();
    print(package);
    print(id);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Plan Details",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Upgrade Plan", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
              Text(package.storeProduct.title),
              const SizedBox(height: 10),
              Obx(() => controller.isBuying.value
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () async {
                        await controller.purchasePackage(package, id);
                        // controller.makeInAppPurchase(
                        //     '2',
                        //     '2',
                        //     '\$RCAnonymousID:8fdff85af70442bbbaf0a855e755d752',
                        //     '\$RCAnonymousID:8fdff85af70442bbbaf0a855e755d752',
                        //     'N500');
                      },
                      child: Container(
                        height: 45,
                        width: Get.width / 2,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          'Purchase Plan',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )),
              Text(
                '${package.storeProduct.priceString}/${package.identifier.contains('monthly') ? 'month' : 'year'}',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Uri privacy = Uri.parse('https://tclilibrary.com/privacy-policy');
                      launchUrl(privacy, mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade700)),
                      child: Text('Privacy Policy', style: TextStyle(color: Colors.grey.shade700)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Uri terms = Uri.parse('https://tclilibrary.com/terms-condition');
                      launchUrl(terms, mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade700)),
                      child: Text('Terms & Conditions', style: TextStyle(color: Colors.grey.shade700)),
                    ),
                  ),
                ],
              ),
              Divider(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: const Text(
                    'Payment will be charged to your iTunes account at confirmation of purchase. Subscriptions will automatically renew unless auto-renew is turned off at least 24 hours before the end of current period. Your account will be charged according to your plan for renewal within 24 hours prior to the end of the current period. You can mange or turn off auto-renew in your Apple ID account settings at any time purchase.',
                    style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
