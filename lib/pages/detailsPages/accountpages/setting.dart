import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  double get screenWidth => MediaQuery.of(context).size.width;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              SizedBox(height: 10),
              _menuItem(
                  Icons.key,
                  "Privacy and Security",() {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                ),
              _visibalSetting(),
              _menuItem(
                  Icons.language,
                  "Languages",() {},
                ),
              _menuItem(
                  Icons.auto_stories,
                  "Auto Save E-Receipt",() {},
                ),
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
                "Setting", 
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

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 27, 42),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: Color.fromARGB(255, 255, 255, 255)),
          title: Text(title, style: TextStyle(fontFamily: 'Custom',color: Colors.white),),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white, ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _visibalSetting(){
    return Column(
      children: [
        if (isVisible)
          Column(
            children: [
              Text(
                "Hello Flutter",
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "Hello Flutter",
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "Hello Flutter",
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
      ],
    );
  }
}