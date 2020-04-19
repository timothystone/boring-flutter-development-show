import 'dart:collection';

import 'package:boring_flutter_dev/src/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:boring_flutter_dev/src/articles.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: widget.newsBloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context, snapshot) => ListView(
          children: snapshot.data.map(_buildItem).toList(),
        ),
      ),
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
