import 'dart:convert';

class UserModel {
  final UserProfileModel user;

  UserModel({
    required this.user,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        user: UserProfileModel.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
      };
}

class UserProfileModel {
  final int id;
  final int roleId;
  final String name;
  final String lastName;
  final String email;
  final String emailVerifiedAt;
  final String dialCode;
  final String phone;
  final String address;
  final String image;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String country;
  final dynamic planId;
  final String billingEmail;
  final String zipcode;
  final String billingName;
  final String billingPhone;
  final String city;
  final String state;
  final String type;
  final String age;
  final String gender;
  final String deviceId;
  final String countryCode;
  final String billingDialCode;
  final String billingCountryCode;
  final Plan plan;
  final int isBuyBook;
  final CurrentUserPlan? currentUserPlan;

  UserProfileModel({
    required this.id,
    required this.roleId,
    required this.name,
    required this.lastName,
    required this.email,
    required this.emailVerifiedAt,
    required this.dialCode,
    required this.phone,
    required this.address,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.country,
    required this.planId,
    required this.billingEmail,
    required this.zipcode,
    required this.billingName,
    required this.billingPhone,
    required this.city,
    required this.state,
    required this.type,
    required this.age,
    required this.gender,
    required this.deviceId,
    required this.countryCode,
    required this.billingDialCode,
    required this.billingCountryCode,
    required this.plan,
    required this.isBuyBook,
    this.currentUserPlan,
  });

  factory UserProfileModel.fromJson(String str) => UserProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromMap(Map<String, dynamic> json) => UserProfileModel(
        id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()),
        roleId: json["role_id"] is int ? json["role_id"] : int.parse(json["role_id"].toString()),
        name: json["name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        emailVerifiedAt: json["email_verified_at"] ?? "",
        dialCode: json["dial_code"] ?? '',
        phone: json["phone"] ?? "",
        address: json["address"] ?? '',
        image: json["image"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        status: json["status"] is bool ? (json["status"] ? "true" : "false") : json["status"]?.toString() ?? '',
        country: json["country"] ?? '',
        planId: json["plan_id"] ?? '',
        billingEmail: json["billing_email"] ?? '',
        zipcode: json["zipcode"] ?? '',
        billingName: json["billing_name"] ?? '',
        billingPhone: json["billing_phone"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        type: json["type"] ?? '',
        age: json["age"] ?? '',
        gender: json["gender"] ?? '',
        deviceId: json["device_id"] ?? '',
        countryCode: json["country_code"] ?? '',
        billingDialCode: json["billing_dial_code"] ?? '',
        billingCountryCode: json["billing_country_code"] ?? '',
        isBuyBook: json["is_buy_book"] is int ? json["is_buy_book"] : int.parse("${json["is_buy_book"]}"),
        plan: json["plan"] != null && json["plan"] is Map<String, dynamic>
            ? Plan.fromJson(json["plan"])
            : Plan(
                id: 0,
                title: "",
                status: 0,
                price: 0,
                priceNgn: 0,
                duration: 0,
                offerings: 0,
                planLibrary: 0,
                book: 0,
                blog: 0,
                forum: 0,
                club: 0,
                createdBy: 0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                updatedBy: 0,
                planId: "",
                planId2: null,
                paypalPlanData: null,
                flutterwavePlanData: null),
        currentUserPlan: json["current_user_plan"] != null ? CurrentUserPlan.fromJson(json["current_user_plan"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "dial_code": dialCode,
        "phone": phone,
        "address": address,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
        "country": country,
        "plan_id": planId,
        "billing_email": billingEmail,
        "zipcode": zipcode,
        "billing_name": billingName,
        "billing_phone": billingPhone,
        "city": city,
        "state": state,
        "type": type,
        "age": age,
        "gender": gender,
        "device_id": deviceId,
        "country_code": countryCode,
        "billing_dial_code": billingDialCode,
        "billing_country_code": billingCountryCode,
        "is_buy_book": isBuyBook,
        "plan": plan.toJson(),
        "current_user_plan": currentUserPlan?.toJson(),
      };
}

class CurrentUserPlan {
  final int id;
  final int userId;
  final int packageId;
  final String planId;
  final String customerId;
  final String subscriptionId;
  final dynamic bookLimit;
  final DateTime expiredDate;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CurrentUserPlan({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.planId,
    required this.customerId,
    required this.subscriptionId,
    required this.bookLimit,
    required this.expiredDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentUserPlan.fromJson(Map<String, dynamic> json) => CurrentUserPlan(
        id: int.tryParse(json["id"].toString()) ?? 0,
        userId: int.tryParse(json["user_id"].toString()) ?? 0,
        packageId: int.tryParse(json["package_id"].toString()) ?? 0,
        planId: json["plan_id"] ?? 0,
        customerId: json["customer_id"] ?? "",
        subscriptionId: json["subscription_id"] ?? "",
        bookLimit: json["book_limit"],
        expiredDate: DateTime.parse(json["expired_date"]),
        status: int.tryParse(json["status"].toString()) ?? json["status"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "package_id": packageId,
        "plan_id": planId,
        "customer_id": customerId,
        "subscription_id": subscriptionId,
        "book_limit": bookLimit,
        "expired_date": expiredDate.toIso8601String(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Plan {
  final int id;
  final String title;
  final int status;
  final int price;
  final int priceNgn;
  final int duration;
  final int offerings;
  final int planLibrary;
  final int book;
  final int blog;
  final int forum;
  final int club;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int updatedBy;
  final String planId;
  final dynamic planId2;
  final dynamic paypalPlanData;
  final dynamic flutterwavePlanData;

  Plan({
    required this.id,
    required this.title,
    required this.status,
    required this.price,
    required this.priceNgn,
    required this.duration,
    required this.offerings,
    required this.planLibrary,
    required this.book,
    required this.blog,
    required this.forum,
    required this.club,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.updatedBy,
    required this.planId,
    required this.planId2,
    required this.paypalPlanData,
    required this.flutterwavePlanData,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        status: int.tryParse(json["status"].toString()) ?? 0,
        price: int.tryParse(json["price"].toString()) ?? 0,
        priceNgn: int.tryParse(json["price_ngn"].toString()) ?? 0,
        duration: int.tryParse(json["duration"].toString()) ?? 0,
        offerings: int.tryParse(json["offerings"].toString()) ?? 0,
        planLibrary: int.tryParse(json["library"].toString()) ?? 0,
        book: int.tryParse(json["book"].toString()) ?? 0,
        blog: int.tryParse(json["blog"].toString()) ?? 0,
        forum: int.tryParse(json["forum"].toString()) ?? 0,
        club: int.tryParse(json["club"].toString()) ?? 0,
        createdBy: int.tryParse(json["created_by"].toString()) ?? json["created_by"] ?? 0,
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
        updatedBy: int.tryParse(json["updated_by"].toString()) ?? 0,
        planId: json["plan_id"] ?? "",
        planId2: json["plan_id2"],
        paypalPlanData: json["paypal_plan_data"],
        flutterwavePlanData: json["flutterwave_plan_data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "price": price,
        "price_ngn": priceNgn,
        "duration": duration,
        "offerings": offerings,
        "library": planLibrary,
        "book": book,
        "blog": blog,
        "forum": forum,
        "club": club,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "updated_by": updatedBy,
        "plan_id": planId,
        "plan_id2": planId2,
        "paypal_plan_data": paypalPlanData,
        "flutterwave_plan_data": flutterwavePlanData,
      };
}
