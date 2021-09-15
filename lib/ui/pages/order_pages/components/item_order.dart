import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/cart_model.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class ItemOrder extends StatefulWidget {
  const ItemOrder({
    Key key,
    this.cart,
  }) : super(key: key);
  final CartModel cart;

  @override
  _ItemOrderState createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  TextEditingController notesController;
  CartProvider cartProvider;
  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');
    cartProvider = Provider.of<CartProvider>(context);
    notesController = TextEditingController(text: widget.cart.notes);
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.cart.prodUrlPhoto,
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.cart.prodTitle,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Rp. ${currencyFormatter.format(widget.cart.prodPrice * widget.cart.quantity)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: softOrangeColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Rp. ${currencyFormatter.format(widget.cart.prodPrice)} / biji",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: softOrangeColor,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // CartCounterShop(),
                          Container(
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.remove,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // if (numbOfText > 1) {
                                    //   setState(() {
                                    //     numbOfText--;
                                    //   });
                                    // }
                                    cartProvider.reduceQuantity(widget.cart.id);
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    widget.cart.quantity
                                        .toString()
                                        .padLeft(2, "0"),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // setState(() {
                                    //   numbOfText++;
                                    // });
                                    cartProvider.addQuantity(widget.cart.id);
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _showDialog(cartProvider);
                                  },
                                  child: ImageIcon(
                                    AssetImage(
                                      "assets/images/icon_writing.png",
                                    ),
                                    color: Colors.grey[600],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // cartProvider.removeCart(cart.id);
                                    cartProvider.deleteCart(
                                        cartId: widget.cart.id);
                                    // setState(() {
                                    //   cartProvider.deleteCart(
                                    //       cartId: widget.cart.id);
                                    // });
                                  },
                                  child: ImageIcon(
                                    AssetImage(
                                      "assets/images/icon_bin.png",
                                    ),
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
        ),
      ],
    );
  }

  _showDialog(CartProvider cartProvider) async {
    // cartProvider = Provider.of<CartProvider>(context);
    await showDialog<String>(
      context: context,
      builder: (context) => new _SystemPadding(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: Theme(
                  data: ThemeData(
                    primaryColor: softOrangeColor,
                  ),
                  child: new TextFormField(
                    autofocus: true,
                    controller: notesController,
                    // onChanged: (value) {
                    //   widget.cart.notes = value;
                    // },
                    cursorColor: softOrangeColor,
                    decoration: new InputDecoration(
                        labelText: 'Full Name', hintText: 'notes'),
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: softOrangeColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new TextButton(
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: softOrangeColor,
                  ),
                ),
                onPressed: () {
                  cartProvider.addNotes(widget.cart.id, notesController.text);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        // padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
