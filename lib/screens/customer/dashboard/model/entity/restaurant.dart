class Restaurant {
  String name;
  num id;
  String description;
  String address;
  String imageUrl;

  Restaurant({this.name, this.id, this.description, this.address, this.imageUrl});

  Restaurant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    description = json['description'];
    address = json['address'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['description'] = this.description;
    data['address'] = this.address;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}