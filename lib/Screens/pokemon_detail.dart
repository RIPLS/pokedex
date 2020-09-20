import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokemonInfo.dart';
import 'package:provider/provider.dart';

import '../providers/pokeProvider.dart';

import '../models/pokemonList.dart';

class PokemonDetail extends StatefulWidget {
  final PokeListModel data;
  const PokemonDetail({Key key, @required this.data}) : super(key: key);

  static const routeName = '/pokemon_detail';

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Future<void> _getPokemonbyID(BuildContext context, String _url) async {
    await Provider.of<PokeProvider>(context, listen: false)
        .getPokemonById(_url);
  }

  @override
  Widget build(BuildContext context) {
    final PokeListModel _data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_data.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _getPokemonbyID(context, _data.url),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Container(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Consumer<PokeProvider>(
                      builder: (ctx, _loadedInfo, _) =>
                          PokemonInfo(data: _loadedInfo.pokedata),
                    ),
        ),
      ),
    );
  }
}
