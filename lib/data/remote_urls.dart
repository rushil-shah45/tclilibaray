class RemoteUrls {
  // static const String rootUrl = "https://staging.tclilibrary.com/";
  static const String rootUrl = "https://tclilibrary.com/";
  static const String baseUrl = "${rootUrl}api/";
  static const String socialLogin = '${baseUrl}social-login';

  static const String settings = '${baseUrl}settings';

  static const String userLogin = '${baseUrl}login';
  static const String updatePassword = '${baseUrl}password/update';
  static const String userRegistration = '${baseUrl}register';
  static const String userProfile = '${baseUrl}profile';
  static const String updateProfile = '${baseUrl}profile/update';
  static const String getClub = '${baseUrl}club';
  static const String postReply = '${baseUrl}club/post/reply';

  static const String clubStore = '${baseUrl}club/store';
  static const String getNotifications = '${baseUrl}get/notification';
  static const String getTransaction = '${baseUrl}transactions';

  static String readNotification(id) => '${baseUrl}read/notification?notification_id=$id';

  static String clubUpdate(id) => '${baseUrl}club/$id/update';

  static String clubMemberStatusChange(id, status) => '${baseUrl}club/member/$id/status/$status';

  static const String createTopic = '${baseUrl}club/post/store';

  static String deleteUserTicket(id) => '${baseUrl}support-ticket/$id/delete';

  static String getPostDetails(id) => '${baseUrl}club/post/$id/details';

  static String getClubDetails(id) => '${baseUrl}club/$id/details';

  static String getUserTicketDetails(id) => '${baseUrl}support-ticket/$id/view';
  static const String createUserTicket = '${baseUrl}support-ticket/store';

  static String makePaypalPayment(id) => '$baseUrl$id/payment/submit';
  static String buyBook(id) => '${baseUrl}book/$id/buy';
  static const String getUserTicket = '${baseUrl}support-ticket';
  static const String flutterWaveApi = '${baseUrl}support-ticket';
  static String userTicketReplay = '${baseUrl}support-ticket/reply';

  static String myBook = '${baseUrl}books/my_books';
  static String pendingBook = '${baseUrl}books/pending';
  static String declineBook = '${baseUrl}books/declined';
  static String myReadersBook = '${baseUrl}books/my-readers';

  static String publisherAndAuthor = '${baseUrl}books/getSearchData';
  static String makeBookPayment(id) => '${baseUrl}checkout/$id/checkout/book';
  static String archivement = '${baseUrl}achievements/resume';

  static String allBook(page, search, category, author) =>
      '${baseUrl}books/all?page=$page&keyword=$search&category=${category == "0" ? "" : category}&author_id=${author == "0" ? "" : author}';

  static String allBookNew(page, search, category, author) =>
      '${baseUrl}books/all-books?page=$page&keyword=$search&category=${category == "0" ? "" : category}&author_id=${author == "0" ? "" : author}';

  //
  static String allBookForBookOfMonth(page, search, category, author) =>
      '${baseUrl}books/bookofmonth?page=$page&keyword=$search&category=${category == "0" ? "" : category}&author_id=${author == "0" ? "" : author}';

  static String favouriteBook(page) => '${baseUrl}books/favorite?page=$page';

  static String favouriteBookStore(id) => '${baseUrl}books/$id/favorite/store';

  static String borrowedBook = '${baseUrl}books/borrowed';

  static String borrowedBookStore(id) => '${baseUrl}books/$id/borrowed/store';

  static String dashboard = '${baseUrl}dashboard';

  static String analytics(id) => '${baseUrl}books/$id/analytic';
  static String category = '${baseUrl}category';
  static String faq = '${baseUrl}faq';
  static String privacyPolicyTerms = '${baseUrl}custom-page';
  static String booksStore = '${baseUrl}books/store';

  static String booksUpdate(id) => '${baseUrl}books/$id/update';

  static String deleteBook(id) => '${baseUrl}books/$id/delete';
  static String deleteReview(id) => '${baseUrl}books/$id/review/delete';

  static String viewBookDetails(id, bookForSale) => '${baseUrl}books/$id/details/$bookForSale';
  static String forgotPassword = '${baseUrl}forgot/password';
  static String ratingSubmit = '${baseUrl}books/review';
  static String readPage(id) => '${baseUrl}books/$id/read-page';
  static String pageProgress(id) => '${baseUrl}books/$id/progress';
  static String getPricing = '${baseUrl}pricing';
  static String deleteAccount = '${baseUrl}user/delete';
  static String joinClub = '${baseUrl}club/join';
  static String leaveClub = '${baseUrl}club/leave';

  static String applyPromo = '${baseUrl}apply/promo-code';

  static String billingUpdate = '${baseUrl}billing/update';

  static String blogs = '${rootUrl}blog';
  static String forum = '${rootUrl}forum';
  static String twakSrc = "https://www.tawk.to/";

  static String countryData = 'https://restcountries.com/v2/all';
}
