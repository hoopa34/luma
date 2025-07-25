part of 'buyer_account_bloc.dart';

sealed class BuyerAccountState extends Equatable {
  const BuyerAccountState();

  @override
  List<Object> get props => [];
}

final class BuyerAccountInitial extends BuyerAccountState {
  const BuyerAccountInitial();
}

class BuyerAccountLoaded extends BuyerAccountState {
  final int number;
  final Gender gender;

  final String? name;
  final AssetImage? avatar;
  final String? email;
  final DateTime? birthdate;

  final List<String>? creditCard;
  final List<String>? addresses;

  final List<ObjectItem> historyOrders;
  final List<ObjectItem> actualOrders;

  final List<ObjectShop> shopSubscriptions;
  final List<ObjectNotification> notifications;

  final bool isSeller;
  final List<ObjectShop> shopOwner;

  const BuyerAccountLoaded({
    required this.number,
    required this.gender,
    required this.isSeller,

    this.addresses,
    this.avatar,
    this.creditCard,
    this.email,
    this.birthdate,
    this.historyOrders = const [],
    required this.actualOrders,
    this.name,
    this.notifications = const [],
    this.shopSubscriptions = const [],
    this.shopOwner = const [],
  });

  BuyerAccountLoaded copyWith({
    int? number,
    Gender? gender,

    String? name,
    AssetImage? avatar,
    String? email,
    DateTime? birthdate,

    List<String>? creditCard,
    List<String>? addresses,

    List<ObjectItem>? historyOrders,
    List<ObjectItem>? actualOrders,

    List<ObjectShop>? shopSubscriptions,
    List<ObjectNotification>? notifications,

    bool? isSeller,
    List<ObjectShop>? shopOwner,
  }) {
    return BuyerAccountLoaded(
      number: number ?? this.number,
      gender: gender ?? this.gender,

      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,

      creditCard: creditCard ?? this.creditCard,
      addresses: addresses ?? this.addresses,

      historyOrders: historyOrders ?? this.historyOrders,
      actualOrders: actualOrders ?? this.actualOrders,

      shopSubscriptions: shopSubscriptions ?? this.shopSubscriptions,
      notifications: notifications ?? this.notifications,

      isSeller: isSeller ?? this.isSeller,
      shopOwner: shopOwner ?? this.shopOwner,
    );
  }

  @override
  List<Object> get props => [
    number,
    gender,
    isSeller,
    historyOrders,
    shopSubscriptions,
    notifications,
    shopOwner,
    actualOrders
  ];

  int actualOrdersItemAmount(ObjectItem item) {
    int amount = 0;

    for (ObjectItem element in actualOrders) {
      if (element == item) amount++;
    }

    return amount;
  }

  double actualOrdersTotalPrice() {
    double price = 0;

    for (ObjectItem element in actualOrders) {
      price += element.price;
    }

    return price;
  }
}
