class Room {
  Room(
      {this.id,
      this.photos,
      this.title,
      this.price,
      this.bed,
      this.person,
      this.facilities,
      this.description,
      this.roomNumber});

  int? id;
  String? title, description;
  List<String>? photos;
  int? person, bed, roomNumber;
  double? price;
  List<Facility>? facilities = [];

  Room.fromJson(Map<String, dynamic> json) {
    // if (json['photos'] is String) {
    //   log("=====> ISSUE ${json['id']}");
    // } else {
    //   log("=====> OK ${json['id']}");
    // }3
    id = json['id'];
    title = json['title'];
    description = json['description'];
    photos = json['photos'] is String
        ? []
        : json['photos'] != null
            ? List<String>.from(json['photos'].map((x) => x))
            : null;
    person = json['total_person'];
    bed = json['beds'];
    price = double.parse(json['price'].toString());
    roomNumber =
        json['number'] == null ? null : int.parse(json['number'].toString());
    facilities = json['facilities'] != null
        ? List<Facility>.from(
            json['facilities'].map((x) => Facility.fromJson(x)))
        : null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'photos': photos,
        'total_person': person,
        'bed': bed,
        'price': price,
        'number': roomNumber,
        'facilities': facilities != null
            ? List<Facility>.from(facilities!.map((x) => x.toJson()))
            : null,
      };
}

class Facility {
  Facility({this.name, this.price, this.image});

  String? name, image;
  double? price;

  Facility.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = double.parse(json['price'].toString());
    image = json['image'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'image': image,
      };
}
