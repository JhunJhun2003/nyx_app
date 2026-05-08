import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nyxproject/models/Category.dart';
import 'package:nyxproject/models/Product.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/categoryPage.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/details.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/services/cart_service.dart';
import 'package:nyxproject/util/Api.dart';

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
  String? _productsError;
  List<String> images = [
    "assets/classes/Badminton.png",
    "assets/classes/Futsal.png",
    "assets/classes/Tennis.png",
  ];

  int currentIndex = 0;

  String searchQuery = "";
  
  @override
  void initState() {
    super.initState();
    _loadAllData();

    // =========================
    // ADDED FOCUS LISTENER
    // =========================
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _startTypingAnimation();
      }
    });
  }

  // =========================
  // ADDED TYPEWRITER FUNCTION
  // =========================
  void _startTypingAnimation() {
    timer?.cancel();

    animatedText = "";
    textIndex = 0;

    timer = Timer.periodic(
      const Duration(milliseconds: 70),
      (timer) {
        if (textIndex < fullText.length) {
          setState(() {
            animatedText += fullText[textIndex];
            textIndex++;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  // =========================
  // ADDED DISPOSE
  // =========================
  @override
  void dispose() {
    timer?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
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
        print('✅ Loaded ${_categoriesList.length} categories');
      } else {
        setState(() {
          _categoriesError =
              result['message'] ?? 'Failed to load categories';
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

        print(
            '✅ Loaded ${_groupedProducts.length} product groups');

        for (var group in _groupedProducts) {
          print(
              'Group: ${group['tagName']} - ${(group['products'] as List).length} products');
        }
      } else {
        setState(() {
          _homeDataError =
              result['message'] ?? 'Failed to load home data';
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
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _searchBar(),
              _banner(),

              _section("Categories", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Catagory(index: 0),
                  ),
                );
              }),

              _categoriesWidget(),
              const Divider(),

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

    final uniqueTags = _getUniqueTags();

    if (uniqueTags.isEmpty) {
      return _productGridSection(_allProducts, "All Products");
    }

    return Column(
      children: uniqueTags.map((tagName) {
        final products = _getProductsByTag(tagName);
        if (products.isEmpty) return const SizedBox.shrink();
        return _productGridSection(products, tagName);
      }).toList(),
    );
  }

  // ✅ Fixed: Changed from _productCardSection to _productGridSection
  Widget _productGridSection(List<Product> products, String sectionTitle) {
    // Show only first 4 products
    final displayProducts = products.length > 4 ? products.sublist(0, 4) : products;
    
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Custom',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: sectionTitle,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontFamily: 'Custom',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemCount: displayProducts.length,
          itemBuilder: (context, index) {
            final product = displayProducts[index];
            return _productCard(product);
          },
        ),
        const Divider(thickness: 1, height: 24),
      ],
    );
  }

  Widget _productCard(
      Map<String, dynamic> product) {
    final productName =
        product['product_name'] ?? 'Unknown';

    final price = product['price'] ?? 0;
    final imageUrl = product['image_url'] ?? '';
    final cost = product['cost'] ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(11),
                ),
              ),
              child: product.images.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(11),
                      ),
                      child: Image.network(
                        product.images,
                        width: double.infinity,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image, size: 50, color: Colors.grey);
                        },
                      ),
                    )
                  : const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Custom',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Product Category
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontFamily: 'Custom',
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Price
                  if (hasDiscount) ...[
                    Text(
                      "${product.cost.toString()} Ks",
                      style: TextStyle(
                        fontSize: 11,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[400],
                        fontFamily: 'Custom',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${product.price.toString()} Ks",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontFamily: 'Custom',
                      ),
                    ),
                  ] else ...[
                    Text(
                      "${product.price.toString()} Ks",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontFamily: 'Custom',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _banner() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          items: images.map((item) => Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(item), fit: BoxFit.cover)
            ),
          )).toList(), 
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            enlargeCenterPage: true,
            aspectRatio: 16/9,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            }
          )
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((item) => Container(
            height: 7,
            width: 7,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == item.key ? Colors.black : Colors.grey,
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _section(
      String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color:
                  Color.fromARGB(255, 13, 27, 42),
              fontWeight: FontWeight.w900,
              fontFamily: 'Custom',
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: onTap,
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text(
              "See All",
              style: TextStyle(
                fontSize: 13,
                color: Colors.red,
                fontFamily: 'Custom',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoriesWidget() {
    if (_isLoadingCategories) {
      return const SizedBox(
        height: 130,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_categoriesError != null) {
      return SizedBox(
        height: 130,
        child: Center(
          child: Text(
            _categoriesError!,
            style:
                const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (_categoriesList.isEmpty) {
      return const SizedBox(
        height: 130,
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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPage(
                    categoryName: category.name,
                    categoryId: category.id,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 13, 27, 42),
                    ),
                    child: category.imageUrl != null && category.imageUrl!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              category.imageUrl!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.category,
                                  size: 30,
                                  color: Colors.white,
                                );
                              },
                            ),
                          )
                        : const Icon(Icons.category, size: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 80,
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Custom',
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}