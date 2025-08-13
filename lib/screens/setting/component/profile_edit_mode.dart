import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/setting/component/profile_image.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with SingleTickerProviderStateMixin {
  SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            }),
        title: Text("Edit Profile",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return settingsController.getUserProfile();
        },
        child: Obx(
          () => settingsController.isLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: Get.height / 6.5,
                          width: Get.height / 6.5,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade300,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 40.h,
                        width: 100.w,
                        child: container(),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 60.h,
                        width: Get.width.w,
                        child: container(),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        height: 40.h,
                        width: 100.w,
                        child: container(),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 60.h,
                        width: Get.width.w,
                        child: container(),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 40.h,
                        width: 100.w,
                        child: container(),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 60.h,
                        width: Get.width.w,
                        child: container(),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    ///Profile Section
                    SliverPadding(
                      padding: settingsController.isTablet
                          ? EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h)
                          : EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: settingsController.isTablet
                              ? const EdgeInsets.all(15)
                              : const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            children: [
                              ProfileImage(
                                settingsController: settingsController,
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomRichText(title: "First Name"),
                                    CustomTextField(
                                      controller:
                                          settingsController.firstNameCtrl,
                                      textInputType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      hintText: "Enter your first name",
                                    ),
                                    SizedBox(height: 5.h),
                                    const CustomRichText(title: "Last Name"),
                                    CustomTextField(
                                      controller:
                                          settingsController.lastNameCtrl,
                                      textInputType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      hintText: "Enter your last name",
                                    ),
                                    SizedBox(height: 5.h),
                                    const CustomRichText(title: "Email"),
                                    CustomTextField(
                                      controller:
                                          settingsController.emailAddressCtrl,
                                      textInputType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      hintText: "Enter your email",
                                    ),
                                    Visibility(
                                      visible: settingsController
                                              .userProfileModel?.roleId !=
                                          "3",
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.h),
                                          const CustomRichText(
                                              title: "Phone Number"),
                                          SizedBox(
                                            height: settingsController.isTablet
                                                ? Get.height / 19
                                                : Get.height / 17,
                                            width: Get.width,
                                            child: Stack(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showCountryPicker(
                                                      context: context,
                                                      showPhoneCode: true,
                                                      onSelect:
                                                          (Country country) {
                                                        settingsController
                                                                .dialCode
                                                                .value =
                                                            country.phoneCode;
                                                        settingsController
                                                                .flagIcon
                                                                .value =
                                                            country.flagEmoji;
                                                        settingsController
                                                                .countryCode
                                                                .value =
                                                            country.countryCode;
                                                        settingsController
                                                                .countryName
                                                                .value =
                                                            country.name;
                                                      },
                                                      countryListTheme:
                                                          CountryListThemeData(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.r),
                                                        ),

                                                        /// if you increase the number of country
                                                        /// try to increase the height
                                                        /// though it's not mandatory
                                                        bottomSheetHeight:
                                                            Get.height * 0.6,
                                                        backgroundColor:
                                                            Colors.white,
                                                        inputDecoration:
                                                            InputDecoration(
                                                          hintText: 'Search',
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.search),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 27.h,
                                                                  left: 10.w,
                                                                  right: 10.w),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  primaryColor,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        searchTextStyle:
                                                            TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: settingsController
                                                            .isTablet
                                                        ? Get.height / 19
                                                        : Get.height / 17,
                                                    width: Get.width / 5,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.r),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.r),
                                                      ),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade400),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Obx(
                                                          () => Text(
                                                            settingsController
                                                                .flagIcon.value,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                settingsController
                                                                        .isTablet
                                                                    ? 7.w
                                                                    : 2.w),
                                                        Obx(
                                                          () => Text(
                                                            '+${settingsController.dialCode.value}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  settingsController
                                                                          .isTablet
                                                                      ? 8.sp
                                                                      : 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                                    width: settingsController
                                                            .isTablet
                                                        ? Get.width -
                                                            (Get.width / 3.4)
                                                        : Get.width -
                                                            (Get.width / 2.90),
                                                    child: TextField(
                                                      controller:
                                                          settingsController
                                                              .phoneNumberCtrl,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Enter your phone number",
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 27.h,
                                                                left: 10.w,
                                                                right: 10.w),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10.r),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.r),
                                                          ),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade400),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10.r),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.r),
                                                          ),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade400),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10.r),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.r),
                                                          ),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade400),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    settingsController.isUpdatingProfile.value
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Center(
                                            child: CustomBtn(
                                              width: Get.width / 6,
                                              text: 'Save',
                                              callback: () {
                                                settingsController
                                                    .updateProfile(context);
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Shimmer container() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade300,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  void customBottomSheet(context, Widget widget) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return widget;
      },
    );
  }
}
