import 'dart:async';
import 'dart:collection';
import 'package:boring_flutter_dev/src/articles.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  //  List<Article> _articles = []; //articles;
  static List<int> _newIds = [
    22867627,
    22871331,
    22869909,
    22871180,
    22872301,
  ];

  static List<int> _topIds = [
    22865357,
    22867960,
    22863491,
    22870105,
    22870905,
  ];

  Stream<bool> get isLoading => _isLoadingSubject.stream;

  final _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  /// BehaviorSubject
  /// Streams are asynchrous, nice but problems exist. build() method is synchronous.
  /// Changes may present empty.
  /// BS is the last element pushed into the Stream
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  // empty list of articles
  var _articles = <Article>[];

  final _storiesTypeController = StreamController<StoriesType>();

  NewsBloc() {
    _getArticlesAndUpdate(_topIds);

    _storiesTypeController.stream.listen((storiesType) {
      if (storiesType == StoriesType.newStories) {
        _getArticlesAndUpdate(_newIds);
      } else {
        _getArticlesAndUpdate(_topIds);
      }
    });
  }

  _getArticlesAndUpdate(List<int> ids) async {
    _isLoadingSubject.add(true);
    await _updateArticles(ids);
    _articlesSubject.add(UnmodifiableListView(_articles));
    _isLoadingSubject.add(false);
  }

  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;

  Sink<StoriesType> get storiesType => _storiesTypeController.sink;

  Future<Article> _getArticle(int storyId) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$storyId.json';
    final storyResponse = await http.get(storyUrl);
    if (storyResponse.statusCode == 200) {
      return parseArticle(storyResponse.body);
    }
  }

  Future<Null> _updateArticles(List<int> articleIds) async {
    final futureArticles = articleIds.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }
}

enum StoriesType {
  topStories,
  newStories,
}
