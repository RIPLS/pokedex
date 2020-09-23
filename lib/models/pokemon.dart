import './pokeType.dart';
import './pokeStats.dart';

class PokeModel {
  int id;
  String name;
  int height; //decimeters
  int weight; //hectogramos
  dynamic sprites;
  List<dynamic> types;
  List<dynamic> stats;

  PokeModel();

  PokeModel.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.height = obj['height'];
    this.weight = obj['weight'];
    this.sprites = obj['sprites'];

    if (obj['types'] != null) {
      List<dynamic> listTypes = obj['types'];
      this.types = listTypes.map((entry) => PokeType.map(entry)).toList();
    }
    if (obj['stats'] != null) {
      List<dynamic> listStats = obj['stats'];
      this.stats = listStats.map((entry) => PokeStat.map(entry)).toList();
    }
  }
}
