import 'package:food_buddy/constants/api_constants.dart';
import 'package:mobx/mobx.dart';
import '../models/cart_item.dart';

part 'cart.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  ObservableMap<int, CartItem> cartItems = ObservableMap<int, CartItem>();

  @action
  void addItem(CartItem item) {
    if (cartItems.containsKey(item.id)) {
      cartItems[item.id] = cartItems[item.id]!.copyWith(
        selectedQty: cartItems[item.id]!.selectedQty + 1,
      );
    } else {
      cartItems[item.id] = item.copyWith(selectedQty: 1);
    }
  }

  @action
  void incrementItem(int id) {
    if (cartItems.containsKey(id)) {
      cartItems[id] = cartItems[id]!.copyWith(
        selectedQty: cartItems[id]!.selectedQty + 1,
      );
    }
  }

  @action
  void decrementItem(int id) {
    if (cartItems.containsKey(id) && cartItems[id]!.selectedQty > 1) {
      cartItems[id] = cartItems[id]!.copyWith(
        selectedQty: cartItems[id]!.selectedQty - 1,
      );
    } else {
      cartItems.remove(id);
    }
  }

  @action
  void deleteItem(int id) {
    cartItems.remove(id);
  }

  @action
  void clearCart() {
    cartItems.clear();
  }

  @computed
  int get totalItems => cartItems.values.fold(0, (sum, item) => sum + item.selectedQty);

  @computed
  double get subTotalPrice => cartItems.values.fold(0, (sum, item) => sum + (item.price * item.selectedQty));

  @computed
  double get totalCartPrice => subTotalPrice + (subTotalPrice * tax);
}
