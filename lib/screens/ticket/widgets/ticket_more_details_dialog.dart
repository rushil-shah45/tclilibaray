import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/ticket/controller/ticket_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_model.dart';
import 'package:tcllibraryapp_develop/widgets/custom_dialog.dart';

ticketMoreDetailsDialog(BuildContext context, TicketModel ticketModel,
    TicketController ticketController) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.green,
        child: Container(
          height: Get.height / 12,
          width: Get.width / 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(Routes.viewTicket,
                                  arguments: ticketModel.pkNo)!
                              .then((value) {
                            ticketController.getUserTicket();
                          });
                        },
                        child: Image(
                          image: const AssetImage("assets/images/next.png"),
                          height: 40.h,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      GestureDetector(
                        onTap: () {
                          // showGeneralDialog(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   barrierLabel: "",
                          //   transitionBuilder: (context, animation, secondaryAnimation, child) {
                          //     return SlideTransition(
                          //       position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                          //           .animate(
                          //           CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                          //       child: child,
                          //     );
                          //   },
                          //   transitionDuration: const Duration(milliseconds: 400),
                          //   pageBuilder: (context, animation, secondaryAnimation) {
                          //     return Dialog(
                          //           child: SingleChildScrollView(
                          //             child: Container(
                          //               height: Get.height * 0.25,
                          //               width: Get.width,
                          //               decoration: BoxDecoration(
                          //                   color: Colors.white, borderRadius: BorderRadius.circular(16)),
                          //               padding: const EdgeInsets.all(16),
                          //               child: Center(
                          //                   child: Column(
                          //                     // mainAxisAlignment: MainAxisAlignment.end,
                          //                     children: [
                          //                       const SizedBox(
                          //                         height: 10,
                          //                       ),
                          //                       Text('Are you sure?',style: TextStyle(
                          //                         fontSize: 16.sp,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),),
                          //
                          //                       const SizedBox(
                          //                         height: 20,
                          //                       ),
                          //
                          //                       Text('Do you want to delete this item?'),
                          //
                          //                       const SizedBox(
                          //                         height: 5,
                          //                       ),
                          //                       Row(
                          //                         mainAxisAlignment: MainAxisAlignment.end,
                          //                         children: [
                          //                           TextButton(
                          //                               onPressed: () {
                          //                                 Get.back();
                          //                               },
                          //                               child: const Text('No'),
                          //                               style: TextButton.styleFrom(
                          //                                   foregroundColor: const Color(0xFF666972))),
                          //                           TextButton(
                          //                               onPressed: () {},
                          //                               child: const Text('Yes'),
                          //                               style: TextButton.styleFrom(
                          //                                   foregroundColor: const Color(0xFF467EDC))),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   )),
                          //             ),
                          //           ));
                          //   },
                          // );
                          ///
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return Dialog(
                          //       child: Container(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 0, vertical: 16),
                          //         height: Get.height * 0.25,
                          //         width: double.infinity,
                          //         child: Column(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Align(
                          //               alignment: Alignment.center,
                          //               child: Text(
                          //                 "Are you sure?",
                          //                 style: TextStyle(
                          //                     color: Colors.black,
                          //                     fontSize: 16.sp,
                          //                     fontWeight: FontWeight.w600),
                          //               ),
                          //             ),
                          //             const SizedBox(height: 20),
                          //             const Center(
                          //               child: Text(
                          //                 "Do you want to delete this item?",
                          //                 style: TextStyle(
                          //                     color: Colors.black54,
                          //                     fontSize: 14,
                          //                     fontWeight: FontWeight.w400),
                          //               ),
                          //             ),
                          //             const Spacer(),
                          //             Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.end,
                          //               children: [
                          //                 TextButton(
                          //                   style: TextButton.styleFrom(
                          //                       foregroundColor: redColor),
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: const Text("No"),
                          //                 ),
                          //                 TextButton(
                          //                   style: TextButton.styleFrom(
                          //                       foregroundColor: redColor),
                          //                   onPressed: () async {
                          //                     ticketController
                          //                         .deleteUserTicket(ticketModel
                          //                             .pkNo
                          //                             .toString())
                          //                         .then((value) {
                          //                       ticketController.ticketModelList
                          //                           .removeWhere((element) =>
                          //                               element.pkNo ==
                          //                               ticketModel.pkNo);
                          //                       ticketController
                          //                           .getUserTicket();
                          //                       Navigator.pop(context);
                          //                     });
                          //                   },
                          //                   child: const Text("Yes"),
                          //                 ),
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );
                          customDialog(
                              context,
                              'Are you sure?',
                              'Do you want to delete this item?',
                              'Yes',
                              'No', () {
                            ticketController
                                .deleteUserTicket(ticketModel.pkNo.toString())
                                .then((value) {
                              ticketController.ticketModelList.removeWhere(
                                  (element) =>
                                      element.pkNo == ticketModel.pkNo);
                              ticketController.getUserTicket();
                              Navigator.pop(context);
                            });
                          }, () {
                            Navigator.pop(context);
                          });
                        },
                        child: Image(
                          image: const AssetImage("assets/images/bin.png"),
                          height: 40.h,
                        ),
                      ),
                    ],
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
