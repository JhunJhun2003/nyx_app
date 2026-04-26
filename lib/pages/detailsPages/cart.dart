import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/contactInfo.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                _addedCart(),
                SizedBox(height: 5),
                _moreItem(),
                SizedBox(height: 20),
                _comfirm(),
              ],
            ),
          ),
        ),
    );
  }

  Widget _addedCart() {
    return Container(
      height: 140,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Icon(
              Icons.image,
              size: 120,
              color: Colors.white,
            )
          ),
          Positioned(
            left: 130,
            child: Column(
              children: [
                SizedBox(height: 15),
                Text(
                  "product.name",
                  style: const TextStyle(fontFamily: "Custom", fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "product.catagories",
                  style: const TextStyle(fontFamily: "Custom", fontSize: 13, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  // "${product.price.toString()} Ks",
                  "Product Price Ks",
                  style: const TextStyle(fontFamily: "Custom", fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              onPressed: (){}, 
              icon: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 28,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                children: [
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moreItem(){
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Text(
            "Add more items",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Custom",
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _comfirm(){
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 5,
            child: Text(
              "Total :",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: 15,
              ),
            )
          ),
          Positioned(
            top: 5,
            right: 10,
            child: Text(
              "100,000 Ks",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: 15,
              ),
            )
          ),
          Positioned(
            left: 120,
            bottom: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => contactInfo()),
                );
              }, 
              child: Text(
                "Order Comfirm",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 15,
                ),
              )
            )
          ),
        ],
      ),
    );
  }
}