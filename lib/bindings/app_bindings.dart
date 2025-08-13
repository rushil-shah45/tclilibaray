import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcllibraryapp_develop/data/data_source/local_data_source.dart';
import 'package:tcllibraryapp_develop/data/data_source/remote_data_source.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/apply_promo_code/controller/apply_promo_code_controller.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/controllers/registration_controller.dart';
import 'package:tcllibraryapp_develop/screens/auth/repository/auth_repository.dart';
import 'package:tcllibraryapp_develop/screens/auth/required_data/controller/required_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/controller/analytics_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/controller/author_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/bookSummary/controller/book_summary_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/controller/all_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/controller/borrowed_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/club/club_new_topic/controllers/club_new_topic_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/controllers/post_details_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/create_club/controllers/create_club_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/controllers/club_controller.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/controller/my_subscription_controller.dart';
import 'package:tcllibraryapp_develop/screens/payment/controller/payment_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/screens/splash/controller/splash_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/controller/ticket_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/repository/ticket_repository.dart';
import 'package:tcllibraryapp_develop/screens/transaction/controller/transaction_controller.dart';
import 'package:tcllibraryapp_develop/screens/twak_chat/controller/twak_controller.dart';

import '../data/SettingsDataController.dart';
import '../screens/book/author/my_readers/controller/my_readers_controller.dart';
import '../screens/club/club_details/controller/club_details_controller.dart';
import '../screens/pricing/controller/pricing_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<Client>(() => Client());
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImpl(client: Get.find()));

    Get.lazyPut<LocalDataSource>(
        () => LocalDataSourceImpl(sharedPreferences: Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.put<SettingsRepository>(SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
    // Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
    //     remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut<TicketRepository>(
        () => TicketRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => LoginController(Get.find()));
    Get.lazyPut(() => RegistrationController(Get.find(), Get.find()));
    Get.lazyPut(() => SplashController(Get.find()));
    Get.lazyPut(() => TwakController());
    Get.lazyPut(() => MainController(Get.find(), Get.find()));
    Get.lazyPut(() => AuthorBookController(Get.find(), Get.find(), Get.find(),
        Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => TicketController(Get.find(), Get.find()));
    Get.lazyPut(() => BorrowedBookController(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() =>
        AllBooksController(Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => AnalyticsController(Get.find(), Get.find()));
    Get.lazyPut(() => FavouriteController(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => MyReadersController(Get.find(), Get.find()));
    Get.lazyPut(() =>
        DashboardController(Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => SettingsController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => PostDetailsController(Get.find(), Get.find()));
    Get.lazyPut(
        () => ClubDetailsController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(
        () => ClubNewTopicController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(
        () => FavouriteBooksController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => ClubController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => CreateClubController(Get.find(), Get.find()));
    Get.lazyPut(() => ApplyPromoCodeController(Get.find(), Get.find()));
    Get.lazyPut(() => TransactionController(Get.find(), Get.find()));
    Get.lazyPut(() => MySubscriptionController(
        Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => PaymentController(Get.find(), Get.find(), Get.find(),
        Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => PricingController(Get.find(), Get.find()));
    Get.lazyPut(() => RequiredController(Get.find()));
    Get.put(SettingsDataController());
    Get.lazyPut(() => BookSummaryController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
