import 'dart:convert' as json;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'articles.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;
  String get by;
  int get descendants;
  int get id;
  BuiltList<int> get kids;
  int get score;
  int get time;
  String get title;

  /// Article Type
  /// Articles can be one of "job", "story", "comment", "poll", or "pollopt".
  String get type;

  /// Article URL
  /// May be null.
  @nullable
  String get url;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

List<int> parseTopStories(String ids) {
  final parsed = json.jsonDecode(ids);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Article parseArticle(String article) {
  final parsed = json.jsonDecode(article);
  Article _article = serializers.deserializeWith(Article.serializer, parsed);
  return _article;
}
