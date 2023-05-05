import 'package:flutter/material.dart';
import 'package:transactions/transaction.dart';
import 'package:transactions/bill.dart';
import 'package:transactions/connect.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({
    super.key,
    required this.carousel
  });

  final CarouselController carousel;
  @override
  State<WalletWidget> createState() => _WalletWidgetState();
  
}

class _WalletWidgetState extends State<WalletWidget> {

  Color mainColor = const Color.fromRGBO(94, 143, 140, 1);
  bool isConnect = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Stack(
        children: [
          topBox(),
          mainArea()
        ],
      )
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: (){
          if(isConnect) {
            isConnect = false;
            setState(() {});
          } else {
            widget.carousel.jumpToPage(0);
          }
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: Colors.white.withOpacity(0),
      elevation: 0,
      foregroundColor: Colors.white,
      title: isConnect ? const Text("Connect Wallet") : const Text("Wallet"),
    );
  }

  Widget topBox() {
    return const Positioned(
      top: 0,
      child: Image(image: AssetImage("assets/images/top.png")),
    );
  }
  
  Widget mainArea() {
    return Column(
      children: [
        const SizedBox(height: 150),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: Colors.white70,
            ),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: isConnect ? const ConnectCardPage()  : mainContent()
          ),
        )
      ],
    );
  }

  Widget mainContent() {
    return Column(
      children: [
        totalBalance(),
        const SizedBox(height: 25),
        floatingButtons(),
        const SizedBox(height: 25),
        toggleButton(),
        const SizedBox(height: 25),
        Align(
          alignment: Alignment.topCenter,
          child: toggledContents()
        )
      ],
    );
  }

  Widget totalBalance() {
    return Column(
      children: const [
        Text(
          "Total Balance",
          style: TextStyle(fontSize: 15, color: Colors.black54)
        ),
        SizedBox(height: 10),
        Text(
          "\$2,548.00",
          style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)
        )
      ],
    );
  }

  Color accentColor = const Color.fromRGBO(85, 134, 131, 1);
  Widget floatingButtons() {
    ShapeBorder floatingButtonBorder = RoundedRectangleBorder(
      side: BorderSide(
        width: 1, 
        color: accentColor
      ),
      borderRadius: BorderRadius.circular(100)
      );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.white,
          onPressed: () {
            isConnect = true;
            setState(() {});
          }, 
          shape: floatingButtonBorder,
          child: Icon(Icons.add, size: 24, color: accentColor),
        ),
        const SizedBox(width: 25),
        FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.white,
          onPressed: (){}, 
          shape: floatingButtonBorder,
          child: Icon(Icons.qr_code, size: 24, color: accentColor),
        ),
        const SizedBox(width: 25),
        FloatingActionButton(
          elevation: 0,
          onPressed: (){}, 
          backgroundColor: Colors.white,
          shape: floatingButtonBorder,
          child: Icon(Icons.send, size: 24, color: accentColor),
        ),
      ],
    );
  }

  final List<bool> _toggleSelected = <bool>[true, false];

  Widget toggleButton() {
    return Container(
      height: 50,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ToggleButtons(
        selectedColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
        fillColor: accentColor,
        isSelected: _toggleSelected,
        onPressed: (value) {
          if(value == 0) {
            _toggleSelected[0] = true;
            _toggleSelected[1] = false;
          } else {
            _toggleSelected[1] = true;
            _toggleSelected[0] = false;
          }
          setState(() {});
        },
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: 150,
            child: const Text('Transactions', textAlign: TextAlign.center)
          ), 
          Container(
            padding: EdgeInsets.all(10),
            width: 150,
            child: const Text('Upcoming Bills',  textAlign: TextAlign.center)
          ), 
        ],
      ),
    );
  }

  List<Widget> transactions = [
    TransactionWidget(
        title: "Netflix",
        imagePath: "assets/images/netflix.jpg",
        date: DateTime(2002),
        amount: 15,
    ),
    const SizedBox(height: 10),
    TransactionWidget(
      title: "Youtube",
      imagePath: "assets/images/youtube.png",
      date: DateTime(2002),
      amount: -15,
    ),
    const SizedBox(height: 10),
    TransactionWidget(
      title: "Youtube",
      imagePath: "assets/images/youtube.png",
      date: DateTime(2002),
      amount: -15,
    ),
  ];

  List<Widget> bills = [
    BillWidget(
        title: "Netflix",
        imagePath: "assets/images/netflix.jpg",
        date: DateTime(2002),
    ),
    const SizedBox(height: 10),
    BillWidget(
      title: "Youtube",
      imagePath: "assets/images/youtube.png",
      date: DateTime(2002),
    ),
    const SizedBox(height: 10),
    BillWidget(
      title: "Youtube",
      imagePath: "assets/images/youtube.png",
      date: DateTime(2002),
    ),
  ];

  Widget toggledContents() {
    return Container(
      height: 300,
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          children: _toggleSelected[0] ? 
          transactions :
          bills
        )
      )
    );
  }
}