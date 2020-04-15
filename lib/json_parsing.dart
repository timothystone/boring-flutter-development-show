//import 'dart:convert' as json;
//import 'package:built_collection/built_collection.dart';
//import 'package:built_value/built_value.dart';
//import 'package:built_value/serializer.dart';
//import 'serializers.dart';
//
//part 'json_parsing.g.dart';
//
//abstract class Article implements Built<Article, ArticleBuilder> {
//  static Serializer<Article> get serializer => _$articleSerializer;
//  String get by;
//  int get descendants;
//  int get id;
//  BuiltList<int> get kids;
//  int get score;
//  int get time;
//  String get title;
//  String get type;
//  String get url;
//
//  Article._();
//  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
//}
//
//List<int> parseTopStories(String ids) {
////  final parsed = json.jsonDecode(ids);
////  final listOfIds = List<int>.from(parsed);
////  return listOfIds;
//  return [];
//}
//
//Article parseArticle(String article) {
//  final parsed = json.jsonDecode(article);
//  Article _article = serializers.deserializeWith(Article.serializer, parsed);
//  return _article;
//}
