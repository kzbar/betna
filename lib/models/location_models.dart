

class City {
  String? name;
  String? id;
  City.fromMap(Map<String, dynamic> map) {
    this.name = map['name'] != null ? map['name'] : map['adi'];
    this.id =  map['id'].toString();
  }
  Map<String, dynamic> toMap() {
    return {'id': id, "name": name};
  }
}

class Town {
  String? name;
  String? id;
  Town.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.id = map['id'].toString();
  }
  Map<String, dynamic> toMap() {
    return {'name': name!.toUpperCase(), "id": id};
  }
}

class Neighborhood {
  String? name;
  String? id;
  Neighborhood.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.id = map['id'].toString();
  }
  Map<String, dynamic> toMap() {
    return {'name': name!.toUpperCase(), "id": id};
  }
}
