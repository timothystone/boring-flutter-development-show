import 'package:flutter/material.dart';
import 'src/articles.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.insert(_articles.length, _articles.first);
            _articles.removeAt(0);
          });
        },
        child: ListView(
          children: _articles.map(_buildItem).toList(),
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
                  final url = article.url;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw "Could not launch $url";
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
