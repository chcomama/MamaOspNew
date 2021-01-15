import 'dart:convert';

class ProductModel {
  final String id;
  final String uidshop;
  final String name;
  final String detail;
  final String price;
  final String urlproduct;
  ProductModel({
    this.id,
    this.uidshop,
    this.name,
    this.detail,
    this.price,
    this.urlproduct,
  });

  ProductModel copyWith({
    String id,
    String uidshop,
    String name,
    String detail,
    String price,
    String urlproduct,
  }) {
    return ProductModel(
      id: id ?? this.id,
      uidshop: uidshop ?? this.uidshop,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      price: price ?? this.price,
      urlproduct: urlproduct ?? this.urlproduct,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uidshop': uidshop,
      'name': name,
      'detail': detail,
      'price': price,
      'urlproduct': urlproduct,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProductModel(
      id: map['id'],
      uidshop: map['uidshop'],
      name: map['name'],
      detail: map['detail'],
      price: map['price'],
      urlproduct: map['urlproduct'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, uidshop: $uidshop, name: $name, detail: $detail, price: $price, urlproduct: $urlproduct)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProductModel &&
      o.id == id &&
      o.uidshop == uidshop &&
      o.name == name &&
      o.detail == detail &&
      o.price == price &&
      o.urlproduct == urlproduct;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uidshop.hashCode ^
      name.hashCode ^
      detail.hashCode ^
      price.hashCode ^
      urlproduct.hashCode;
  }
}
