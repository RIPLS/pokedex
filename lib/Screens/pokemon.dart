import 'package:flutter/material.dart';
import 'package:pokeapp/Screens/pokemon_detail.dart';
import 'package:provider/provider.dart';

import '../providers/pokeProvider.dart';

import '../widgets/listelement.dart';
import '../widgets/bottombar.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({Key key}) : super(key: key);

  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  Future<void> _getAllPokemons(BuildContext context) async {
    await Provider.of<PokeProvider>(context, listen: false).getAllPokemons();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _pokeDetails(Object _argument) {
      Navigator.of(context).pushNamed(
        PokemonDetail.routeName,
        arguments: _argument,
      );
    }

    void _changePage() {
      setState(() {});
    }

    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: Container(
              margin: const EdgeInsets.all(5),
              child: Image.asset('assets/images/pokeball.png'),
            ),
            title: Text(
              'Pokemon List',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          FutureBuilder(
            future: _getAllPokemons(context),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Consumer<PokeProvider>(
                    builder: (ctx, _loadedInfo, _) => Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _loadedInfo.pokelist.length,
                        itemBuilder: (context, index) {
                          int _pokeNumber = index +
                              _loadedInfo.listOffset * (_loadedInfo.page - 1) +
                              1;
                          return ListElement(
                            _pokeNumber,
                            _loadedInfo.pokelist[index].name,
                            () => _pokeDetails(_loadedInfo.pokelist[index]),
                          );
                        },
                      ),
                    ),
                  ),
          ),
          Divider(
            thickness: 2,
          ),
          BottomBar(function: _changePage),
        ],
      ),
    );
  }
}
