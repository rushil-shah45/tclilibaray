import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/widgets/custom_white_button.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Subscription",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 700.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 6,
                            offset: const Offset(0, 5))
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Free",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Table(
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Price",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Free",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Offerings",
                                          style: darkSmallBoldTextStyle,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "access two books monthly",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Library Content",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Restricted access to premimum content",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Book Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Renew book access in the next month",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Blog Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Read Only Access",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Forum Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Read Only Access",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Book Club Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Access",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomWhiteButton(
                            callback: () {}, buttonName: "Choose Plan")
                      ],
                    ),
                  );
                },
              ),
            ),
            // child: Container(
            //   height: 600.h,
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: 3,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       // return
            //     },
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}

/*



Container(
                    width: 300.w,
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 6,
                            offset: const Offset(0, 5))
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Free",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Table(
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Price",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Free",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Offerings",
                                          style: darkSmallBoldTextStyle,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "access two books monthly",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Library Content",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Restricted access to premimum content",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Book Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Renew book access in the next month",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Blog Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Read Only Access",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Forum Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Read Only Access",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Book Club Access",
                                        style: darkSmallBoldTextStyle,
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Access",
                                        style: greySmallTextStyle,
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomWhiteButton(
                            callback: () {}, buttonName: "Choose Plan")
                      ],
                    ),
                  );



 */
