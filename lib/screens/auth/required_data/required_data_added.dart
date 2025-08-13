import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/auth/required_data/controller/required_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class RequiredDataScreen extends StatelessWidget {
  const RequiredDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RequiredController requiredController = Get.find();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Please complete your information",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomRichText(title: "First Name"),
                        CustomTextField(
                          controller: requiredController.firstNameCtrl,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          hintText: "Enter your first name",
                        ),
                        SizedBox(height: 5.h),
                        const CustomRichText(title: "Last Name"),
                        CustomTextField(
                          controller: requiredController.lastNameCtrl,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          hintText: "Enter your last name",
                        ),
                        SizedBox(height: 5.h),
                        const CustomRichText(title: "Email"),
                        CustomTextField(
                          controller: requiredController.emailAddressCtrl,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          hintText: "Enter your email",
                        ),
                        SizedBox(height: 5.h),
                        const CustomRichText(title: "Phone Number"),
                        SizedBox(
                          height: Get.height / 17,
                          width: Get.width,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    onSelect: (Country country) {
                                      requiredController.dialCode.value =
                                          country.phoneCode;
                                      requiredController.flagIcon.value =
                                          country.flagEmoji;
                                      requiredController.countryCode.value =
                                          country.countryCode;
                                      requiredController.countryName.value =
                                          country.name;
                                    },
                                    countryListTheme: CountryListThemeData(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        topRight: Radius.circular(20.r),
                                      ),

                                      /// if you increase the number of country
                                      /// try to increase the height
                                      /// though it's not mandatory
                                      bottomSheetHeight: Get.height * 0.6,
                                      backgroundColor: Colors.white,
                                      inputDecoration: InputDecoration(
                                        hintText: 'Search',
                                        fillColor: Colors.white,
                                        filled: true,
                                        prefixIcon: const Icon(Icons.search),
                                        contentPadding:
                                            EdgeInsets.only(top: 35.h),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      searchTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: Get.height / 17,
                                  width: Get.width / 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      bottomLeft: Radius.circular(10.r),
                                    ),
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => Text(
                                          requiredController.flagIcon.value,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Obx(
                                        () => Text(
                                          '+${requiredController.dialCode.value}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: Get.width / 5.1,
                                child: SizedBox(
                                  height: Get.height / 17,
                                  width: Get.width - (Get.width / 3.40),
                                  child: TextField(
                                    controller:
                                        requiredController.phoneNumberCtrl,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: "Enter your phone number",
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                          top: 27.h, left: 10.w, right: 10.w),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r),
                                        ),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Obx(
                          () => requiredController.isUpdatingProfile.value
                              ? const Center(child: CircularProgressIndicator())
                              : Center(
                                  child: CustomBtn(
                                    width: Get.width / 6,
                                    text: 'Save',
                                    callback: () {
                                      requiredController.updateProfile();
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
