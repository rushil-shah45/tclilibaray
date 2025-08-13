import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/archivment/archivement_api_response_model.dart';

class ArchivementScree extends StatefulWidget {
  const ArchivementScree({super.key});

  @override
  State<ArchivementScree> createState() => _ArchivementScreeState();
}

class _ArchivementScreeState extends State<ArchivementScree> {

  var archivement = <UserAchievement>[].obs;
  var isLoading = false.obs;
  var totlaBookReads = ''.obs;
  var totalPageReads = ''.obs;


  @override
  void initState() {
    archivementApi();
    super.initState();
  }

  archivementApi() async {
    archivement.clear();
    isLoading.value = true;
    var token = sharedPreferences.getString("uToken");
    final url = Uri.parse(RemoteUrls.archivement);

    log('URL For Publisher: $url /// Token :::: $token');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    log('Response status: For Archivement ${response.statusCode} ');
    ArchivmentApiResponseModel responseModel =
        ArchivmentApiResponseModel.fromJson(json.decode(response.body));

    if (responseModel.code == 200) {
      
      totlaBookReads.value = responseModel.data!.totalBooksRead.toString();
      totalPageReads.value = responseModel.data!.totalPagesRead.toString();
      archivement.addAll(responseModel.data!.userAchievements!);
      log("Archivement Data : ${archivement.length}");
      isLoading.value = false;
      
    } else {
      log('Error in Archivement API');
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Achievements",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Obx(()=> isLoading.value ? ListView.builder(
                  itemCount: 10, 
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade300,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          height: 80.h, // Set a fixed height for shimmer effect
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    );
                  },
                ):
           Column(
            children: [
              Text(
                "Your Reading Stats",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 13.h),
              Obx(()=>
                 Row(
                  children: [
                    Text(
                      "Total Books Read: ${totlaBookReads.value}",
                      style:
                          TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      "Total Pages Read: ${totalPageReads.value}",
                      style:
                          TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: ListView.builder(
                  itemCount: archivement.length,
                  itemBuilder: (context, index){
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 10.h),
                    child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: const Color.fromARGB(255, 228, 228, 228)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0.0, 2.0),
                          ),
                        ]),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            archivement[index].name ?? '', 
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 13.h),
                          Text(
                            "Books Read: ${archivement[index].booksread}",
                            style: TextStyle(
                                fontSize: 13.5.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Pages Read: ${archivement[index].pagesread}",
                            style: TextStyle(
                                fontSize: 13.5.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                                  ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
