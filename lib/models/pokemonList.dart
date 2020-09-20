class PokeListModel {
  String name;
  String url;

  PokeListModel();

  PokeListModel.map(dynamic obj) {
    this.name = obj['name'];
    this.url = obj['url'];
  }
}
