import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_authentication/auth.dart';
import 'package:firebase_authentication/pages/cat_page.dart';
import 'package:firebase_authentication/pages/favorite_page.dart';
import 'package:firebase_authentication/pages/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  final _pageNo = [CatPage(), Favorite()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff33394e),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );

          Auth.signOut();
        },
        child: Icon(
          Icons.logout_rounded,
          color: Colors.white,
        ),
      ),
      body: _pageNo[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xff33394e),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.favorite, title: 'Favorite'),
        ],
        initialActiveIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
