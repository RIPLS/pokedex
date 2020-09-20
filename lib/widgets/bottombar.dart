import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pokeProvider.dart';

class BottomBar extends StatelessWidget {
  final Function function;
  const BottomBar({Key key, @required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _pokemonData = Provider.of<PokeProvider>(context);
    int _page = _pokemonData.page;
    int _totalPage = _pokemonData.totalpage;
    int _offset = _pokemonData.listOffset;
    String _amount = _pokemonData.quantity?.toString() ?? '-';

    String _elements = (_offset * (_page - 1) + 1).toString();
    String _elementsF;

    if (_page == _totalPage) {
      int _calc = (_offset * _page);
      _elementsF = _calc > _totalPage ? _amount.toString() : _calc.toString();
    } else {
      _elementsF = (_offset * _page).toString();
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 85,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: _page > 1
                  ? () {
                      _pokemonData.previousPage();
                      function();
                    }
                  : null,
            ),
            Text('${_page.toString()} / ${_totalPage?.toString() ?? '-'}'),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onPressed: _page != _totalPage
                  ? () {
                      _pokemonData.nextPage();
                      function();
                    }
                  : null,
            ),
            Text(
              _elements + ' - ' + _elementsF + ' of ' + _amount,
            ),
            IconButton(
              icon: Icon(
                Icons.last_page,
                size: 30,
              ),
              onPressed: () {
                _pokemonData.lastPage();
                function();
              },
            ),
          ],
        ),
      ),
    );
  }
}
