import 'package:flutter/material.dart';
import 'package:nyxproject/models/Category.dart';
import 'package:nyxproject/models/product.dart';
import 'package:nyxproject/util/Api.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Category> _categoriesList = [];
  bool _isLoadingCategories = true;
  String? _categoriesError;

  final List<Product> allProducts = [
    Product(name: "Shuttlecock", price: 45000, catagories: '', brand: ''),
    Product(name: "Football", price: 35000, catagories: '', brand: ''),
    Product(name: "Shoe", price: 95000, catagories: '', brand: ''),
    Product(name: "Hand Glove", price: 65000, catagories: '', brand: ''),
    Product(name: "Golf Bag", price: 125000, catagories: '', brand: ''),
    Product(name: "Shuttlecock", price: 55000, catagories: '', brand: ''),
    Product(name: "Gloves", price: 34000, catagories: '', brand: ''),
    Product(name: "Basketball", price: 50000, catagories: '', brand: ''),
  ];

  List<Product> filteredProducts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
    _loadCategories();  // No token needed
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoadingCategories = true;
      _categoriesError = null;
    });

    try {
      // No token required - public access
      final result = await Api.getAllCategories();
      
      if (result['success']) {
        setState(() {
          _categoriesList = result['data'];
          _isLoadingCategories = false;
        });
        print(' Loaded ${_categoriesList.length} categories');
      } else {
        setState(() {
          _categoriesError = result['message'];
          _isLoadingCategories = false;
        });
      }
    } catch (e) {
      setState(() {
        _categoriesError = 'Error loading categories: $e';
        _isLoadingCategories = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _searchBar(),
              _banner(),
              _section("Categories"),
              _categoriesWidget(),
              const Divider(),
              _section("Happy Hour Sales"),
              const Divider(),
              _section("Special Promotion"),
              _section("New Arrival"),
              _gridCards(),
              _section("Hot Item"),
              _gridCards(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        onSubmitted: (value) {
          setState(() {
            searchQuery = value;
            filteredProducts = allProducts.where((product) {
              return product.name.toLowerCase().contains(value.toLowerCase());
            }).toList();
          });
        },
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Custom",
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "What are you looking for ?",
          hintStyle: const TextStyle(fontFamily: 'Custom', color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 13, 27, 42),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          suffixIconColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return Container(
      height: 180,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/images/Group1208.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 13, 27, 42),
          fontWeight: FontWeight.w900,
          fontFamily: 'Custom',
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _categoriesWidget() {
    if (_isLoadingCategories) {
      return const SizedBox(
        height: 110,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_categoriesError != null) {
      return SizedBox(
        height: 110,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _categoriesError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _loadCategories,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 13, 27, 42),
                ),
                child: const Text('Retry', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      );
    }

    if (_categoriesList.isEmpty) {
      return const SizedBox(
        height: 110,
        child: Center(
          child: Text('No categories available'),
        ),
      );
    }

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categoriesList.length,
        itemBuilder: (context, index) {
          final category = _categoriesList[index];

          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                // Circle Image
                GestureDetector(
                  onTap: () {
                    // Navigate to category products page
                    print('Category tapped: ${category.name}');
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 13, 27, 42),
                    ),
                    child: category.imageUrl != null && category.imageUrl!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              category.imageUrl!,
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.sports,
                                  size: 30,
                                  color: Colors.white,
                                );
                              },
                            ),
                          )
                        : const Icon(Icons.sports, size: 30, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 70,
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 13, 27, 42),
                      fontFamily: 'Custom',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image, size: 50),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Badminton Shuttlecock",
                      style: const TextStyle(fontSize: 12, fontFamily: 'Custom'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "35,000 Ks",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Custom',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}