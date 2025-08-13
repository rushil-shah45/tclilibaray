import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/apply_promo_code/apply_promo_code_screen.dart';
import 'package:tcllibraryapp_develop/screens/apply_promo_code/binding/apply_promo_code_binding.dart';
import 'package:tcllibraryapp_develop/screens/auth/forgot/binding/forgot_pass_binding.dart';
import 'package:tcllibraryapp_develop/screens/auth/forgot/forgot_pass_screen.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/login_screen.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/binding/registration_binding.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/screens/registration_screen.dart';
import 'package:tcllibraryapp_develop/screens/auth/required_data/binding/required_binding.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/analytics_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/binding/analytics_board_binding.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/binding/book_details_binding.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/book_details_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/bookSummary/binding/book_summary_binding.dart';
import 'package:tcllibraryapp_develop/screens/book/bookSummary/book_summary.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/all_books_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/binding/all_books_binding.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/binding/borrow_book_binding.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/borrowed_books_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/binding/favourite_books_bindings.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/favourite_books_screen.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/binding/club_details_binding.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/club_details_screen.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/component/discussion_details.dart';
import 'package:tcllibraryapp_develop/screens/club/club_new_topic/bindings/club_new_topic_binding.dart';
import 'package:tcllibraryapp_develop/screens/club/club_new_topic/club_new_topic_screen.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/bindings/post_details_binding.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/post_details_screen.dart';
import 'package:tcllibraryapp_develop/screens/club/create_club/bindings/create_club_binding.dart';
import 'package:tcllibraryapp_develop/screens/club/create_club/create_club.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/bindings/club_binding.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/club_screen.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/component/ask_question.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/component/joined_club.dart';
import 'package:tcllibraryapp_develop/screens/faq/binding/faq_binding.dart';
import 'package:tcllibraryapp_develop/screens/faq/faq_screen.dart';
import 'package:tcllibraryapp_develop/screens/main/binding/main_screen_binding.dart';
import 'package:tcllibraryapp_develop/screens/main/main_screen.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/billing_details.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/binding/my_subscription_binding.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/my_subscription_screen.dart';
import 'package:tcllibraryapp_develop/screens/no_internet/binding/no_internet_binding.dart';
import 'package:tcllibraryapp_develop/screens/no_internet/no_internet_screen.dart';
import 'package:tcllibraryapp_develop/screens/notification/binding/notification_binding.dart';
import 'package:tcllibraryapp_develop/screens/notification/notification_screen.dart';
import 'package:tcllibraryapp_develop/screens/payment/binding/payment_binding.dart';
import 'package:tcllibraryapp_develop/screens/payment/payment_screen.dart';
import 'package:tcllibraryapp_develop/screens/pricing/binding/pricing_binding.dart';
import 'package:tcllibraryapp_develop/screens/pricing/in_app_purchase_screen.dart';
import 'package:tcllibraryapp_develop/screens/pricing/pricing_screen.dart';
import 'package:tcllibraryapp_develop/screens/privacy_policy/binding/privacy_policy_binding.dart';
import 'package:tcllibraryapp_develop/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:tcllibraryapp_develop/screens/setting/binding/setting_binding.dart';
import 'package:tcllibraryapp_develop/screens/setting/component/password_change.dart';
import 'package:tcllibraryapp_develop/screens/setting/component/profile_edit_mode.dart';
import 'package:tcllibraryapp_develop/screens/setting/setting_screen.dart';
import 'package:tcllibraryapp_develop/screens/splash/binding/splash_binding.dart';
import 'package:tcllibraryapp_develop/screens/splash/screens/splash_screen.dart';
import 'package:tcllibraryapp_develop/screens/terms_condition/binding/term_condition_binding.dart';
import 'package:tcllibraryapp_develop/screens/terms_condition/terms_condition_screen.dart';
import 'package:tcllibraryapp_develop/screens/ticket/binding/ticket_binding.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/add_ticket.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/view_ticket/binding/view_ticket_binding.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/view_ticket/view_ticket.dart';
import 'package:tcllibraryapp_develop/screens/ticket/ticket_screen.dart';
import 'package:tcllibraryapp_develop/screens/transaction/binding/transaction_binding.dart';
import 'package:tcllibraryapp_develop/screens/transaction/transaction_screen.dart';
import 'package:tcllibraryapp_develop/screens/twak_chat/binding/twak_binding.dart';
import 'package:tcllibraryapp_develop/screens/twak_chat/twak_chat_screen.dart';

import '../screens/auth/required_data/required_data_added.dart';
import '../screens/book/author/add_book/add_book_screen.dart';
import '../screens/book/author/add_book/binding/add_book_binding.dart';
import '../screens/book/author/book_update/bindings/update_book_binding.dart';
import '../screens/book/author/book_update/update_book_screen.dart';
import '../screens/book/author/decline_book/binding/decline_book_binding.dart';
import '../screens/book/author/decline_book/decline_book_screen.dart';
import '../screens/book/author/my_readers/binding/my_readers_binding.dart';
import '../screens/book/author/my_readers/my_readers_screen.dart';
import '../screens/book/author/mybooks/binding/my_book_binding.dart';
import '../screens/book/author/mybooks/my_book_screen.dart';
import '../screens/book/author/pending_book/binding/pending_book_binding.dart';
import '../screens/book/author/pending_book/pending_book_screen.dart';
import '../screens/book/bookforsale/all_book_for_sale_screen.dart';

class Pages {
  static const initial = SplashScreen();

  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.bookDetailsScreen,
      page: () => const BookDetailsScreen(),
      binding: BookDetailsBindings(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      // binding: (),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.registration,
      page: () => const RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: Routes.notifications,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: () =>  const MainScreen(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: Routes.twak,
      page: () => const TwakScreen(),
      binding: TwakBinding(),
    ),
    GetPage(
      name: Routes.myBooks,
      page: () => const MyBookScreen(),
      binding: MyBookBinding(),
    ),
    GetPage(
      name: Routes.myReaders,
      page: () => const MyReadersScreen(),
      binding: MyReadersBinding(),
    ),
    GetPage(
      name: Routes.analyticsScreen,
      page: () => const AnalyticsScreen(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: Routes.allBooks,
      page: () => const AllBooksScreen(),
      binding: AllBooksBinding(),
    ),
    GetPage(
      name: Routes.bookSummary,
      // page: () => const AllBooksScreen(),
      page: () => const BookSummaryScreen(),
      binding: BookSummaryBinding(),
    ),
    // GetPage(
    //   name: Routes.allSaleBooks,
    //   page: () => const AllBookForSaleScreen(),
    //   binding: AllBookForSaleScreen(),
    // ),
    GetPage(
      name: Routes.favouriteBook,
      page: () => const FavouriteBookScreen(),
      binding: FavouriteBookBinding(),
    ),
    GetPage(
      name: Routes.pendingBooks,
      page: () => const PendingBookScreen(),
      binding: PendingBookBinding(),
    ),
    GetPage(
      name: Routes.declineBooks,
      page: () => const DeclineBookScreen(),
      binding: DeclineBookBinding(),
    ),
    GetPage(
      name: Routes.borrowedBooks,
      page: () => const BorrowedBookScreen(),
      binding: BorrowBookBinding(),
    ),
    GetPage(
      name: Routes.addTicket,
      page: () => const AddTicketScreen(),
      binding: AddTicketBinding(),
    ),
    GetPage(
      name: Routes.supportTicket,
      page: () =>  TicketScreen(),
      binding: AddTicketBinding(),
    ),
    GetPage(
      name: Routes.viewTicket,
      page: () => const ViewTicket(),
      binding: ViewTicketBinding(),
    ),
    GetPage(
      name: Routes.addBookScreen,
      page: () => const AddBookScreen(),
      binding: AddBookBinding(),
    ),
    GetPage(
      name: Routes.discussionDetails,
      page: () => const DiscussionDetails(),
      // binding: AddBookBinding(),
    ),
    GetPage(
      name: Routes.updateBookScreen,
      page: () => const UpdateBookScreen(),
      binding: UpdateBookBinding(),
    ),
    GetPage(
      name: Routes.clubScreen,
      page: () => const ClubScreen(),
      binding: ClubBinding(),
    ),
    GetPage(
      name: Routes.postDetailsScreen,
      page: () => const PostDetailsScreen(),
      binding: PostDetailsBinding(),
    ),
    GetPage(
      name: Routes.clubNewTopicScreen,
      page: () => const ClubNewTopicScreen(),
      binding: ClubNewTopicBinding(),
    ),
    GetPage(
      name: Routes.createClubScreen,
      page: () => const CreateClubScreen(),
      binding: CreateClubBinding(),
    ),
    GetPage(
      name: Routes.clubDetails,
      page: () => const ClubDetailsScreen(),
      binding: ClubDetailsBinding(),
    ),
    GetPage(
      name: Routes.joinedClub,
      page: () => const JoinedClubScreen(),
      // binding: AddBookBinding(),
    ),
    GetPage(
      name: Routes.askQuestionToClub,
      page: () => const AskQuestionScreen(),
      // binding: AddBookBinding(),
    ),
    GetPage(
      name: Routes.pricing,
      page: () => const PricingScreen(),
      binding: PricingBinding(),
    ),
    GetPage(
      name: Routes.noInternet,
      page: () => const NoInternetScreen(),
      binding: NoInternetBinding(),
    ),
    GetPage(
      name: Routes.setting,
      page: () =>  SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.profileEditMode,
      page: () => const ProfileEditScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.passwordChange,
      page: () => const PasswordChangeScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.faq,
      page: () => const FaqScreen(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: Routes.privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: Routes.termsCondition,
      page: () => const TermsConditionScreen(),
      binding: TermConditionBinding(),
    ),
    GetPage(
      name: Routes.applyPromoCode,
      page: () => const ApplyPromoCodeScreen(),
      binding: ApplyPromoCodeBinding(),
    ),
    GetPage(
      name: Routes.transactionScreen,
      page: () => const TransactionScreen(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.mySubscriptionScreen,
      page: () => const MySubscriptionScreen(),
      binding: MySubscriptionBinding(),
    ),
    GetPage(
      name: Routes.billingDetailsScreen,
      page: () => const BillingDetails(),
      binding: MySubscriptionBinding(),
    ),
    GetPage(
      name: Routes.paymentScreen,
      page: () =>  const PaymentScreen(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.requiredScreen,
      page: () => const RequiredDataScreen(),
      binding: RequiredBinding(),
    ),
    GetPage(
      name: Routes.inAppPurchaseScreen,
      page: () =>
          InAppPurchaseScreen(package: Get.arguments[0], id: Get.arguments[1]),
      binding: PricingBinding(),
    ),
  ];
}
