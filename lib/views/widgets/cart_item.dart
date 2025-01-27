import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/cart_controller.dart';
import '../../models/product_model.dart';


//cart item widget styled using riverpod
class CartItem extends ConsumerWidget {
  final Product product;

  CartItem({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(product.image, fit: BoxFit.cover, width: 50),
        ),
        title: Text(product.title),
        subtitle: Text("\$${product.price} x ${product.quantity}"),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: product.quantity > 1
                  ? () {
                ref
                    .read(cartProvider.notifier)
                    .adjustQuantity(product, product.quantity - 1);
              }
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .adjustQuantity(product, product.quantity + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
