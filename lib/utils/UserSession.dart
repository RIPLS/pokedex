class UserSession {
  String _username;
  String _token;
  UserSession(this._username, this._token);

  UserSession.map(dynamic obj) {
    this._username = obj["username"];
    this._token = obj["token"];
  }

  String get username => _username;
  String get token => _token;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["token"] = _token;

    return map;
  }
}
