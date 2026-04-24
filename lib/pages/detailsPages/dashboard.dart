import 'package:flutter/material.dart';
import 'package:nyxproject/models/Category.dart';
import 'package:nyxproject/util/Api.dart';

import 'shoppages/categoryPage.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Category> _categoriesList = [];
  List<Map<String, dynamic>> _groupedProducts = [];
  
  bool _isLoadingCategories = true;
  bool _isLoadingHomeData = true;

  String? _categoriesError;
  String? _homeDataError;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    await Future.wait([
      _loadCategories(),
      _loadHomeData(),
    ]);
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoadingCategories = true;
      _categoriesError = null;
    });

    try {
      final result = await Api.getAllCategories();

      if (result['success'] == true) {
        setState(() {
          _categoriesList = result['data'] ?? [];
          _isLoadingCategories = false;
        });
        print(' Loaded ${_categoriesList.length} categories');
      } else {
        setState(() {
          _categoriesError = result['message'] ?? 'Failed to load categories';
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

  Future<void> _loadHomeData() async {
    setState(() {
      _isLoadingHomeData = true;
      _homeDataError = null;
    });

    try {
      final result = await Api.getHomeData();

      if (result['success'] == true) {
        setState(() {
          _groupedProducts = result['data'] ?? [];
          _isLoadingHomeData = false;
        });
        print(' Loaded ${_groupedProducts.length} product groups');
        
        // Debug print
        for (var group in _groupedProducts) {
          print('Group: ${group['tagName']} - ${(group['products'] as List).length} products');
        }
      } else {
        setState(() {
          _homeDataError = result['message'] ?? 'Failed to load home data';
          _isLoadingHomeData = false;
        });
      }
    } catch (e) {
      setState(() {
        _homeDataError = 'Error loading home data: $e';
        _isLoadingHomeData = false;
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
              _section("Categories",(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage(index: 0)),
                );
              }),
              _categoriesWidget(),
              const Divider(),
              
              // Product Sections from Home Data API
              _buildProductSections(),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSections() {
    if (_isLoadingHomeData) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_homeDataError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            _homeDataError!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (_groupedProducts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('No products available'),
        ),
      );
    }

    return Column(
      children: _groupedProducts.map((group) {
        final tagName = group['tagName'];
        final products = group['products'] as List;
        
        return _productSection(tagName, products);
      }).toList(),
    );
  }

  Widget _productSection(String tagName, List products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        _section(tagName,(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryPage(index: 0)),
          );
        }),
        const SizedBox(height: 5),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _productCard(product);
            },
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _productCard(Map<String, dynamic> product) {
    final productName = product['product_name'] ?? 'Unknown';
    final price = product['price'] ?? 0;
    final imageUrl = product['image_url'] ?? '';
    final cost = product['cost'] ?? 0;

    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          print('Product tapped: $productName');
          // Navigate to product detail page
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(11),
                ),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.image, size: 50, color: Colors.grey),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Custom',
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${price.toString()} Ks',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Custom',
                      fontSize: 12,
                      color: Color.fromARGB(255, 13, 27, 42),
                    ),
                  ),
                  if (cost > price)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Save ${(cost - price).toString()} Ks',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontFamily: "Custom"),
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

  Widget _section(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontWeight: FontWeight.w900,
              fontFamily: 'Custom',
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: onTap, 
            icon: Icon(
              Icons.arrow_forward_ios_sharp, 
              color: Color.fromARGB(255, 13, 27, 42),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoriesWidget() {
    if (_isLoadingCategories) {
      return const SizedBox(
        height: 110,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_categoriesError != null) {
      return SizedBox(
        height: 110,
        child: Center(
          child: Text(
            _categoriesError!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (_categoriesList.isEmpty) {
      return const SizedBox(
        height: 110,
        child: Center(child: Text('No categories available')),
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
                Container(
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
}