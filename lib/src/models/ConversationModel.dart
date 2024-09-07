class ConversationModel {
  String _name;
  String _message;
  String _pathPhoto;

  ConversationModel(this._name, this._message, this._pathPhoto);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get pathPhoto => _pathPhoto;

  set pathPhoto(String value) {
    _pathPhoto = value;
  }
}