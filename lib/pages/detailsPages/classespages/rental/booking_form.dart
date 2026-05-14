import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/rental/rental_payment.dart';

class bookingForm extends StatefulWidget {
  const bookingForm({super.key});

  @override
  State<bookingForm> createState() => _bookingFormState();
}

class _bookingFormState extends State<bookingForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String? Court;
  String? TimeSlot;
  double courtPrice = 25000;
  double sessionPrice = 25000;
  double rentalFees = 0;
  double totalCharges = 0;

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = 
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void calculateTotal() {
    setState(() {
      totalCharges = courtPrice + sessionPrice + rentalFees;
    });
  }

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.02),
              _formInput1("Name", "Enter your name", nameController, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.015),
              _formInput1("Phone Number", "09 xxx xxx xxx", phoneController, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.015),
              _rowSelection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.015),
              _dateInput(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.015),
              _rowTimeSlot(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.015),
              _formInput1("Rental Fees", "Auto Fill", null, screenWidth, screenHeight, 
                  value: "$rentalFees Ks", enabled: false),
              SizedBox(height: screenHeight * 0.015),
              _formInput1("Total Charges (MMK)", "Auto Fill (court + session)", null, screenWidth, screenHeight,
                  value: "${totalCharges.toStringAsFixed(0)} Ks", enabled: false),
              SizedBox(height: screenHeight * 0.015),
              _formInput2("Remark", "Write remark", remarkController, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _confirm(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(double screenWidth, double screenHeight) {
    return Container(
      color: const Color.fromARGB(255, 13, 27, 42),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.arrow_back_ios_new_rounded, 
              color: Colors.white,
              size: screenWidth * 0.055,
            ),
          ),
          SizedBox(width: screenWidth * 0.05),
          Text(
            "BOOKING FORM",
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formInput1(String title, String hint, TextEditingController? controller, double screenWidth, double screenHeight,
      {String? value, bool enabled = true}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color.fromARGB(255, 13, 27, 42), 
              fontWeight: FontWeight.w500,
              fontFamily: 'Custom',
              fontSize: screenWidth * 0.045,
            ),
          ),
          SizedBox(height: screenHeight * 0.008),
          Container(
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: controller,
              enabled: enabled,
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
              decoration: InputDecoration(
                hintText: value ?? hint,
                hintStyle: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey.shade400,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formInput2(String title, String hint, TextEditingController controller, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color.fromARGB(255, 13, 27, 42), 
              fontWeight: FontWeight.w500,
              fontFamily: 'Custom',
              fontSize: screenWidth * 0.045,
            ),
          ),
          SizedBox(height: screenHeight * 0.008),
          Container(
            height: screenHeight * 0.12,
            child: TextFormField(
              controller: controller,
              maxLines: 3,
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey.shade400,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowSelection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selection2("Choose Court", screenWidth),
                SizedBox(height: screenHeight * 0.008),
                CustomDropdownField(
                  hint: "Court",
                  value: Court,
                  items: ["Court 1", "Court 2", "Court 3"],
                  onChanged: (val) {
                    setState(() {
                      Court = val;
                      calculateTotal();
                    });
                  },
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selection2("Court Price", screenWidth),
                SizedBox(height: screenHeight * 0.008),
                _input("${courtPrice.toStringAsFixed(0)} Ks", screenWidth, screenHeight, enabled: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowTimeSlot(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selection2("Choose Time Slot", screenWidth),
                SizedBox(height: screenHeight * 0.008),
                CustomDropdownField(
                  hint: "Time Slot",
                  value: TimeSlot,
                  items: [
                    "6:00 - 7:00",
                    "7:30 - 8:30",
                    "9:00 - 10:00",
                    "16:30 - 17:30",
                    "18:00 - 19:00",
                    "20:30 - 21:30",
                  ],
                  onChanged: (val) {
                    setState(() {
                      TimeSlot = val;
                      calculateTotal();
                    });
                  },
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selection2("Session Price", screenWidth),
                SizedBox(height: screenHeight * 0.008),
                _input("${sessionPrice.toStringAsFixed(0)} Ks", screenWidth, screenHeight, enabled: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(String text, double screenWidth, double screenHeight, {bool enabled = true}) {
    return Container(
      height: screenHeight * 0.06,
      child: TextFormField(
        enabled: enabled,
        initialValue: text,
        style: TextStyle(
          fontFamily: "Custom",
          color: Colors.white,
          fontSize: screenWidth * 0.04,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 13, 27, 42),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _dateInput(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _selection2("Booking Date", screenWidth),
          SizedBox(height: screenHeight * 0.008),
          TextFormField(
            controller: dobController,
            readOnly: true,
            onTap: _selectDate,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            ),
            decoration: InputDecoration(
              hintText: "Booking Date (YYYY-MM-DD)",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.035,
              ),
              prefixIcon: Icon(Icons.calendar_today, color: Colors.white, size: screenWidth * 0.05),
              filled: true,
              fillColor: const Color.fromARGB(255, 13, 27, 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selection2(String main, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      child: Text(
        main,
        style: TextStyle(
          fontFamily: "Custom",
          color: const Color.fromARGB(255, 13, 27, 42),
          fontSize: screenWidth * 0.04,
        ),
      ),
    );
  }

  Widget _confirm(double screenWidth, double screenHeight) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.015,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => rentalPayment(),
            ),
          );
        },
        child: Text(
          "Confirm",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final double screenWidth;
  final double screenHeight;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.06,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: "Custom",
              fontSize: screenWidth * 0.035,
            ),
          ),
          value: value,
          dropdownColor: const Color(0xFF0F1E2E),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: screenWidth * 0.05),
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.04,
          ),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}