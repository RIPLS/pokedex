import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:pokeapp/models/pokemonList.dart';

import '../utils/network_util.dart';

import '../models/pokemonList.dart';
import '../models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokeProvider with ChangeNotifier {
  NetworkUtil _netUtil;
  final url = 'pokeapi.co';
  List<PokeListModel> pokelist;
  int quantity;
  int page = 1;
  int totalpage;
  int listOffset = 20;
  PokeModel pokedata;

  PokeProvider({NetworkUtil networkUtil}) {
    if (networkUtil != null) {
      _netUtil = networkUtil;
    } else {
      _netUtil = new NetworkUtil(new http.Client());
    }
  }

  Future<void> getAllPokemons() async {
    int limit = (page - 1) * listOffset;
    try {
      var queryParameters = {
        'limit': listOffset.toString(),
        'offset': limit.toString(),
      };
      var uri = Uri.https(url, "/api/v2/pokemon/", queryParameters);
      final response = await _netUtil.get(uri.toString());
      List<dynamic> respList = response["results"];
      quantity = response["count"];
      totalpage = (quantity / listOffset).ceil();
      pokelist = respList.map((entry) => PokeListModel.map(entry)).toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getPokemonById(String url) async {
    try {
      final response = await _netUtil.get(url);
      pokedata = PokeModel.map(response);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void nextPage() {
    page++;
    notifyListeners();
  }

  void previousPage() {
    page--;
    notifyListeners();
  }

  void lastPage() {
    page = totalpage;
    notifyListeners();
  }
}
