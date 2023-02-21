import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItemIndex = 1;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Body text'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: const Offset(2, 2),
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              buildNavBarItem(
                Icons.home,
                0,
              ),
              buildNavBarItem(Icons.phone, 1),
              buildNavBarItem(Icons.pages, 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? const Radius.circular(25) : Radius.zero,
            topRight: index == 2 ? const Radius.circular(25) : Radius.zero,
          ),
          color: _selectedItemIndex == index ? Colors.green : Colors.white,
        ),
        child: Icon(
          icon,
          color: _selectedItemIndex == index ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
