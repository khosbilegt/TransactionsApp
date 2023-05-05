import 'package:flutter/material.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({
    super.key
  });

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {

  Color mainColor = const Color.fromRGBO(94, 143, 140, 1);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
      appBar: appBar(),
      body: Column(
        children: [
          topBox(),
          const Text("Text")
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0),
      elevation: 0,
      foregroundColor: Colors.white,
      title: const Text("Add Expense"),
    );
  }

    Widget topBox() {
    return Positioned(
      top: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(
            color: mainColor,
          ),
          color: mainColor,
        ),
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 75,
            horizontal: 25
          ),
          child: Text(""),
        ),
      )
    );
  }
}