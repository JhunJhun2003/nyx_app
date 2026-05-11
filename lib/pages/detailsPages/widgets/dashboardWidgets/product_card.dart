// lib/pages/dashboardWidgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/models/Product.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/details.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.cost > product.price && product.cost > 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: GestureDetector(
        onTap: onTap ?? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(product: product),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product Image
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: product.images.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.images,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.grey[400],
                              );
                            },
                          ),
                        )
                      : Icon(Icons.image, size: 40, color: Colors.grey[400]),
                ),
                const SizedBox(height: 8),
                // Product Name
                Text(
                  product.productName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Custom',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Price
                if (hasDiscount) ...[
                  Text(
                    "${product.cost.toString()} Ks",
                    style: TextStyle(
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[600],
                      fontFamily: 'Custom',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${product.price.toString()} Ks",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'Custom',
                    ),
                  ),
                ] else ...[
                  Text(
                    "${product.price.toString()} Ks",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'Custom',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}