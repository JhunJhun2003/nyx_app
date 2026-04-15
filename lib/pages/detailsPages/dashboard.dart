import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/catagory.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/details.dart';
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
              _categories(),
              Divider(),
              _section("Happy Hour Sales"),
              _horizontalCards(),
              Divider(),
              _section("Special Promotion"),
              _horizontalCards(),
              _section("New Arrival"),
              _gridCards(),
              _section("Hot Item"),
              _gridCards(),
              const SizedBox(height: 20)
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
          hintStyle: TextStyle(
            fontFamily: 'Custom',
            color: Colors.white,
          ),
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
        color: Colors.amber,
        image: DecorationImage(
          image: AssetImage("assets/images/Group1208.png"),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(title,
       style: const TextStyle(
        color: Color.fromARGB(255, 13, 27, 42), 
        fontWeight: FontWeight.w900,
        fontFamily: 'Custom',
        )
      ),
    );
  }

  Widget _categories() {
    final categories = [
      {"image": "assets/images/badminton1.png", "name": "Badminton"},
      {"image": "assets/images/basketball.png", "name": "Basketball"},
      {"image": "assets/images/boxing.png", "name": "Boxing"},
      {"image": "assets/images/golf.jpg", "name": "Golf"},
      {"image": "assets/images/football.png", "name": "Football"},
      {"image": "assets/images/tennis_catagory.png", "name": "Tennis"},
    ];

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Catagory(index: index),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  // Circle Image
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 13, 27, 42),
                    ),
                    child: Image.asset(
                      item["image"]!,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
            
                  const SizedBox(height: 6),
            
                  Text(
                    item["name"]!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 13, 27, 42),
                      fontFamily: 'Custom',
                      fontSize: 12,
                      fontWeight: FontWeight.w900
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

  Widget _horizontalCards() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 190,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 13, 27, 42),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final Product product = filteredProducts[index];

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
              width: 140,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Icon(Icons.image, size: 120)),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(product.name, style: TextStyle(fontSize: 12,fontFamily: 'Custom',)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("${product.price.toString()} Ks", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Custom',)),
                  ),
                  SizedBox(height: 6)
                ],
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
        final Product product = filteredProducts[index];
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
              border: BoxBorder.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: const [
                Expanded(child: Icon(Icons.image, size: 120)),
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