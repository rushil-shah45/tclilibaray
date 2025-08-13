import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/ticket_card.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/ticket_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/ticket/controller/ticket_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';

class TicketScreen extends GetView<TicketController> {
   TicketScreen({super.key,this.isMain = false});
   bool? isMain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Tickets",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: isMain == false ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)) : const SizedBox(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.getUserTicket();
        },
        child: Obx(
          () => controller.isLoading.value
              ? CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                      SliverPadding(
                          padding: EdgeInsets.only(top: 0.h),
                          sliver:
                              const SliverToBoxAdapter(child: TicketShimmer()))
                    ])
              : CustomScrollView(
                  slivers: [
                    ///Latest borrowed
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All Tickets",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            CustomBtn(
                              width: controller.isTablet
                                  ? Get.width / 3.5
                                  : Get.width / 2.7,
                              text: 'Create New Ticket',
                              callback: () {
                                Get.toNamed(Routes.addTicket);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller.ticketModelList.isEmpty == true
                        ? SliverPadding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            sliver: SliverToBoxAdapter(
                              child: Container(),
                            ),
                          )
                        : SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade100),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Subject", textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: controller.isTablet
                                                ? 11.sp
                                                : 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Priority", textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: controller.isTablet
                                                ? 11.sp
                                                : 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Status", textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: controller.isTablet
                                                ? 11.sp
                                                : 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Action", textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: controller.isTablet
                                                ? 11.sp
                                                : 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    controller.ticketModelList.isEmpty == true
                        ? SliverPadding(
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 150.h),
                            sliver: const SliverToBoxAdapter(
                              child: Center(
                                child: CustomGifImage(),
                              ),
                            ),
                          )
                        : SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: controller.ticketModelList.length,
                                (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade100),
                                    ),
                                    child: TicketCard(
                                      ticketModel:
                                          controller.ticketModelList[index],
                                      ticketController: controller,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    SliverToBoxAdapter(child: SizedBox(height: 30.h))
                  ],
                ),
        ),
      ),
    );
  }
}
