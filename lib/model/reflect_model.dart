import 'package:cloud_firestore/cloud_firestore.dart';

class ReflectModel {
  final String? id;
  final String? email;
  final String? title;
  final String? category;
  final String? content;
  final String? address;
  final String? media;
  final int? handle;
  final Timestamp? createdAt;

  const ReflectModel({
    this.id,
    required this.email,
    required this.title,
    required this.category,
    required this.content,
    required this.address,
    required this.media,
    required this.handle,
    required this.createdAt,
  });

  toJson() {
    return {
      "Email": email,
      "Title": title,
      "Category": category,
      "Content": content,
      "Address": address,
      "Media": media,
      "Handle": handle,
      "CreatedAt": createdAt,
    };
  }

  factory ReflectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReflectModel(
        id: document.id,
        email: data["Email"],
        title: data["Title"],
        category: data["Category"],
        content: data["Content"],
        address: data["Address"],
        media: data["Media"],
        handle: data["Handle"],
        createdAt: data["CreatedAt"]
    );
  }
}
