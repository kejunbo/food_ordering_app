class Order {
  num id;
  num timestamp;
  num totalPrice;
  String address;
  String type;
  int paymentMade;
  num customerId;
  num restaurantId;

  Order(
      {this.id,
      this.timestamp,
      this.totalPrice,
      this.address,
      this.type,
      this.paymentMade,
      this.customerId,
      this.restaurantId,
      });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = json['timestamp'];
    totalPrice = json['total_price'];
    address = json['address'];
    type = json['type'];
    paymentMade = json['payment_made'];
    customerId = json['customer_id'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timestamp'] = this.timestamp;
    data['total_price'] = this.totalPrice;
    data['address'] = this.address;
    data['type'] = this.type;
    data['payment_made'] = this.paymentMade;
    data['customer_id'] = this.customerId;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}
