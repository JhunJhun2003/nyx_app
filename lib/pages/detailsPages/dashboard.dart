import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

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
              _header(),
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

  Widget _header() {
  return Container(
    color: const Color.fromARGB(255, 13, 27, 42),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            height: 30,
            child: Image.asset(
              'assets/images/logo1.png',
              fit: BoxFit.contain,
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.language, color: Colors.white,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none, color: Colors.white,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,)),
            ],
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
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
          suffixIcon: const Icon(Icons.search),
          suffixIconColor: Colors.white,
          // suffixIcon: const Icon(Icons.tune),
          // suffixIconColor: Colors.white,
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

          return Padding(
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
          );
        },
      ),
    );
  }

  Widget _horizontalCards() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      height: 190,
      color: Color.fromARGB(255, 13, 27, 42),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: Icon(Icons.image, size: 80)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Badminton Shuttlecock", style: TextStyle(fontSize: 12,fontFamily: 'Custom',)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("45,000 Ks", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Custom',)),
                ),
                SizedBox(height: 6)
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
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
            border: BoxBorder.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: const [
              Expanded(child: Icon(Icons.image, size: 80)),
              Padding(
                padding: EdgeInsets.all(6),
                child: Text("Badminton Shuttlecock", style: TextStyle(fontSize: 12,fontFamily: 'Custom',)),
              ),
              Text("35,000 Ks", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Custom',)),
              SizedBox(height: 6)
            ],
          ),
        );
      },
    );
  }

  // Widget _bottomNav() {
  //   return BottomNavigationBar(
  //     backgroundColor: const Color.fromARGB(255, 13, 27, 42),
  //     selectedItemColor: Colors.white,
  //     unselectedItemColor: Colors.grey,
  //     type: BottomNavigationBarType.fixed,
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  //       BottomNavigationBarItem(icon: Icon(Icons.store), label: "Shop"),
  //       BottomNavigationBarItem(icon: Icon(Icons.class_), label: "Classes"),
  //       BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
  //       BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
  //     ],
  //   );
  // }
}