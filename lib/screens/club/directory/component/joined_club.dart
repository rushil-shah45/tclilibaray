import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

class JoinedClubScreen extends StatelessWidget {
  const JoinedClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Club Directory",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/club_image.png"),
                  fit: BoxFit.cover,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: 0,
                                strokeAlign: BorderSide.strokeAlignOutside),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 0)),
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 0)),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const CustomImage(
                            path: "assets/images/default.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            "Prompt Engineer Club for Bangladesh",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "12,5478 Members",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Image.asset("assets/images/user.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Jhon Doe",
                                  style: darkTextStyle,
                                ),
                                Text(
                                  "3 Feb, 2023",
                                  style: greySmallTextStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          style: greyTextStyle,
                        ),
                      ],
                    ),
                  );
                },
                childCount: 4,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: const Color(0xffD9D9D9),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      hintText: "Write...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: 180,
                    child: CustomBtn(
                      callback: () {},
                      height: 55,
                      width: Get.width,
                      text: 'Submit',
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
