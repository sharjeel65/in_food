import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  late String id;
  late String name;
  late String description;
  late String address;
  late String phone;
  late String email;
  late String website;
  late String imageUrl;
  late String tagline;
  late List<MenuModel> menus;
  late List<Deals> deals;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.imageUrl,
    required this.tagline,
    required this.menus,
  });

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('name');
    description = snapshot.get('description');
    address = snapshot.get('address');
    phone = snapshot.get('phone');
    email = snapshot.get('email');
    website = snapshot.get('website');
    imageUrl = snapshot.get('imageUrl');
    tagline = snapshot.get('tagline');
    final menuList = snapshot.get('menus') as List<dynamic>;
    menus = menuList.map((menu) => MenuModel.fromMap(menu)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'imageUrl': imageUrl,
      'tagline': tagline,
      'menus': menus.map((menu) => menu.toMap()).toList(),
    };
  }
}

class Deals {
  late String name;
  late String description;
  late String imageUrl;
  late String restaurantId;
  late String dealId;
  late List<DealItems> items;

  Deals({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.restaurantId,
    required this.dealId,
  });

  Deals.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        restaurantId = map['restaurantId'],
        dealId = map['dealId'],
        imageUrl = map['imageUrl'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'restaurantId': restaurantId,
      'dealId': dealId,
      'imageUrl': imageUrl,
    };
  }
}

class DealItems {
  late String name;
  late String description;
  late int price;
  late String imageUrl;
  late String restaurantId;
  late String dealId;
  late String itemId;

  DealItems({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.restaurantId,
    required this.dealId,
    required this.itemId,
  });

  DealItems.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        price = map['price'],
        imageUrl = map['imageUrl'],
        restaurantId = map['restaurantId'],
        dealId = map['dealId'],
        itemId = map['itemId'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'restaurantId': restaurantId,
      'dealId': dealId,
      'itemId': itemId,
    };
  }
}

class MenuModel {
  late String name;
  late String description;
  late List<MenuItemModel> items;
  late String restaurantId;
  late String menuId;

  MenuModel({
    required this.name,
    required this.description,
    required this.items,
    required this.restaurantId,
    required this.menuId,
  });

  MenuModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        restaurantId = map['restaurantId'],
        menuId = map['menuId'],
        items = List<MenuItemModel>.from(
            map['items']?.map((x) => MenuItemModel.fromMap(x)));

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'restaurantId': restaurantId,
      'menuId': menuId,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}

class MenuItemModel {
  late String name;
  late String description;
  late int price;
  late String imageUrl;
  late String restaurantId;
  late String menuId;
  late String itemId;

  MenuItemModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.restaurantId,
    required this.menuId,
    required this.itemId,
  });

  MenuItemModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        price = map['price'],
        restaurantId = map['restaurantId'],
        menuId = map['menuId'],
        itemId = map['itemId'],
        imageUrl = map['imageUrl'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'restaurantId': restaurantId,
      'menuId': menuId,
      'itemId': itemId,
    };
  }
}
