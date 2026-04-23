import 'package:flutter/material.dart';
import 'package:nyxproject/models/Pp.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/details.dart';
import 'package:nyxproject/models/product.dart';


class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  final List<String> brands = [
    "All",
    "Adidas",
    "Puma",
    "Gucci",
  ];

  final List<Pp> allProducts = [
    Pp(name: "Shuttlecock", brand: "Adidas", price: 30000, catagories: '',),
    Pp(name: "Football", brand: "Puma", price: 40000, catagories: ''),
    Pp(name: "Basketball", brand: "Gucci", price: 50000, catagories: '',),
    Pp(name: "Running Shoes", brand: "Adidas", price: 35000, catagories: '',),
    Pp(name: "Tennis Racket", brand: "Puma", price: 40000, catagories: ''),
    Pp(name: "Gucci Bag", brand: "Gucci", price: 50000, catagories: '',),
    Pp(name: "Adidas Shirt", brand: "Adidas", price: 34000, catagories: '',),
    Pp(name: "Puma Shorts", brand: "Puma", price: 40000, catagories: ''),
  ];

  List<Pp> filteredProducts = [];

  String selectedBrand = "All";
  String searchQuery = "";

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts; // show all initially
  }

  void _clearSearch() {
    _controller.clear();
    searchQuery = "";
    _applyFilters();
  }

  String selectedSort = "None";

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Price: Low to High"),
              onTap: () {
                selectedSort = "low";
                _applyFilters();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Price: High to Low"),
              onTap: () {
                selectedSort = "high";
                _applyFilters();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Name: A-Z"),
              onTap: () {
                selectedSort = "az";
                _applyFilters();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _applyFilters() {
    List<Pp> results = allProducts;

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

    if (selectedSort == "low") {
      results.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSort == "high") {
      results.sort((a, b) => b.price.compareTo(a.price));
    } else if (selectedSort == "az") {
      results.sort((a, b) => a.name.compareTo(b.name));
    }

    setState(() {
      filteredProducts = results;
    });
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
          filled: true,
          fillColor: const Color(0xFF0D1B2A),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.tune, color: Colors.white),
                onPressed: _showSortBottomSheet,
              ),
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: _clearSearch,
              ),
            ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final Pp product = filteredProducts[index];
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ProductDetails(product: product),
            //     ),
            //   );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.image, size: 150),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Text("Badminton Shuttlecock", style: TextStyle(fontSize: 12,fontFamily: 'Custom',)),
                ),
                Text("35,000 Ks", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Custom',)),
                SizedBox(height: 6)
              ],
            ),
          ),
        );
      },
    );
  }
}