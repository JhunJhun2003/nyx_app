import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

/// 🔹 PRODUCT MODEL
class Product {
  final String name;
  final String brand;

  Product({required this.name, required this.brand});
}

class _ShopPageState extends State<ShopPage> {

  /// 🔹 BRAND LIST
  final List<String> brands = [
    "All",
    "Adidas",
    "Puma",
    "Gucci",
  ];

  /// 🔹 PRODUCT LIST
  final List<Product> allProducts = [
    Product(name: "Shuttlecock", brand: "Adidas"),
    Product(name: "Football", brand: "Puma"),
    Product(name: "Basketball", brand: "Gucci"),
    Product(name: "Running Shoes", brand: "Adidas"),
    Product(name: "Tennis Racket", brand: "Puma"),
    Product(name: "Gucci Bag", brand: "Gucci"),
    Product(name: "Adidas Shirt", brand: "Adidas"),
    Product(name: "Puma Shorts", brand: "Puma"),
  ];

  List<Product> filteredProducts = [];

  String selectedBrand = "All";
  String searchQuery = "";

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(allProducts); // show all initially
  }

  void _applyFilters() {
    List<Product> results = allProducts;

    if (searchQuery.trim().isNotEmpty) {
      results = results.where((product) {
        return product.name
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedBrand != "All") {
      results = results.where((product) {
        return product.brand == selectedBrand;
      }).toList();
    }

    setState(() {
      filteredProducts = results;
    });
  }

  void _clearSearch() {
    _controller.clear();
    searchQuery = "";
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              _searchBar(),
              _filterBar(),
              _gridCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          searchQuery = value;
          _applyFilters();
        },
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "What are you looking for?",
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF0D1B2A),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: _clearSearch,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _filterBar() {
    return Container(
      height: 45,
      margin: const EdgeInsets.all(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          final isSelected = brand == selectedBrand;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedBrand = brand;
              });
              _applyFilters();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Color(0xFF0D1B2A)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  brand,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _gridCards() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: [
              const Expanded(
                child: Icon(Icons.image, size: 160),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  product.name,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Text(
                product.brand,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const Text(
                "35,000 Ks",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
            ],
          ),
        );
      },
    );
  }
}