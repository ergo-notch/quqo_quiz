class Model {
  String id;

  Model();

  factory Model.fromJson(Map<String, dynamic> json) {
    var model = new Model();
    return model;
  }

  Map<String, dynamic> toApiParams() {
    return {};
  }
}
