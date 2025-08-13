import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/controller/all_book_for_sale_screen_controller.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/controller/my_subscription_controller.dart';
import 'package:tcllibraryapp_develop/screens/payment/controller/payment_controller.dart';

class CustomCountryBottomSheet extends StatelessWidget {
  const CustomCountryBottomSheet({super.key, required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            Center(
              child: Text(
                'Country',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: controller.countryModel.value.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = controller.countryModel.value[index];
                            final isSelected = controller
                                    .billingSelectedCountryController.text ==
                                item.name;

                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: SizedBox(
                                height: Get.height / 15,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    backgroundColor: isSelected
                                        ? primaryColor
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    controller.change(item.name);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CustomCountryBottomSheetForBookPayment extends StatelessWidget {
  const CustomCountryBottomSheetForBookPayment({super.key, required this.controller});

  final AllBookForSaleScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            Center(
              child: Text(
                'Country',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                () => controller.isLoadingCountry.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: controller.countryModel.value.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = controller.countryModel.value[index];
                            final isSelected = controller
                                    .billingSelectedCountryController.text ==
                                item.name;

                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: SizedBox(
                                height: Get.height / 15,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    backgroundColor: isSelected
                                        ? primaryColor
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    controller.changeCountry(item.name);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
