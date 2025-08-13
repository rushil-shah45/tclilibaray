import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/book/author/book_update/controller/update_book_controller.dart';

class UpdateBookCategoryBottomSheet extends GetView<UpdateBookController> {
  const UpdateBookCategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width.w,
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
                "Category",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: Get.width.w,
                        child: ListView.builder(
                          itemCount: controller.categoryList.value.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = controller.categoryList.value[index];
                            final isSelected =
                                controller.selectedCategoryOption.text ==
                                    item.name;
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: SizedBox(
                                height: Get.height / 15,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shadowColor: Colors.grey,
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
                                    controller.changeCategory(
                                        item.name, item.id);
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
