import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/news_models.dart';

final _URL_NEWS = 'newsapi.org';
final _API_KEY = '0bab698561774612a1e8ae0362b2dc22';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    final uri = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'country': 'us', 'apiKey': _API_KEY});
    final resp = await http.get(uri);

    final newsResponde = NewResponse.fromJson(resp.body);
    headlines.addAll(newsResponde.articles);
    notifyListeners();
  }
}
