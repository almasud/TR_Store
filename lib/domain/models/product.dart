/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'dart:convert';

/// id : 1
/// title : "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
/// content : "Ante taciti nulla sit libero orci sed nam. Sagittis suspendisse gravida ornare iaculis cras nullam varius ac ullamcorper. Nunc euismod hendrerit netus ligula aptent potenti. Aliquam volutpat nibh scelerisque at. Ipsum molestie phasellus euismod sagittis mauris, erat ut. Gravida morbi, sagittis blandit quis ipsum mi mus semper dictum amet himenaeos. Accumsan non congue praesent interdum habitasse turpis orci. Ante curabitur porttitor ullamcorper sagittis sem donec, inceptos cubilia venenatis ac. Augue fringilla sodales in ullamcorper enim curae; rutrum hac in sociis! Scelerisque integer varius et euismod aenean nulla. Quam habitasse risus nullam enim. Ultrices etiam viverra mattis aliquam? Consectetur velit vel volutpat eget curae;. Volutpat class mus elementum pulvinar! Nisi tincidunt volutpat consectetur. Primis morbi pulvinar est montes diam himenaeos duis elit est orci. Taciti sociis aptent venenatis dui malesuada dui justo faucibus primis consequat volutpat. Rhoncus ante purus eros nibh, id et hendrerit pellentesque scelerisque vehicula sollicitudin quam. Hac class vitae natoque tortor dolor dui praesent suspendisse. Vehicula euismod tincidunt odio platea aenean habitasse neque ad proin. Bibendum phasellus enim fames risus eget felis et sem fringilla etiam. Integer."
/// image : "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org"
/// thumbnail : "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org"
/// publishedAt : "04/02/2023 13:25:21"
/// updatedAt : "14/03/2023 17:22:20"
/// userId : 1

final dummyProducts = [
  Product(
      id: 1,
      title: "Product 1",
      content: "This the content of the Product 1 sdk sldkjs sdk sdjlskjlsd s sdkjfslkdjf sdjklsdkjfsd  sdljlsjf",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 1,
      publishedAt: "04/02/2023 13:25:21",
      updatedAt: "14/03/2023 17:22:20"),
  Product(
      id: 2,
      title: "Product 2",
      content: "This the content of the Product 2",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 2,
      publishedAt: "05/02/2023 13:25:21",
      updatedAt: "14/03/2023 17:22:20"),
  Product(
      id: 3,
      title: "Product 3",
      content: "This the content of the Product 3",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 3,
      publishedAt: "06/02/2023 13:25:21",
      updatedAt: "14/03/2023 18:22:20"),
  Product(
      id: 4,
      title: "Product 4",
      content: "This the content of the Product 4",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 4,
      publishedAt: "07/02/2023 13:25:21",
      updatedAt: "15/03/2023 18:22:20"),
  Product(
      id: 5,
      title: "Product 5",
      content: "This the content of the Product 5",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 5,
      publishedAt: "08/02/2023 14:25:21",
      updatedAt: "16/03/2023 19:22:20"),
];

List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productsToJson(List<Product> products) =>
    json.encode(products.map((x) => x.toJson()).toList());

class Product {
  Product({
    num? id,
    String? title,
    String? content,
    String? image,
    String? thumbnail,
    String? publishedAt,
    String? updatedAt,
    num? userId,
  }) {
    _id = id;
    _title = title;
    _content = content;
    _image = image;
    _thumbnail = thumbnail;
    _publishedAt = publishedAt;
    _updatedAt = updatedAt;
    _userId = userId;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
    _image = json['image'];
    _thumbnail = json['thumbnail'];
    _publishedAt = json['publishedAt'];
    _updatedAt = json['updatedAt'];
    _userId = json['userId'];
  }

  num? _id;
  String? _title;
  String? _content;
  String? _image;
  String? _thumbnail;
  String? _publishedAt;
  String? _updatedAt;
  num? _userId;

  Product copyWith({
    num? id,
    String? title,
    String? content,
    String? image,
    String? thumbnail,
    String? publishedAt,
    String? updatedAt,
    num? userId,
  }) =>
      Product(
        id: id ?? _id,
        title: title ?? _title,
        content: content ?? _content,
        image: image ?? _image,
        thumbnail: thumbnail ?? _thumbnail,
        publishedAt: publishedAt ?? _publishedAt,
        updatedAt: updatedAt ?? _updatedAt,
        userId: userId ?? _userId,
      );

  num? get id => _id;

  String? get title => _title;

  String? get content => _content;

  String? get image => _image;

  String? get thumbnail => _thumbnail;

  String? get publishedAt => _publishedAt;

  String? get updatedAt => _updatedAt;

  num? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['content'] = _content;
    map['image'] = _image;
    map['thumbnail'] = _thumbnail;
    map['publishedAt'] = _publishedAt;
    map['updatedAt'] = _updatedAt;
    map['userId'] = _userId;
    return map;
  }
}
