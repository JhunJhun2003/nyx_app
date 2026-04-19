import 'package:flutter/material.dart';
import 'package:nyxproject/models/product.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}


class _DashBoardState extends State<DashBoard> {

  final List<Product> allProducts = [
    Product(name: "Shuttlecock", price: 45000, catagories: '', brand: '',),
    Product(name: "Football", price: 35000, catagories: '', brand: ''),
    Product(name: "Shoe", price: 95000, catagories: '', brand: '',),
    Product(name: "Hand Glove",price: 65000, catagories: '', brand: '',),
    Product(name: "Golf Bag", price: 125000, catagories: '', brand: ''),
    Product(name: "Shuttlecock", price: 55000, catagories: '', brand: '',),
    Product(name: "Gloves", price: 34000, catagories: '', brand: '',),
    Product(name: "Basketball", price: 50000, catagories: '', brand: ''),
  ];

  List<Product> filteredProducts = [];

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts ; // show all initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // bottomNavigationBar: _bottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              _searchBar(),
              _banner(),
              _section("Categories"),
              // _categories(),
              Divider(),
              _section("Happy Hour Sales"),
              // _HappyHourSalesCards(),
              Divider(),
              _section("Special Promotion"),
              // _SpecialPromotionCards(),
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
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        onSubmitted: (value) {
          setState(() {
            searchQuery = value;
            filteredProducts = allProducts.where((product) {
              return product.name.toLowerCase().contains(value.toLowerCase());
            }).toList();
          });
        },
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Custom",
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "What are you looking for ?",
          hintStyle: TextStyle(fontFamily: 'Custom', color: Colors.white),
          filled: true,
          fillColor: Color.fromARGB(255, 13, 27, 42),
          suffixIcon: IconButton(
            onPressed:(){}, 
            icon: Icon(Icons.search),
          ),
          suffixIconColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,)
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
        image: DecorationImage(
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
        ),
      ),
    );
  }

  // Widget _categories() {
  //   // Use API categories instead of static data
  //   final categories = Api.categories;

  //   if (categories.isEmpty) {
  //     return const Center(child: Text('No categories available'));
  //   }

  //   return SizedBox(
  //     height: 110,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: categories.length,
  //       itemBuilder: (context, index) {
  //         final item = categories[index]; // Category object

  //         return Padding(
  //           padding: const EdgeInsets.only(left: 16),
  //           child: Column(
  //             children: [
  //               // Circle Image
  //               Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: const BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   color: Color.fromARGB(255, 13, 27, 42),
  //                 ),
  //                 child: item.imageUrl != null
  //                     ? Image.network(
  //                         item.imageUrl!, // Use .imageUrl for API
  //                         width: 30,
  //                         height: 30,
  //                         fit: BoxFit.contain,
  //                         errorBuilder: (context, error, stackTrace) {
  //                           return const Icon(
  //                             Icons.error,
  //                             size: 30,
  //                             color: Colors.red,
  //                           );
  //                         },
  //                       )
  //                     : const Icon(Icons.sports, size: 30, color: Colors.white),
  //               ),
  //               const SizedBox(height: 6),
  //               Text(
  //                 item.name ?? 'Unknown', // Use .name for API
  //                 style: const TextStyle(
  //                   color: Color.fromARGB(255, 13, 27, 42),
  //                   fontFamily: 'Custom',
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w900,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _HappyHourSalesCards() {
  //   final products = Api.products;

  //   if (products.isEmpty) {
  //     return const Center(child: Text('No products available'));
  //   }

  //   // Filter products that have 'happy hour sales' in their tags
  //   final happyHourProducts = products.where((product) {
  //     return product.tags?.toLowerCase().contains("happy hour sales") ?? false;
  //   }).toList();

  //   if (happyHourProducts.isEmpty) {
  //     return const Center(
  //       child: Text('No products with "happy hour sales" tag available'),
  //     );
  //   }

  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     height: 190,
  //     color: const Color.fromARGB(255, 13, 27, 42),
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: happyHourProducts.length, // Use actual count
  //       itemBuilder: (context, index) {
  //         final product = happyHourProducts[index]; // Get actual product

  //         return Container(
  //           width: 140,
  //           margin: const EdgeInsets.only(left: 10),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Product Image
  //               Expanded(
  //                 child: product.images != null
  //                     ? ClipRRect(
  //                         borderRadius: const BorderRadius.vertical(
  //                           top: Radius.circular(12),
  //                         ),
  //                         child: Image.network(
  //                           product.images!,
  //                           width: double.infinity,
  //                           height: double.infinity,
  //                           fit: BoxFit.cover,
  //                           errorBuilder: (context, error, stackTrace) {
  //                             return const Icon(Icons.image, size: 80);
  //                           },
  //                         ),
  //                       )
  //                     : const Icon(Icons.image, size: 80),
  //               ),

  //               // Product Name
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(
  //                   product.productName ?? 'Unknown Product',
  //                   style: const TextStyle(fontSize: 12, fontFamily: 'Custom'),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),

  //               // Product Price
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Text(
  //                   '${product.price ?? '0'} Ks',
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: 'Custom',
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 6),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _SpecialPromotionCards() {
  //   final products = Api.products;

  //   if (products.isEmpty) {
  //     return const Center(child: Text('No products available'));
  //   }

  //   // Filter products that have 'special promotion' in their tags
  //   final specialPromotionProducts = products.where((product) {
  //     return product.tags?.toLowerCase().contains("special promotion") ?? false;
  //   }).toList();

  //   if (specialPromotionProducts.isEmpty) {
  //     return const Center(
  //       child: Text('No products with "special promotion" tag available'),
  //     );
  //   }

  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     height: 190,
  //     color: const Color.fromARGB(255, 13, 27, 42),
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: specialPromotionProducts.length, // Use actual count
  //       itemBuilder: (context, index) {
  //         final product = specialPromotionProducts[index]; // Get actual product

  //         return Container(
  //           width: 140,
  //           margin: const EdgeInsets.only(left: 10),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Product Image
  //               Expanded(
  //                 child: product.images != null
  //                     ? ClipRRect(
  //                         borderRadius: const BorderRadius.vertical(
  //                           top: Radius.circular(12),
  //                         ),
  //                         child: Image.network(
  //                           product.images!,
  //                           width: double.infinity,
  //                           height: double.infinity,
  //                           fit: BoxFit.cover,
  //                           errorBuilder: (context, error, stackTrace) {
  //                             return const Icon(Icons.image, size: 80);
  //                           },
  //                         ),
  //                       )
  //                     : const Icon(Icons.image, size: 80),
  //               ),

  //               // Product Name
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(
  //                   product.productName ?? 'Unknown Product',
  //                   style: const TextStyle(fontSize: 12, fontFamily: 'Custom'),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),

  //               // Product Price
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Text(
  //                   '${product.price ?? '0'} Ks',
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: 'Custom',
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 6),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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
            children: [
              const Icon(Icons.image, size: 80),
              Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  "Badminton Shuttlecock",
                  style: TextStyle(fontSize: 12, fontFamily: 'Custom'),
                ),
              ),
              Text(
                "35,000 Ks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Custom',
                ),
              ),
              SizedBox(height: 6),
            ],
          ),
        );
      },
    );
  }

}
