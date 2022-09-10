import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

final _URL_NEWS = 'newsapi.org';
final _API_KEY = '0bab698561774612a1e8ae0362b2dc22';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.memory, 'technology')
  ];

  Map<String, List<Article>> categoryArticles = {};

  bool _isLoading = true;

  NewsService() {
    getTopHeadlines();
    categories.forEach((element) {
      categoryArticles[element.name] = [];
    });
    getArticlesByCategory(_selectedCategory);
  }

  getTopHeadlines() async {
    final uri = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'country': 'us', 'apiKey': _API_KEY});
    final resp = await http.get(uri);

    final newsResponde = NewResponse.fromJson(resp.body);
    headlines.addAll(newsResponde.articles);
    notifyListeners();
  }

  String get selectedCategory {
    return _selectedCategory;
  }

  set selectedCategory(String category) {
    _selectedCategory = category;
    _isLoading = true;
    getArticlesByCategory(category);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final uri = Uri.https(_URL_NEWS, '/v2/top-headlines',
        {'country': 'us', 'category': category, 'apiKey': _API_KEY});
    final resp = await http.get(uri);

    final newsResponde = NewResponse.fromJson(resp.body);

    categoryArticles[category]?.addAll(newsResponde.articles);
    _isLoading = false;
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSelecciona =>
      categoryArticles[selectedCategory]!;

  bool get isLoading => this._isLoading;
}
