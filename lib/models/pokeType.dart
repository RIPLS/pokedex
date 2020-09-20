class PokeType {
  int slot;
  dynamic type;

  PokeType();

  PokeType.map(dynamic obj) {
    this.slot = obj['slot'];
    this.type = obj['type'];
  }
}
