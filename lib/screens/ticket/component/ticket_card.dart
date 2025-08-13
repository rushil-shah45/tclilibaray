import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/ticket/controller/ticket_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_model.dart';

class TicketCard extends StatelessWidget {
  const TicketCard(
      {super.key, required this.ticketModel, required this.ticketController});

  final TicketModel ticketModel;
  final TicketController ticketController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: Get.width / 4,
              child: Text(
                ticketModel.subject,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
             // width: Get.width / 6.7,
              child: Text(
                ticketModel.priority == 3
                    ? "High"
                    : ticketModel.priority == 2
                        ? "Medium"
                        : "Low",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
               // width: ticketController.isTablet ? Get.width / 4.9 : Get.width / 4.7,
               //  padding: EdgeInsets.symmetric(horizontal: 8.w),
               //  decoration: BoxDecoration(
               //    color: ticketModel.status == 1
               //        ? blackGrayColor
               //        : ticketModel.status == 3
               //            ? const Color(0xFF18A2B8)
               //            : const Color(0xFF28A745),
               //    borderRadius: BorderRadius.circular(10),
               //  ),
                child: Text(
                  ticketModel.status == 1
                      ? "Open"
                      : ticketModel.status == 3
                          ? "Replied"
                          :ticketModel.status == 0
                      ? "Closed": "Answered",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    color:ticketModel.status == 1 ?  blackGrayColor : ticketModel.status == 3 ? const Color(0xFF18A2B8) : ticketModel.status == 0 ? Colors.red : const Color(0xFF28A745),
                    fontSize: ticketController.isTablet ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
            //  width: Get.width / 9,
              child: PopupMenuButton(
                onSelected: (value) {
                  ticketController.onMenuItemSelected(
                      value as int, ticketModel.pkNo, context);
                },
                offset: Offset(Get.width / 10, Get.height / 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                ),
                itemBuilder: (ctx) => [
                  _buildPopupMenuItem('View', Options.view.index),
                  _buildPopupMenuItem('Delete', Options.delete.index),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
