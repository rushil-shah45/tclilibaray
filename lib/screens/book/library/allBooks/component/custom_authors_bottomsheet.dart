import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/controller/all_book_for_sale_screen_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/controller/all_books_controller.dart';

class CustomAuthorsBottomSheet extends StatelessWidget {
  const CustomAuthorsBottomSheet({super.key, required this.controller});

  final AllBooksController controller;

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
                'Author',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                    () => SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: controller.authorModel.value.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final value = controller.authorModel.value..sort((a, b) => a.name.compareTo(b.name));
                      final item = value[index];
                      final isSelected =
                          controller.selectAuthorController.text ==
                              '${item.name} ${item.lastName}';
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SizedBox(
                          height: Get.height / 15,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor:
                              isSelected ? primaryColor : Colors.white,
                            ),
                            onPressed: () {
                              if ('${item.name} ${item.lastName}' ==
                                  'Select Author') {
                                controller.change2('', 0);
                              } else {
                                controller.change2(
                                    '${item.name} ${item.lastName}', item.id);
                              }
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${item.name} ${item.lastName}',
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



class CustomAuthorsBottomSheetForBookSale extends StatelessWidget {
  const CustomAuthorsBottomSheetForBookSale({super.key, required this.controller});

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
                'Author',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                    () => SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: controller.authorModel.value.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final value = controller.authorModel.value..sort((a, b) => a.name.compareTo(b.name));
                      final item = value[index];
                      final isSelected = controller.selectAuthorController.text == '${item.name} ${item.lastName}';
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SizedBox(
                          height: Get.height / 15,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor:
                              isSelected ? primaryColor : Colors.white,
                            ),
                            onPressed: () {
                              if ('${item.name} ${item.lastName}' ==
                                  'Select Author') {
                                controller.change2('', 0);
                              } else {
                                controller.change2(
                                    '${item.name} ${item.lastName}', item.id);
                              }
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${item.name} ${item.lastName}',
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
