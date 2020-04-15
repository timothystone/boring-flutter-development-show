import 'package:flutter/material.dart';
import 'src/articles.dart';
import 'package:http/http.dart' as http;
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
//  List<Article> _articles = []; //articles;
  List<int> _storyIds = [
    22867627,
    22871331,
    22869909,
    22871180,
    22872301,
    22865357,
    22867960,
    22863491,
    22870105,
    22870905,
  ];

  Future<Article> _getArticle(int storyId) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$storyId.json';
    final storyResponse = await http.get(storyUrl);
    if(storyResponse.statusCode == 200) {
      return parseArticle(storyResponse.body);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _storyIds.map((id) =>
            FutureBuilder<Article>(
              future: _getArticle(id),
              builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return _buildItem(snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
        ).toList(),
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
