import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';

class BorrowedModel {
  final List<Book> books;
  final int totalBooks;

  BorrowedModel({
    required this.books,
    required this.totalBooks,
  });

  factory BorrowedModel.fromJson(String str) =>
      BorrowedModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BorrowedModel.fromMap(Map<String, dynamic> json) => BorrowedModel(
        books: List<Book>.from(json["books"].map((x) => Book.fromMap(x))),
        totalBooks: json["total_books"],
      );

  Map<String, dynamic> toMap() => {
        "books": List<dynamic>.from(books.map((x) => x.toMap())),
        "total_books": totalBooks,
      };
}