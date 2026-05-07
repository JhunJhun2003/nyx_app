import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nyxproject/models/Category.dart';
import 'package:nyxproject/util/Api.dart';

import 'shoppages/catagory.dart';
import 'shoppages/other.dart';

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

  // =========================
  // ADDED FOR TYPEWRITER
  // =========================
  final TextEditingController _searchController =
      TextEditingController();

  final FocusNode _focusNode = FocusNode();

  String fullText = "What are you looking for ?";
  String animatedText = "";

  Timer? timer;
  int textIndex = 0;

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

    return Column(
      children: _groupedProducts.map((group) {
        final tagName = group['tagName'];
        final products = group['products'] as List;

        return _productSection(tagName, products);
      }).toList(),
    );
  }

  Widget _productSection(
      String tagName, List products) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        _section(tagName, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  dashboardPages(),
            ),
          );
        }),

        const SizedBox(height: 5),

        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(horizontal: 10),
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

  Widget _productCard(
      Map<String, dynamic> product) {
    final productName =
        product['product_name'] ?? 'Unknown';

    final price = product['price'] ?? 0;
    final imageUrl = product['image_url'] ?? '';
    final cost = product['cost'] ?? 0;

    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border:
            Border.all(color: Colors.black, width: 1),
      ),
      child: GestureDetector(
        onTap: () {
          print('Product tapped: $productName');
        },
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(
                  top: Radius.circular(11),
                ),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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
                      color: Color.fromARGB(
                          255, 13, 27, 42),
                    ),
                  ),

                  if (cost > price)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.circular(4),
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

  // =========================
  // MODIFIED SEARCH BAR
  // =========================
  Widget _searchBar() {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Custom",
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: animatedText,
          hintStyle: const TextStyle(
            fontFamily: 'Custom',
            color: Colors.white,
          ),
          filled: true,
          fillColor:
              const Color.fromARGB(255, 13, 27, 42),

          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),

          suffixIconColor: Colors.white,

          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 10,
          ),

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(30),
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
          image: AssetImage(
              "assets/images/Group1208.png"),
          fit: BoxFit.cover,
        ),
      ),
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
            icon: const Icon(
              Icons.arrow_forward_ios_sharp,
              color:
                  Color.fromARGB(255, 13, 27, 42),
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
        child:
            Center(child: CircularProgressIndicator()),
      );
    }

    if (_categoriesError != null) {
      return SizedBox(
        height: 110,
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
        height: 110,
        child: Center(
            child: Text('No categories available')),
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
            padding:
                const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding:
                      const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Color.fromARGB(255, 13, 27, 42),
                  ),
                  child: category.imageUrl !=
                              null &&
                          category.imageUrl!
                              .isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            category.imageUrl!,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            errorBuilder: (context,
                                error, stackTrace) {
                              return const Icon(
                                Icons.sports,
                                size: 30,
                                color: Colors.white,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.sports,
                          size: 30,
                          color: Colors.white,
                        ),
                ),

                const SizedBox(height: 6),

                SizedBox(
                  width: 70,
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromARGB(
                          255, 13, 27, 42),
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