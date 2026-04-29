import 'package:flutter/material.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({super.key});

  @override
  State<orderHistory> createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              SizedBox(height: 10),
              _menuItem("001","2/3/2026","45,000 Ks"),
               SizedBox(height: 5),
              _menuItem("002","3/3/2026","65,000 Ks"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      color: const Color.fromARGB(255, 13, 27, 42),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (){
                Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.arrow_back_ios_new_rounded, 
              color: Colors.white,
              ),
          ),
          Expanded(
            child: const Text(
              "Orders History", 
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String slip, String date, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 27, 42),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              slip,
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            SizedBox(width: 40),
            Expanded(
              child: Text(
                date,
                style: TextStyle(
                  fontFamily: "Custom",
                  color: Colors.white,
                  fontSize: 17,
                ),
              )
            ),
            Text(
              price,
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.arrow_forward_ios_rounded),
              color: Colors.white,
            )
          ],
        )
      ),
    );
  }

}