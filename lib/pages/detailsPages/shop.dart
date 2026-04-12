import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                _searchBar(),
                _filterbar(),
                _gridCards()
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
          suffixIcon: Icon(Icons.search),
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

  Widget _filterbar(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Brand : ", 
            style: TextStyle(
              fontFamily: "Custom", 
              fontSize: 15, 
              color: Color.fromARGB(255, 251, 0, 0),
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: (){}, 
              child: Text(
                "All",
                style: TextStyle(
                  fontFamily: "Custom",
                  color: Colors.black
                )
              ),
            )
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: (){}, 
              child: Text(
                "Brand",
                style: TextStyle(
                  fontFamily: "Custom",
                  color: Colors.black
                ),
              )
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: (){}, 
              child: Text(
                "Brand",
                style: TextStyle(
                  fontFamily: "Custom",
                  color: Colors.black
                ),
              )
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: (){}, 
              child: Text(
                "Brand",
                style: TextStyle(
                  fontFamily: "Custom",
                  color: Colors.black
                ),
              )
            ),
          ),
        ],
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
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: BoxBorder.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: const [
              Expanded(child: Icon(Icons.image, size: 150)),
              Padding(
                padding: EdgeInsets.all(5),
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
}