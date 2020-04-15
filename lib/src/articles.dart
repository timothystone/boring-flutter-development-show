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
  String get type;
  @nullable
  String get url;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

List<int> parseTopStories(String ids) {
//  final parsed = json.jsonDecode(ids);
//  final listOfIds = List<int>.from(parsed);
//  return listOfIds;
  return [];
}

Article parseArticle(String article) {
  final parsed = json.jsonDecode(article);
  Article _article = serializers.deserializeWith(Article.serializer, parsed);
  return _article;
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
//}
//
//final articles = [
//  Article(
//      by: "greatwave1",
//      descendants: 60,
//      id: 22848779,
//      kids: [
//        22849182,
//        22850058,
//        22848823,
//        22849960,
//        22849130,
//        22849874,
//        22849430,
//        22849103,
//        22849998,
//        22849275,
//        22849102,
//        22849348,
//        22848802,
//        22849812,
//        22849680,
//        22849149,
//        22849415,
//        22849575
//      ],
//      score: 173,
//      time: 1586704857,
//      title: "Show HN: Dashboard for tracking insider trading at S&P 500 companies",
//      type: "story",
//      url: "https://www.quiverquant.com/sources/insidertrading"),
//  Article(
//      by: "atomlib",
//      descendants: 41,
//      id: 22848106,
//      kids: [
//        22850102,
//        22848888,
//        22849387,
//        22848528,
//        22849786,
//        22848990,
//        22849259,
//        22848414,
//        22849414,
//        22848787,
//        22848696,
//        22848666
//      ],
//      score: 188,
//      time: 1586698101,
//      title: "Enemy AI: chasing a player without Navigation2D or A* pathfinding",
//      type: "story",
//      url: "https://abitawake.com/news/articles/enemy-ai-chasing-a-player-without-navigation2d-or-a-star-pathfinding"),
//  Article(
//      by: "jameslk",
//      descendants: 36,
//      id: 22849081,
//      kids: [
//        22849805,
//        22849824,
//        22849670,
//        22849705,
//        22849682,
//        22849870,
//        22849643,
//        22850008,
//        22849897,
//        22849648,
//        22849689
//      ],
//      score: 41,
//      time: 1586707402,
//      title: "Seen everywhere in last U.S. crisis, moral hazard is nowhere in this one",
//      type: "story",
//      url: "https://www.reuters.com/article/idUSKCN21U0GV"),
//  Article(
//      by: "pagade",
//      descendants: 15,
//      id: 22848034,
//      kids: [22849092, 22849690, 22848858],
//      score: 137,
//      time: 1586697305,
//      title: "How to Speak (2018) [video]",
//      type: "story",
//      url: "https://ocw.mit.edu/resources/res-tll-005-how-to-speak-january-iap-2018/how-to-speak/index.htm"),
//  Article(
//      by: "lukestateson",
//      descendants: 94,
//      id: 22847491,
//      kids: [
//        22849034,
//        22849719,
//        22848763,
//        22848134,
//        22849926,
//        22848250,
//        22848514,
//        22849205,
//        22849025,
//        22849020,
//        22848844,
//        22848483,
//        22848770,
//        22849439,
//        22849915,
//        22848123,
//        22849410,
//        22848991,
//        22849221
//      ],
//      score: 144,
//      time: 1586690585,
//      title: "Social Distancing Is Bringing Drive-In Theaters Back to Life",
//      type: "story",
//      url: "https://www.atlasobscura.com/articles/drive-in-theaters-adapt-to-coronavirus"),
//  Article(
//      by: "bottle2",
//      descendants: 11,
//      id: 22849462,
//      kids: [22849885, 22849919, 22850059, 22849961, 22850084],
//      score: 32,
//      time: 1586710746,
//      title: "Surveillance Capitalism",
//      type: "story",
//      url: "https://en.wikipedia.org/wiki/Surveillance_capitalism"),
//  Article(
//      by: "transitivebs",
//      descendants: 3,
//      id: 22842542,
//      kids: [22850060, 22842564, 22849924],
//      score: 28,
//      time: 1586623223,
//      title: "Show HN: Search your Twitter history with Algolia",
//      type: "story",
//      url: "https://github.com/saasify-sh/twitter-search"),
//  Article(
//      by: "jandeboevrie",
//      descendants: 16,
//      id: 22847462,
//      kids: [22848498, 22849451, 22848567, 22848270, 22849452, 22849632, 22849476, 22847946, 22848817, 22848279],
//      score: 103,
//      time: 1586690331,
//      title: "Rediscovering CardDAV",
//      type: "story",
//      url: "https://jpmens.net/2020/04/12/rediscovering-carddav/"),
//  Article(
//      by: "aluket",
//      descendants: 1,
//      id: 22849554,
//      kids: [22849574],
//      score: 13,
//      time: 1586711596,
//      title: "Entropy and Life",
//      type: "story",
//      url: "https://en.wikipedia.org/wiki/Entropy_and_life"),
//  Article(
//      by: "lwhsiao",
//      descendants: 224,
//      id: 22846250,
//      kids: [
//        22847505,
//        22849741,
//        22849528,
//        22846764,
//        22846748,
//        22846709,
//        22846868,
//        22846907,
//        22846814,
//        22848244,
//        22846842,
//        22850088,
//        22849941,
//        22848611,
//        22849657,
//        22846692,
//        22847056,
//        22849082,
//        22847494,
//        22847046,
//        22849416,
//        22848535,
//        22847118,
//        22849236,
//        22847919,
//        22847366,
//        22847167,
//        22846664,
//        22848035,
//        22847722,
//        22846685,
//        22848320,
//        22847615,
//        22846817,
//        22849024,
//        22846746,
//        22848061,
//        22847530,
//        22847209,
//        22846686,
//        22847258
//      ],
//      score: 361,
//      time: 1586669547,
//      title: "Bored? How about trying a Linux speed run?",
//      type: "story",
//      url: "https://rachelbythebay.com/w/2020/04/11/pengrun/"),
//  Article(
//      by: "bottle2",
//      descendants: 18,
//      id: 22848216,
//      kids: [22849565, 22849993, 22848834, 22848877, 22848789, 22849343],
//      score: 53,
//      time: 1586699256,
//      title: "The cost of virtualizing CS conferences",
//      type: "story",
//      url: "https://rachitnigam.com/post/virtual-cs-conferences/"),
//  Article(
//      by: "kiyanwang",
//      descendants: 4,
//      id: 22847877,
//      kids: [22849043, 22848891, 22848977],
//      score: 45,
//      time: 1586695442,
//      title: "Technology-budgeting/handbook.md at master · 18F/technology-budgeting",
//      type: "story",
//      url: "https://github.com/18F/technology-budgeting/blob/master/handbook.md"),
//  Article(
//      by: "wallflower",
//      descendants: 0,
//      id: 22841857,
//      kids: [],
//      score: 29,
//      time: 1586615503,
//      title: "The New Science of Seeing Around Corners (2018)",
//      type: "story",
//      url: "https://www.quantamagazine.org/the-new-science-of-seeing-around-corners-20180830/"),
//  Article(
//      by: "pcr910303",
//      descendants: 1,
//      id: 22848450,
//      kids: [22849687],
//      score: 33,
//      time: 1586701681,
//      title: "So You Want to Be a (Compiler) Wizard",
//      type: "story",
//      url: "https://belkadan.com/blog/2016/05/So-You-Want-To-Be-A-Compiler-Wizard/"),
//  Article(
//      by: "chrnad",
//      descendants: 86,
//      id: 22847799,
//      kids: [
//        22848439,
//        22850030,
//        22848400,
//        22849044,
//        22848553,
//        22848043,
//        22848917,
//        22848489,
//        22848754,
//        22849701,
//        22848994,
//        22848733,
//        22848257,
//        22848291,
//        22848247,
//        22848207,
//        22849658,
//        22847953,
//        22848996,
//        22848278,
//        22848616
//      ],
//      score: 153,
//      time: 1586694615,
//      title: "Fastmail Labels Beta",
//      type: "story",
//      url: "https://beta.fastmail.com/help/receive/labels-beta.html"),
//  Article(
//      by: "Lind5",
//      descendants: 64,
//      id: 22841269,
//      kids: [
//        22847764,
//        22849056,
//        22850006,
//        22848382,
//        22848617,
//        22848105,
//        22848388,
//        22848355,
//        22848958,
//        22848169,
//        22848222
//      ],
//      score: 102,
//      time: 1586607605,
//      title: "Why It’s So Hard to Create New Processors",
//      type: "story",
//      url: "https://semiengineering.com/why-its-so-hard-to-create-new-processors/"),
//  Article(
//      by: "smoo",
//      descendants: 1,
//      id: 22839627,
//      kids: [22839663],
//      score: 8,
//      time: 1586579282,
//      title: "Show HN: Spatially aware group video calls from the browser",
//      type: "story",
//      url: "https://party.mookerj.ee"),
//  Article(
//      by: "nlolks",
//      descendants: 65,
//      id: 22848192,
//      kids: [
//        22848840,
//        22848372,
//        22848725,
//        22848341,
//        22848712,
//        22848330,
//        22848336,
//        22848420,
//        22848418,
//        22849762,
//        22849444
//      ],
//      score: 99,
//      time: 1586699032,
//      title: "Deprecating password authentication in GitHub API",
//      type: "story",
//      url: "https://developer.github.com/changes/2020-02-14-deprecating-password-auth/"),
//  Article(
//      by: "dgski",
//      descendants: 10,
//      id: 22843493,
//      kids: [22849284, 22849517, 22849954, 22849391, 22843529, 22846255],
//      score: 20,
//      time: 1586632492,
//      title: "Show HN: Storystreamer – Snap/Instagram Stories UI Inspired News Reader",
//      type: "story",
//      url: "https://storystreamer.live/"),
//  Article(
//      by: "Tomte",
//      descendants: 19,
//      id: 22832884,
//      kids: [22848778, 22848265, 22848560, 22848322, 22849612],
//      score: 93,
//      time: 1586526128,
//      title: "“Samsung Rising” goes deep on corruption, chaebols, and corporate chaos",
//      type: "story",
//      url: "https://www.theverge.com/2020/4/10/21216092/samsung-rising-book-interview-geoffrey-cain")
//];
