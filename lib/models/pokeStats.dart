class PokeStat {
  dynamic stat;
  int effort;
  int baseStat;

  PokeStat();

  PokeStat.map(dynamic obj) {
    this.stat = obj['stat'];
    this.effort = obj['effort'];
    this.baseStat = obj['base_stat'];
  }
}
