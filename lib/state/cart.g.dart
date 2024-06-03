// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  Computed<int>? _$totalItemsComputed;

  @override
  int get totalItems => (_$totalItemsComputed ??=
          Computed<int>(() => super.totalItems, name: '_CartStore.totalItems'))
      .value;
  Computed<double>? _$subTotalPriceComputed;

  @override
  double get subTotalPrice =>
      (_$subTotalPriceComputed ??= Computed<double>(() => super.subTotalPrice,
              name: '_CartStore.subTotalPrice'))
          .value;
  Computed<double>? _$totalCartPriceComputed;

  @override
  double get totalCartPrice =>
      (_$totalCartPriceComputed ??= Computed<double>(() => super.totalCartPrice,
              name: '_CartStore.totalCartPrice'))
          .value;

  late final _$cartItemsAtom =
      Atom(name: '_CartStore.cartItems', context: context);

  @override
  ObservableMap<int, CartItem> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(ObservableMap<int, CartItem> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$_CartStoreActionController =
      ActionController(name: '_CartStore', context: context);

  @override
  void addItem(CartItem item) {
    final _$actionInfo =
        _$_CartStoreActionController.startAction(name: '_CartStore.addItem');
    try {
      return super.addItem(item);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementItem(int id) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.incrementItem');
    try {
      return super.incrementItem(id);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementItem(int id) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.decrementItem');
    try {
      return super.decrementItem(id);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteItem(int id) {
    final _$actionInfo =
        _$_CartStoreActionController.startAction(name: '_CartStore.deleteItem');
    try {
      return super.deleteItem(id);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo =
        _$_CartStoreActionController.startAction(name: '_CartStore.clearCart');
    try {
      return super.clearCart();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartItems: ${cartItems},
totalItems: ${totalItems},
subTotalPrice: ${subTotalPrice},
totalCartPrice: ${totalCartPrice}
    ''';
  }
}
