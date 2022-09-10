import 'package:flutter/material.dart';
import 'package:noticiasapp/pages/tab1_page.dart';
import 'package:noticiasapp/pages/tab2_page.dart';
import 'package:noticiasapp/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NavegacionModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final providerNavegationModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: providerNavegationModel.paginaActual,
      onTap: (value) => providerNavegationModel.paginaActual = value,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados')
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas();

  @override
  Widget build(BuildContext context) {
    final providerNavegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: providerNavegacionModel.pageControler,
      //physics: const BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = PageController();

  int get paginaActual {
    return _paginaActual;
  }

  set paginaActual(int page) {
    _paginaActual = page;
    _pageController.animateToPage(page,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageControler {
    return _pageController;
  }
}
