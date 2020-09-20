import 'package:flutter/material.dart';
import 'package:pokedex/utils/typeColors.dart';

import '../models/pokeType.dart';
import '../models/pokeStats.dart';
import '../models/pokemon.dart';

class PokemonInfo extends StatelessWidget {
  final dynamic data;
  const PokemonInfo({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    PokeModel _pokeinfo = this.data;
    List<PokeStat> _pokeStat = _pokeinfo.stats;
    List<PokeType> _pokeType = _pokeinfo.types;

    Widget _basicInfo(String name, String value) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text("$name: ", style: Theme.of(context).textTheme.headline2),
            Text(" $value", style: Theme.of(context).textTheme.headline3),
          ],
        ),
      );
    }

    Widget _statsInfo(String name, String value) {
      return Chip(
        backgroundColor: Colors.blueGrey[100],
        padding: const EdgeInsets.all(6),
        labelPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        avatar: CircleAvatar(
          backgroundColor: Colors.blueGrey[700],
          child: Text(
            value,
            style: Theme.of(context).textTheme.button,
          ),
        ),
        label: Text(name),
      );
    }

    return Container(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            elevation: 10,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: _size.width / 2.5,
                      child: _pokeinfo.sprites['front_default'] != null
                          ? Image.network(
                              _pokeinfo.sprites['front_default'],
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 200,
                              child: Icon(
                                Icons.block,
                                size: 50,
                              ),
                            ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: _size.width / 2,
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _pokeinfo.name.toUpperCase(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            _basicInfo('ID', _pokeinfo.id.toString()),
                            _basicInfo('Weight', _pokeinfo.weight.toString()),
                            _basicInfo('Height', _pokeinfo.height.toString()),
                            _basicInfo('Type', ''),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _pokeType
                                    .map(
                                      (data) => Text(
                                        data.type["name"].toUpperCase(),
                                        style: TextStyle(
                                          color: typecolor(
                                            data.type["name"],
                                          ),
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            elevation: 10,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 15),
                  alignment: Alignment.topLeft,
                  child: Text("Pokemon Stats:",
                      style: Theme.of(context).textTheme.headline2),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Wrap(
                    spacing: 10,
                    children: _pokeStat
                        .map(
                          (data) => _statsInfo(
                            data.stat["name"].toUpperCase(),
                            data.baseStat.toString(),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
