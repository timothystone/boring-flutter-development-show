import 'dart:collection';

import 'package:boring_flutter_dev/src/articles.dart';
import 'package:boring_flutter_dev/src/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  final newsBloc = NewsBloc();
  runApp(MyApp(
    newsBloc: newsBloc,
  ));
}

class MyApp extends StatelessWidget {
  final NewsBloc newsBloc;

  MyApp({Key key, this.newsBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(
        title: 'Boring Hacker News',
        newsBloc: newsBloc,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final NewsBloc newsBloc;

  MyHomePage({Key key, this.title, this.newsBloc}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: LoadingInfo(widget.newsBloc.isLoading),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: widget.newsBloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context, snapshot) => ListView(
          children: snapshot.data.map(_buildItem).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(title: Text("Top Stories"), icon: Icon(Icons.arrow_upward)),
            BottomNavigationBarItem(title: Text("New Stories"), icon: Icon(Icons.new_releases)),
          ],
          onTap: (index) {
            if (index == 0) {
              widget.newsBloc.storiesType.add(StoriesType.topStories);
            } else {
              widget.newsBloc.storiesType.add(StoriesType.newStories);
            }
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.url),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(article.title, style: new TextStyle(fontSize: 24.0)),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${article.descendants} comments'),
              IconButton(
                icon: Icon(Icons.launch, semanticLabel: "Open"),
                onPressed: () async {
                  if (await canLaunch(article.url)) {
                    await launch(article.url);
                  } else {
                    throw "Could not launch ${article.url}";
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class LoadingInfo extends StatefulWidget {
  final Stream<bool> _isLoading;

  LoadingInfo(this._isLoading);

  @override
  createState() => LoadingInfoState();
}

class LoadingInfoState extends State<LoadingInfo> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget._isLoading,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          _controller.forward().then((future) => _controller.reverse());
          if (snapshot.hasData && snapshot.data) {
            return FadeTransition(
              child: Icon(FontAwesomeIcons.hackerNewsSquare),
              opacity: Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller)),
            );
          }
          return Container();
        });
  }
}
