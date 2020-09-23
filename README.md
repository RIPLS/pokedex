# Pokeapp

This is an assigment Flutter project, developed by `Luis Suárez` for Zipdev.
Show pokemons charactheristics It's the main function of this app. All showed data it's requested from pokeapi.co

## Getting Started

### Installation
1. As first step you should clone the PokeApp's github repository in your local directory.

- [GitHub: PokeApp repository](https://github.com/RIPLS/pokedex.git)

2. Open the cloned directory with your Code editor.
2. Get dependencies. You need to type in the terminal:

```bash
flutter packages get
```
4. Run emulator.
4. Finally, run the app. 

## Using the App 

The app is composed by four screens
* Welcome
* Login
* Pokemon list
* Pokemon Detail

1. The first page it's just a welcome page, thinked to showing an introduction of the app.
1. The next page it's the Login page. To login you can enter any user and password, as long as it meets the requested requirements.
1. When you pass the login screen the app will show you a list of 20 pokemons, sorted by ID.
1. If you want to continue to the next 20, you need to push the "next page" icon button.
1. In case you find the listed element with your favorite pokemon, just need to Tap it.
1. A screen with detail information and stats will pop.

## Plugins Implementation

In order to accomplish the functionallity of PokeApp, It was neccesary the integration of the dependencies showed bellow:

| Plugin | Summary |
| ------ | ------ |
| [Provider](https://pub.dev/packages/provider) | Package implemented to handle App states |
| [HTTP](https://pub.dev/packages/http) | Needed to make all data request to the third party API |
| [Sqflite](https://pub.dev/packages/sqflite) | Implemented in order to execute a local SQL database (for users login) |
| [Path_provider](https://pub.dev/packages/path_provider) | Package required for finding database location on the filesystem |


