import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapp/utils/network_util.dart';
import 'package:pokeapp/providers/pokeProvider.dart';

class MockClient extends Mock implements http.Client {}

class MockNetworkUtil extends Mock implements NetworkUtil {}

void main() {
  group('Network Util Unit Test', () {
    test('Get Success', () async {
      final client = MockClient();
      final networkUtil = new NetworkUtil(client);

      Map<String, String> headers = {};
      headers[HttpHeaders.contentTypeHeader] =
          'application/json; charset=utf-8';

      when(client.get('https://test.com/', headers: headers))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      var result = await networkUtil.get('https://test.com/');
      expect(result['title'], equals("Test"));
    });

    test('Get throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      final networkUtil = new NetworkUtil(client);

      Map<String, String> headers = {};
      headers[HttpHeaders.contentTypeHeader] =
          'application/json; charset=utf-8';

      when(client.get('https://test.com/', headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(networkUtil.get('https://test.com/'), throwsException);
    });
  });

  group('Poke Provider Unit Test', () {
    test('GetAllPokemons Success Call', () async {
      final networkUtil = MockNetworkUtil();
      final pokeProvider = new PokeProvider(networkUtil: networkUtil);

      when(networkUtil
              .get('https://pokeapi.co/api/v2/pokemon/?limit=20&offset=0'))
          .thenAnswer((_) async => {
                "count": 1050,
                "next": "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
                "previous": null,
                "results": [
                  {
                    "name": "bulbasaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/1/"
                  },
                  {
                    "name": "ivysaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/2/"
                  },
                  {
                    "name": "venusaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/3/"
                  },
                  {
                    "name": "charmander",
                    "url": "https://pokeapi.co/api/v2/pokemon/4/"
                  },
                  {
                    "name": "charmeleon",
                    "url": "https://pokeapi.co/api/v2/pokemon/5/"
                  },
                  {
                    "name": "charizard",
                    "url": "https://pokeapi.co/api/v2/pokemon/6/"
                  },
                  {
                    "name": "squirtle",
                    "url": "https://pokeapi.co/api/v2/pokemon/7/"
                  },
                  {
                    "name": "wartortle",
                    "url": "https://pokeapi.co/api/v2/pokemon/8/"
                  },
                  {
                    "name": "blastoise",
                    "url": "https://pokeapi.co/api/v2/pokemon/9/"
                  },
                  {
                    "name": "caterpie",
                    "url": "https://pokeapi.co/api/v2/pokemon/10/"
                  },
                  {
                    "name": "metapod",
                    "url": "https://pokeapi.co/api/v2/pokemon/11/"
                  },
                  {
                    "name": "butterfree",
                    "url": "https://pokeapi.co/api/v2/pokemon/12/"
                  },
                  {
                    "name": "weedle",
                    "url": "https://pokeapi.co/api/v2/pokemon/13/"
                  },
                  {
                    "name": "kakuna",
                    "url": "https://pokeapi.co/api/v2/pokemon/14/"
                  },
                  {
                    "name": "beedrill",
                    "url": "https://pokeapi.co/api/v2/pokemon/15/"
                  },
                  {
                    "name": "pidgey",
                    "url": "https://pokeapi.co/api/v2/pokemon/16/"
                  },
                  {
                    "name": "pidgeotto",
                    "url": "https://pokeapi.co/api/v2/pokemon/17/"
                  },
                  {
                    "name": "pidgeot",
                    "url": "https://pokeapi.co/api/v2/pokemon/18/"
                  },
                  {
                    "name": "rattata",
                    "url": "https://pokeapi.co/api/v2/pokemon/19/"
                  },
                  {
                    "name": "raticate",
                    "url": "https://pokeapi.co/api/v2/pokemon/20/"
                  }
                ]
              });

      await pokeProvider.getAllPokemons();
      expect(pokeProvider.pokelist.length, equals(20));
      expect(pokeProvider.pokelist[0].name, equals("bulbasaur"));
    });

    test('GetAllPokemons throws an exception', () async {
      final networkUtil = MockNetworkUtil();
      final pokeProvider = new PokeProvider(networkUtil: networkUtil);

      when(networkUtil
              .get('https://pokeapi.co/api/v2/pokemon/?limit=20&offset=0'))
          .thenAnswer((_) async => throw new Exception("Mocked Exception"));

      expect(pokeProvider.getAllPokemons(), throwsException);
    });
  });
}
