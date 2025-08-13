import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/component/favourite_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/component/grid_favourite_container.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';

class FavouriteBookScreen extends StatefulWidget {
  const FavouriteBookScreen({super.key});

  @override
  State<FavouriteBookScreen> createState() => _FavouriteBookScreenState();
}

class _FavouriteBookScreenState extends State<FavouriteBookScreen> {
  final ScrollController _scrollController = ScrollController();
  FavouriteController controller = Get.find();

  void _scroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.loadMoreFiles();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "Favourite Books",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.changePage();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? const FavouriteShimmer()
                  : controller.favouriteBooksModel.value.isEmpty
                      ? CustomScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                              SliverPadding(
                                  padding:
                                      EdgeInsets.only(top: 140.h),
                                  sliver: const SliverToBoxAdapter(
                                      child: CustomGifImage()))
                            ])
                      : CustomScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            GridFavouriteContainer(controller: controller),
                            SliverToBoxAdapter(child: SizedBox(height: 10.h))
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }
}
