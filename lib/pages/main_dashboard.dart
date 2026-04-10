import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/dashboard.dart';
import 'package:nyxproject/pages/detailsPages/classes.dart';
import 'package:nyxproject/pages/detailsPages/cart.dart';
import 'package:nyxproject/pages/detailsPages/shop.dart';
import 'package:nyxproject/pages/detailsPages/account.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int currentPageIndex = 0;

  final pages = [
    DashBoard(),
    ShopPage(),
    ClassesPage(),
    CartPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 0),
            Expanded(
              child: Container(
                color: Colors.red, // 👈 see spacing clearly
                child: pages[currentPageIndex],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 13, 27, 42),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageIndex,
        onTap: (index){
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: "Classes"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  Widget _header() {
  return Container(
    margin: const EdgeInsets.only(bottom: 5), // 👈 space below header
    color: const Color.fromARGB(255, 13, 27, 42),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
}