# Pokeapp

This is a Flutter project assigment, developed by `Luis Suarez` whose main funtion is to show pokemons charactheristics. The data shown is requested from pokeapi.co

## Getting Started

### Installation
1. The first step is to clone the PokeApp's github repository into your local directory.

- [GitHub: PokeApp repository](https://github.com/RIPLS/pokedex.git)

2. Open the cloned directory with your Code editor.
2. To get dependencies you need to type in the terminal:

```bash
flutter packages get
```
4. Run emulator.
4. Finally, run the app. 

## Using the App 

The app comprises four screens
* Welcome
* Login
* Pokemon list
* Pokemon Detail


1. The first is a welcome page, designed to show an introduction of the App.
1. The next one is the Login page. To login you can enter any user and password, as long as it meets the requested requirements.
1. After login the app will show a list of twenty pokemons, sorted by ID.
1. Press the "Next page" icon button if you want to continue to the next twenty pokemons page.
1. Pick up your favorite pokemon from the list.
1. A screen with detailed information and statistics will pop up.

## Plugins Implementation

In order to accomplish the functionallity of the PokeApp, It was neccesary the integration of the dependencies shown bellow:

| Plugin | Summary |
| ------ | ------ |
| [Provider](https://pub.dev/packages/provider) | Package implemented to handle App states |
| [HTTP](https://pub.dev/packages/http) | Needed to make all data request to the third party API |
| [Sqflite](https://pub.dev/packages/sqflite) | Implemented in order to execute a local SQL database (for user's login) |
| [Path_provider](https://pub.dev/packages/path_provider) | Package required for finding database location on the filesystem |


