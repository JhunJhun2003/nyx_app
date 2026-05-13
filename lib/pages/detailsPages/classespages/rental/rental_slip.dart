import 'package:flutter/material.dart';

class rentalSlip extends StatefulWidget {
  const rentalSlip({super.key});

  @override
  State<rentalSlip> createState() => _rentalSlipState();
}

class _rentalSlipState extends State<rentalSlip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              SizedBox(height: 15),
              _voucher(),
              SizedBox(height: 15),
              _buttoms(),
            ],
          ),
        )
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
            child: Text(
              "Slip",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _voucher(){
    return Container(
      height: 500,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 10),
          Center(
            child: Text(
              "Booking Successful",
              style: TextStyle(
                fontFamily: "Custom",
                color: const Color.fromARGB(255, 51, 252, 57),
                fontSize: 21,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          // SizedBox(height: 3),
          // Center(
          //   child: Text(
          //     "Thank you for shopping with us.",
          //     style: TextStyle(
          //       fontFamily: "Custom",
          //       color: Colors.white,
          //       fontSize: 17,
          //     ),
          //   ),
          // ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowWidget1("Registered Id :", "#1101"),
              _rowWidget1("Date :", "04/03/26"),
            ],
          ),
          SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowWidget1("Payment :", "Kpay"),
              _rowWidget1("Time :", "12:25 AM"),
            ],
          ),
          SizedBox(height: 7),
          Divider(),
          SizedBox(height: 7),
          _rowWidget3("Court Fees","25,000 Ks"),
          SizedBox(height: 5),
          _rowWidget3("Rent Fees", "10,000 Ks"),
          SizedBox(height: 7),
          Divider(),
          SizedBox(height: 7),
          _rowWidget3("Total Amount :","35,000 Ks"),
          _rowWidget3("Discount(%)","0"),
          SizedBox(height: 7),
          Divider(),
          SizedBox(height: 7),
          _rowWidget3("Total :","35,000 Ks"),
        ],
      ),
    );
  }

  Widget _rowWidget1(String title1, String title2){
    return Container(
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title1,
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          Text(
            title2,
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowWidget3(String title1, String title2){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title1,
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          Text(
            title2,
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttoms(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 13, 27, 42),
              iconColor: Colors.white,
              fixedSize: Size(150, 40)
            ),
            icon: Icon(Icons.home,size: 25,),
            onPressed: (){}, 
            label: Text(
              "Home",
              style: TextStyle(color: Colors.white,fontFamily: 'Custom',fontSize: 17),
            )
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              iconColor: Colors.white,
              fixedSize: Size(150, 40)
            ),
            icon: Icon(Icons.file_download_outlined,size: 25,),
            onPressed: (){}, 
            label: Text(
              "Download",
              style: TextStyle(color: Colors.white,fontFamily: 'Custom',fontSize: 17),
            )
          ),
        ],
      ),
    );
  }

}