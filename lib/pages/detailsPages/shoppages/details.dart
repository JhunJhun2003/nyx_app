import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nyxproject/models/Product.dart';
import 'package:nyxproject/services/cart_service.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedIndex = 0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(cartService),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    _imageSpace(),
                    const SizedBox(height: 5),
                    _priceTag(),
                    const SizedBox(height: 5),
                    _name(),
                    const SizedBox(height: 5),
                    _color(),
                    const SizedBox(height: 5),
                    _size(),
                    const SizedBox(height: 10),
                    _quantitySelector(),
                    const SizedBox(height: 10),
                    _buildTabs(),
                    const SizedBox(height: 10),
                    selectedIndex == 0 ? _description() : _specification(),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 5),
                    _section("Related Products"),
                    const SizedBox(height: 5),
                    _gridCards(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _bottomBar(cartService),
          ],
        ),
      ),
    );
  }

  Widget _header(CartService cartService) {
    return Container(
      color: const Color.fromARGB(255, 13, 27, 42),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              "Product Details",
              style: const TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Navigate to cart page (you can create this later)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cart page coming soon')),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart_sharp,
                  color: Colors.white,
                ),
              ),
              if (cartService.itemCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartService.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.compare_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _quantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            "Quantity: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() {
                        _quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Container(
                  width: 40,
                  child: Text(
                    '$_quantity',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(Icons.add, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selectedIndex == 0 ? Colors.red : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Description",
                    style: TextStyle(
                      color: selectedIndex == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Custom",
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selectedIndex == 1 ? Colors.red : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Specification",
                    style: TextStyle(
                      color: selectedIndex == 1 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Custom",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageSpace() {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: widget.product.images.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.product.images,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image, size: 100);
                  },
                ),
              )
            : const Icon(Icons.image, size: 100),
      ),
    );
  }

  Widget _priceTag() {
    String stockStatus = widget.product.totalStock == "0"
        ? "Out of stock"
        : "In Stock";
    Color stockColor = widget.product.totalStock == "0"
        ? Colors.red
        : Colors.green;
    bool hasDiscount = widget.product.cost > widget.product.price;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 13, 27, 42)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasDiscount)
                Text(
                  "${widget.product.cost} Ks",
                  style: const TextStyle(
                    fontFamily: "Custom",
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12,
                  ),
                ),
              Text(
                "${widget.product.price} Ks",
                style: const TextStyle(
                  fontFamily: "Custom",
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Availability : ",
                style: TextStyle(fontFamily: "Custom", color: Colors.white),
              ),
              Text(
                stockStatus,
                style: TextStyle(fontFamily: "Custom", color: stockColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _name() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 13, 27, 42)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.product.productName,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _color() {
    List<String> colors = [];
    if (widget.product.colors.isNotEmpty) {
      colors = widget.product.colors.split(',').map((c) => c.trim()).toList();
    }

    if (colors.isEmpty) {
      colors = ["Default"];
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 13, 27, 42)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Colors",
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      colors[index],
                      style: const TextStyle(
                        fontFamily: "Custom",
                        color: Color.fromARGB(255, 13, 27, 42),
                        fontSize: 12,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _size() {
    List<String> sizes = [];
    if (widget.product.sizes.isNotEmpty) {
      sizes = widget.product.sizes.split(',').map((s) => s.trim()).toList();
    }

    if (sizes.isEmpty) {
      sizes = ["S", "M", "L", "XL"];
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 13, 27, 42)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sizes",
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sizes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      sizes[index],
                      style: const TextStyle(
                        fontFamily: "Custom",
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        widget.product.description.isNotEmpty
            ? widget.product.description
            : "No description available.",
        style: const TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }

  Widget _specification() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _specRow("Brand", widget.product.brand),
          _specRow("Category", widget.product.category),
          _specRow("Made In", widget.product.made),
          _specRow("Warranty", widget.product.warranty),
          _specRow("Rating", widget.product.rating),
          _specRow("Type", widget.product.types),
          _specRow("Weight", widget.product.weights),
          if (widget.product.tags != null && widget.product.tags!.isNotEmpty)
            _specRow("Tags", widget.product.tags!),
        ],
      ),
    );
  }

  Widget _specRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "-",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridCards() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.image, size: 100),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  "Product Name",
                  style: const TextStyle(fontSize: 12, fontFamily: 'Custom'),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "35,000 Ks",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Custom',
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        );
      },
    );
  }

  Widget _section(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 13, 27, 42),
          fontWeight: FontWeight.w900,
          fontFamily: 'Custom',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _bottomBar(CartService cartService) {
    bool hasDiscount = widget.product.cost > widget.product.price;
    int displayPrice = widget.product.price;
    int totalPrice = displayPrice * _quantity;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Row(
                  children: [
                    Text(
                      "$totalPrice Ks",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (hasDiscount)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "${widget.product.cost * _quantity} Ks",
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(fontFamily: "Custom", color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _addToCart(cartService); // ✅ Extract to separate method
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontFamily: "Custom", color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ Add this method to handle adding to cart
  void _addToCart(CartService cartService) {
    // Add to cart with selected quantity
    cartService.addToCart(widget.product, quantity: _quantity);

    // Show confirmation with longer duration
    ScaffoldMessenger.of(
      context,
    ).clearSnackBars(); // Clear any existing snackbars
   

    // Reset quantity to 1
    setState(() {
      _quantity = 1;
    });
  }
}
