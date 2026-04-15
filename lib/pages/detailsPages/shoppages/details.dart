import 'package:flutter/material.dart';
import 'package:nyxproject/models/product.dart';
// import 'package:nyxproject/pages/detailsPages/shoppages/catagory.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
  
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _imageSpace(),
              SizedBox(height: 5),
              _priceTag(),
              SizedBox(height: 5),
              _name(),
              SizedBox(height: 5),
              _color(),
              SizedBox(height: 5),
              _size(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab("Description", 0),
                  _buildTab("Specification", 1),
                ],
              ),
              SizedBox(height: 5),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: selectedIndex == 0
                    ? _description()
                    : _specification(),
              ),
              SizedBox(height: 170),
              Divider(),
              SizedBox(height: 5),
              _section("Related Products"),
              SizedBox(height: 5),
              _gridCards()
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomBar(),
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
            child: Text(
              "Product Details",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
          ),

          SizedBox(
            child: Row(
              children: [
                IconButton(
                  onPressed: (){

                  }, 
                  icon: Icon(
                    Icons.shopping_cart_sharp, 
                    color: Colors.white,
                  ),
                ),

                IconButton(
                  onPressed: (){
                  }, 
                  icon: Icon(
                    Icons.compare_rounded, 
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageSpace(){
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(color: Colors.black, width: 2),
        ),
        child: Icon(Icons.image, size: 160),
      ),
    );
  }

  Widget _priceTag(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 27, 42),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.product.price} Ks",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    "Availability : ",
                    style: TextStyle(
                      fontFamily: "Custom",
                      color: Colors.white
                    ),
                  ),

                  Text(
                    "Out of stock",
                    style: TextStyle(
                      fontFamily: "Custom",
                      color: Colors.red
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

  Widget _name(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 27, 42),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.name,
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(
                      Icons.favorite_border,  
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(
                      Icons.share_outlined,  
                      color: Colors.white,
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

  Widget _color(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 27, 42),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Colors",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Color1",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Color.fromARGB(255, 13, 27, 42),
                          fontSize: 15,
                        ),
                      ), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Color2",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Color.fromARGB(255, 13, 27, 42),
                          fontSize: 15,
                        ),
                      ), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Color3",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Color.fromARGB(255, 13, 27, 42),
                          fontSize: 15,
                        ),
                      ), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Color4",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Color.fromARGB(255, 13, 27, 42),
                          fontSize: 15,
                        ),
                      ), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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

  Widget _size(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 27, 42),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sizes",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Size 1",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Size 2",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Size 3",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Text(
                        "Size 4",
                        style: TextStyle(
                          fontFamily: "Custom",
                          color: Colors.black,
                          fontSize: 15,
                        ),
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

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 185,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Custom"
          ),
        ),
      ),
    );
  }

  Widget _description() {
    return Center(
      child: Text(
        "This is Description",
        key: ValueKey(1),
      ),
    );
  }

  Widget _specification() {
    return Center(
      child: Text(
        "This is Specification",
        key: ValueKey(2),
      ),
    );
  }

  Widget _gridCards() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8, // Width / height
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
              Expanded(child: Icon(Icons.image, size: 150)),
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

  Widget _section(String title) {
    return Center(
      child: Text(title,
       style: const TextStyle(
        color: Color.fromARGB(255, 13, 27, 42), 
        fontWeight: FontWeight.w900,
        fontFamily: 'Custom',
        )
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Amount",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "25,000 Ks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    fontFamily: "Custom",
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontFamily: "Custom",
                    color: Colors.white
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}