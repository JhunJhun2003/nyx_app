import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/servicepages/classes/classes_slip.dart';

class classesPayment extends StatefulWidget {
  final Map<String, dynamic>? enrollmentData;

  const classesPayment({super.key, this.enrollmentData});

  @override
  State<classesPayment> createState() => _classesPaymentState();
}

class _classesPaymentState extends State<classesPayment> {
  String currentOption = "";
  final TextEditingController input = TextEditingController();
  
  List<Map<String, dynamic>> _paymentMethods = [];
  bool _isLoadingPayments = true;
  String? _paymentsError;

  // Enrollment data
  String fullname = "";
  String age = "";
  String address = "";
  String phone = "";
  String email = "";
  String trainingLevel = "";
  String trainingSchedule = "";
  String trainingTitle = "";
  int price = 0;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
    _loadEnrollmentData();
  }

  void _loadEnrollmentData() {
    final data = widget.enrollmentData ?? {};
    
    setState(() {
      fullname = data['fullname'] ?? "N/A";
      age = data['age'] ?? "N/A";
      address = data['address'] ?? "Yangon, Myanmar";
      phone = data['phone'] ?? "N/A";
      email = data['email'] ?? "N/A";
      trainingLevel = data['levelName'] ?? "Beginner Level";
      trainingSchedule = data['timeSlot'] ?? "8:00 - 10:00 AM";
      trainingTitle = data['trainingTitle'] ?? "Training Program";
      price = data['price'] ?? 0;
    });
  }

  Future<void> _loadPaymentMethods() async {
    setState(() {
      _isLoadingPayments = true;
      _paymentsError = null;
    });

    try {
      // Simulate API call - Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock payment methods - Replace with actual API response
      final mockMethods = [
        {'id': 1, 'payment_method': 'CB Pay', 'payment_name': 'CB Bank Account', 'payment_number': '1234567890'},
        {'id': 2, 'payment_method': 'Kpay', 'payment_name': 'Kpay Account', 'payment_number': '09987654321'},
        {'id': 3, 'payment_method': 'WavePay', 'payment_name': 'WavePay Account', 'payment_number': '09876543210'},
        {'id': 4, 'payment_method': 'AYA Pay', 'payment_name': 'AYA Bank Account', 'payment_number': '1122334455'},
      ];
      
      setState(() {
        _paymentMethods = mockMethods;
        _isLoadingPayments = false;
        if (_paymentMethods.isNotEmpty) {
          currentOption = _paymentMethods[0]['payment_method'];
        }
      });
    } catch (e) {
      setState(() {
        _paymentsError = 'Error loading payment methods: $e';
        _isLoadingPayments = false;
      });
    }
  }

  String getSelectedPaymentName() {
    for (var method in _paymentMethods) {
      if (method['payment_method'] == currentOption) {
        return method['payment_name'] ?? 'N/A';
      }
    }
    return 'N/A';
  }

  String getSelectedPaymentNumber() {
    for (var method in _paymentMethods) {
      if (method['payment_method'] == currentOption) {
        return method['payment_number'] ?? 'N/A';
      }
    }
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 5),
              _section("Registration Information"),
              const SizedBox(height: 5),
              _information("Name", fullname),
              const SizedBox(height: 1),
              _information("Age", age),
              const SizedBox(height: 1),
              _information("Address", address),
              const SizedBox(height: 1),
              _information("Phone Number", phone),
              const SizedBox(height: 1),
              _information("Email", email),
              const SizedBox(height: 1),
              _information("Training Program", trainingTitle),
              const SizedBox(height: 1),
              _information("Training Level", trainingLevel),
              const SizedBox(height: 1),
              _information("Training Schedule", trainingSchedule),
              const SizedBox(height: 1),
              _information("Price", "$price Ks/month"),
              const SizedBox(height: 10),
              _section("Select Payment Method"),
              const SizedBox(height: 5),
              _paymentMethod(),
              const SizedBox(height: 5),
              _paymentInfo(),
              const SizedBox(height: 10),
              _input("Enter transaction number"),
              const SizedBox(height: 10),
              _confirm(),
              const SizedBox(height: 30),
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

  Widget _paymentMethod() {
    if (_isLoadingPayments) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_paymentsError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                _paymentsError!,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loadPaymentMethods,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      child: Column(
        children: _paymentMethods.map((method) {
          return ListTile(
            title: Text(
              method['payment_method'],
              style: const TextStyle(
                fontFamily: 'Custom',
                color: Color.fromARGB(255, 13, 27, 42),
              ),
            ),
            leading: Radio(
              value: method['payment_method'],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _paymentInfo() {
    if (currentOption.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$currentOption Name :",
                style: const TextStyle(
                  fontFamily: 'Custom',
                  color: Color.fromARGB(255, 13, 27, 42),
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 50),
              Text(
                getSelectedPaymentName(),
                style: const TextStyle(
                  fontFamily: 'Custom',
                  color: Color.fromARGB(255, 13, 27, 42),
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$currentOption Number :",
                style: const TextStyle(
                  fontFamily: 'Custom',
                  color: Color.fromARGB(255, 13, 27, 42),
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 33),
              Text(
                getSelectedPaymentNumber(),
                style: const TextStyle(
                  fontFamily: 'Custom',
                  color: Color.fromARGB(255, 13, 27, 42),
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _input(String text) {
    return Center(
      child: Container(
        height: 50,
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          controller: input,
          style: const TextStyle(
            fontFamily: "Custom",
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          decoration: InputDecoration(
            hintText: text,
            filled: true,
            fillColor: const Color.fromARGB(255, 13, 27, 42),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirm() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          fixedSize: const Size(200, 50),
        ),
        onPressed: () {
          final paymentData = {
            'enrollmentData': widget.enrollmentData,
            'paymentMethod': currentOption,
            'transactionNumber': input.text.trim(),
            'paymentInfo': {
              'name': getSelectedPaymentName(),
              'number': getSelectedPaymentNumber(),
            },
          };
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => classesSlip(paymentData: paymentData),
            ),
          );
        },
        child: const Text(
          "Confirm Payment",
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