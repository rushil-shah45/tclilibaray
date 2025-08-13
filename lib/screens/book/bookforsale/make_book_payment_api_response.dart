// To parse this JSON data, do
//
//     final makeBookPaymentApiResponseData = makeBookPaymentApiResponseDataFromJson(jsonString);

import 'dart:convert';

MakeBookPaymentApiResponseData makeBookPaymentApiResponseDataFromJson(String str) => MakeBookPaymentApiResponseData.fromJson(json.decode(str));

String makeBookPaymentApiResponseDataToJson(MakeBookPaymentApiResponseData data) => json.encode(data.toJson());

class MakeBookPaymentApiResponseData {
    bool? status;
    int? code;
    String? msg;
    String? error;
    Data? data;
    dynamic description;

    MakeBookPaymentApiResponseData({
        this.status,
        this.code,
        this.msg,
        this.error,
        this.data,
        this.description,
    });

    factory MakeBookPaymentApiResponseData.fromJson(Map<String, dynamic> json) => MakeBookPaymentApiResponseData(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        error: json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "error": error,
        "data": data?.toJson(),
        "description": description,
    };
}

class Data {
    String? approveLink;
    Response? response;

    Data({
        this.approveLink,
        this.response,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        approveLink: json["ApproveLink"],
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "ApproveLink": approveLink,
        "response": response?.toJson(),
    };
}

class Response {
    String? id;
    String? status;
    List<Link>? links;

    Response({
        this.id,
        this.status,
        this.links,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        status: json["status"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    };
}

class Link {
    String? href;
    String? rel;
    String? method;

    Link({
        this.href,
        this.rel,
        this.method,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        href: json["href"],
        rel: json["rel"],
        method: json["method"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "rel": rel,
        "method": method,
    };
}
