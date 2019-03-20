import 'dart:convert' as json;
import 'package:built_value/built_value.dart';

import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'serializers.dart';
import 'package:meta/meta.dart';

//
//class Article {
//  final String text;
//  final String url;
//  final String by;
//  final int time;
//  final int score;
//  final int commentsCount;
//
//  Article(
//      {this.text, this.url, this.by, this.time, this.score, this.commentsCount});
//
//  factory Article.fromJson(Map<String, dynamic> json) {
//    if (json == null) return null;
//    return Article(
//        text: json['text'] ?? '[null]',
//        url: json['url'],
//        by: json['by'],
//        time: json['age'] ?? 0 ,
//        score: json['score'] ?? 0,
//        commentsCount: json['comentsCount']) ?? 0;
//  }
//}

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;

  int get id;

  @nullable
  bool get deleted;

  String get type;

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  BuiltList<int> get parts;

  int get descendants;

  Article._();

  factory Article([updates(ArticleBuilder b)]) = _$Article;
}

Article parseArticle(String jsonStr) {
  final parsed = json.jsonDecode(jsonStr);
  Article article = standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}
