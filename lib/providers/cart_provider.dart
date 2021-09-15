import 'package:flutter/cupertino.dart';
import 'package:kampoeng_roti/models/cart_model.dart';
import 'package:kampoeng_roti/services/cart_service.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  Future<void> getCart({
    int userId,
  }) async {
    try {
      List<CartModel> carts = await CartService().getCart(userId: userId);
      _carts = carts;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addCart({
    int userId,
    int productId,
    int quantity,
  }) async {
    try {
      await CartService().addCart(
        userId: userId,
        prodId: productId,
        quantity: quantity,
      );
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editCart({
    int cartId,
    int quantity,
    String notes,
  }) async {
    try {
      await CartService().editCart(
        cartId: cartId,
        quantity: quantity,
        notes: notes,
      );
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteCart({
    int cartId,
  }) async {
    try {
      await CartService()
          .deleteCart(
        cartId: cartId,
      )
          .then((_) {
        notifyListeners();
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // addCart(ProductModel product, int quantity) {
  //   if (productExis(product)) {
  //     int index =
  //         _carts.indexWhere((elements) => elements.product.id == product.id);
  //     _carts[index].quantity += quantity;
  //   } else {
  //     _carts.add(CartModel(
  //       id: _carts.length,
  //       product: product,
  //       quantity: quantity,
  //     ));
  //   }

  //   notifyListeners();
  // }

  // removeCart(int id) {
  //   _carts.removeAt(id);
  //   notifyListeners();
  // }

  addQuantity(int id) {
    int index = _carts.indexWhere((elements) => elements.id == id);
    _carts[index].quantity++;
    editCart(
      cartId: _carts[index].id,
      quantity: _carts[index].quantity,
    );
    notifyListeners();
  }

  addNotes(int id, String notes) {
    int index = _carts.indexWhere((elements) => elements.id == id);
    // _carts[index].quantity++;
    editCart(
      cartId: _carts[index].id,
      // quantity: _carts[index].quantity,
      notes: notes,
    );
    notifyListeners();
  }

  reduceQuantity(int id) {
    int index = _carts.indexWhere((elements) => elements.id == id);
    if (_carts[index].quantity > 0) {
      _carts[index].quantity--;
      editCart(
        cartId: _carts[index].id,
        quantity: _carts[index].quantity,
      );
    }
    notifyListeners();
  }

  totalItem() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += (item.quantity * item.prodPrice);
    }

    return total;
  }

  totalCart() {
    return _carts.length;
  }

  // productExis(ProductModel product) {
  //   if (_carts.indexWhere((elements) => elements.product.id == product.id) ==
  //       -1) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
