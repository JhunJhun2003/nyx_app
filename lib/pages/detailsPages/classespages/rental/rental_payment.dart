import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/rental/rental_slip.dart';

class rentalPayment extends StatefulWidget {
  const rentalPayment({super.key});

  @override
  State<rentalPayment> createState() => _rentalPaymentState();
}

List<String> options = ["CB Pay","Kpay","WavePay","AYA Pay"];

class _rentalPaymentState extends State<rentalPayment> {
  String currentOption = options[0];
  final TextEditingController input = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              SizedBox(height: 5),
              _section("Information"),
              SizedBox(height: 5),
              _information("Name","xxxxxxxxxx"),
              SizedBox(height: 1),
              _information("Phone Number","09 xxx xxx xxx"),
              SizedBox(height: 1),
              _information("Court","Badminton Court"),
              SizedBox(height: 1),
              _information("Court Number","Court A"),
              SizedBox(height: 1),
              _information("Date","11-05-2026"),
              SizedBox(height: 1),
              _information("Time Slot","18:00 - 19:00"),
              SizedBox(height: 1),
              _information("Number of Session","1"),
              SizedBox(height: 1),
              _information("Rental Items","5"),
              Divider(),
              _information("Court Fees :","25,000 Ks"),
              SizedBox(height: 1),
              _information("Rental Fees :","10,000 Ks"),
              Divider(),
              _information("Total Amount","35,000 Ks"),
              SizedBox(height: 1),
              _information("Discount(%)","0"),
              Divider(),
              _information1("Total","35,000 Ks"),
              SizedBox(height: 10),
              _section("Select Payment Method"),
               SizedBox(height: 5),
              _paymentMethod(),
              SizedBox(height: 5),
              _paymentInfo(),
              SizedBox(height: 10),
              _input("Enter transation number"),
              SizedBox(height: 10),
              _confirm(),
              SizedBox(height: 30),
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          const Expanded(
            child: Text(
              "Payment",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
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
          fontWeight: FontWeight.w500,
          fontFamily: 'Custom',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _information(String left, String right) {
    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontWeight: FontWeight.w500,
              fontFamily: 'Custom',
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              right,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Color.fromARGB(255, 13, 27, 42),
                fontWeight: FontWeight.w500,
                fontFamily: 'Custom',
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _information1(String right, String left) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            right,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontWeight: FontWeight.w700,
              fontFamily: 'Custom',
              fontSize: 17,
            ),
          ),
          Text(
            left,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontWeight: FontWeight.w700,
              fontFamily: 'Custom',
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethod(){
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text("CB Pay",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),),),
            leading: Radio(
              value: options[0],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
            ),
          ),
          ListTile(
            title: Text("Kpay",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),),),
            leading: Radio(
              value: options[1],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
            ),
          ),
          ListTile(
            title: Text("WavePay",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),),),
            leading: Radio(
              value: options[2],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
            ),
          ),
          ListTile(
            title: Text("AYA Pay",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),),),
            leading: Radio(
              value: options[3],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentInfo(){
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Kpay Name :",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),fontSize: 17),),
              SizedBox(width: 50,),
              Text("Admin Name",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),fontSize: 17),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Kpay Number :",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),fontSize: 17),),
              SizedBox(width: 33,),
              Text("09 xxx xxx xxx",style: TextStyle(fontFamily: 'Custom',color: Color.fromARGB(255, 13, 27, 42),fontSize: 17),),
            ],
          )
        ],
      ),
    );
  }

  Widget _input(String text){
    return Center(
      child: Container(
        height: 50,
        width: 300,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          controller: input,
          style: TextStyle(
            fontFamily: "Custom",
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          decoration: InputDecoration(
            hintText: text,
            filled: true,
            fillColor: Color.fromARGB(255, 13, 27, 42),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
            ),
          ),
        )
      ),
    );
  }

  Widget _confirm(){
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          fixedSize: const Size(200, 50)
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => rentalSlip()),
          );
        }, 
        child: Text(
          "Comfirm Payment",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}