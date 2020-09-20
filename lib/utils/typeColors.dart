import 'package:flutter/material.dart';

Color typecolor(String _pokemonType) {
  switch (_pokemonType) {
    case "fighting":
      return Colors.brown[200];
      break;
    case "flying":
      return Colors.teal;
      break;
    case "poison":
      return Colors.purple;
      break;
    case "ground":
      return Colors.brown[400];
      break;
    case "rock":
      return Colors.brown;
      break;
    case "bug":
      return Colors.lightGreen;
      break;
    case "ghost":
      return Colors.blueGrey;
      break;
    case "steel":
      return Colors.grey[700];
      break;
    case "fire":
      return Colors.red;
      break;
    case "water":
      return Colors.blue[900];
      break;
    case "grass":
      return Colors.green;
      break;
    case "electric":
      return Colors.yellow[700];
      break;
    case "psychic":
      return Colors.deepPurple;
      break;
    case "ice":
      return Colors.cyan[200];
      break;
    case "dragon":
      return Colors.amber[800];
      break;
    case "dark":
      return Colors.brown[900];
      break;
    case "fairy":
      return Colors.pink[300];
      break;
    case "unknown":
      return Colors.black;
      break;
    case "shadow":
      return Colors.black38;
      break;
    default:
      return Colors.black;
  }
}
