import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/apply_promo_code/controller/apply_promo_code_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class ApplyPromoCodeScreen extends StatefulWidget {
  const ApplyPromoCodeScreen({super.key});

  @override
  State<ApplyPromoCodeScreen> createState() => _ApplyPromoCodeScreenState();
}

class _ApplyPromoCodeScreenState extends State<ApplyPromoCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyPromoCodeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "Apply PromoCode",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomRichText(title: 'Apply For ', star: "*"),

                  ///Apply Promo Code
                  Container(
                    height: Get.height / 16.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      List<String> items = controller.applyItems.value;
                      return DropdownButton(
                        borderRadius: BorderRadius.circular(10.r),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        value: controller.applyType.value == ""
                            ? null
                            : controller.applyType.value,
                        isExpanded: true,
                        iconEnabledColor: Colors.grey.shade400,
                        underline: const SizedBox(),
                        hint: const Text("Select one"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          controller.changeSizeItemValue(newValue!);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 10.h),
                  const CustomRichText(title: 'Code ', star: "*"),
                  CustomTextField(
                    controller: controller.codeController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hintText: "Enter your Promo Code",
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomBtn(
                              width: Get.width / 6,
                              text: 'Submit',
                              callback: () {
                                controller.applyPromoCode(context);
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
