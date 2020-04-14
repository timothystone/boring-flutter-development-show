import 'dart:convert' as json;
import 'package:built_value/built_value.dart';

part 'json_parsing.g.dart';


abstract class Article implements Built<Article, ArticleBuilder> {
  String get by;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}
//class Article {
//  final String by;
//  final int descendants;
//  final int id;
//  final List<int> kids;
//  final int score;
//  final int time;
//  final String title;
//  final String type;
//  final String url;
//
//  const Article(
//      {this.by, this.descendants, this.id, this.kids, this.score, this.time, this.title, this.type, this.url});
//
//  factory Article.fromJson(Map<String, dynamic> json) {
//    if (json == null) {
//      return null;
//    }
//
//    return Article(
//        by: json['by'] ?? '[null]',
//        descendants: json['descendants'],
//        id: json['id'],
//        kids: List.from(json['kids']),
//        score: json['score'],
//        time: json['time'],
//        title: json['title'],
//        type: json['type'],
//        url: json['url']);
//  }
//}

List<int> parseTopStories(String ids) {
//  final parsed = json.jsonDecode(ids);
//  final listOfIds = List<int>.from(parsed);
//  return listOfIds;
  return [];
}

Article parseArticle(String article) {
//  final parsed = json.jsonDecode(article);
//  Article _article = Article.fromJson(parsed);
//  return _article;
  return null;
}
