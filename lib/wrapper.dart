import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transactions/add.dart';
import 'package:transactions/home.dart';
//import 'package:transactions/onboard.dart';
import 'package:transactions/wallet.dart';

class WrapperWidget extends StatefulWidget {
  const WrapperWidget({
    super.key,
  });

  @override
  State<WrapperWidget> createState() => _WrapperWidgetState();
}

class _WrapperWidgetState extends State<WrapperWidget> {

  CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  bool isOnboard = false;
  
  @override
  Widget build(BuildContext context) {
    checkOnboard();
    if(currentIndex == 0) {
      return Scaffold(
        body: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            onPageChanged:(index, reason) => {
              currentIndex = index,
              setState(() {}),
            },
          ),
          items: <Widget>[
            HomePage(carousel: carouselController),
            HomePage(carousel: carouselController),
            WalletWidget(carousel: carouselController),
            HomePage(carousel: carouselController),
          ]
        ),
        bottomNavigationBar: bottomBar(),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    } else {
      return Scaffold(
        body: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            onPageChanged:(index, reason) => {
              currentIndex = index,
              setState(() {}),
            },
          ),
          items: <Widget>[
            HomePage(carousel: carouselController),
            HomePage(carousel: carouselController),
            WalletWidget(carousel: carouselController),
            HomePage(carousel: carouselController),
          ]
        ),
        bottomNavigationBar: bottomBar(),
      );
    }
  }
  
  Widget bottomBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(), //shape of notch
      notchMargin: 5, //notche margin between floating button and bottom appbar
      child: Row( //children inside bottom appbar
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          bottomButton(const Icon(Icons.home_outlined), 0),
          bottomButton(const Icon(Icons.leaderboard_outlined), 1),
          bottomButton(const Icon(Icons.account_balance_wallet_outlined), 2),
          bottomButton(const Icon(Icons.person_outline_outlined), 3),
        ],
      ),
    );
  }
  Widget bottomButton(Icon icon, int index) {
    return IconButton(
      onPressed: () {
        currentIndex = index;
        carouselController.jumpToPage(index);
        setState(() {});
      },
      icon: icon,
      color: index == currentIndex ? Colors.green.shade300 : Colors.black45,
    );
  }

  Future<void> checkOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? onboard = prefs.getBool("onboard");
    isOnboard = onboard!;
  }
}