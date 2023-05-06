import 'package:flutter/material.dart';
import 'package:transactions/transaction.dart';
import 'package:transactions/bill.dart';
import 'package:transactions/connect.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final List<Widget> transactions = [];
  bool hasReceivedTransactions = false;
  bool hasReceivedBalance = false;

  Future getTransactions() async {
    if(!hasReceivedTransactions) {
      transactions.clear();
      WidgetsFlutterBinding.ensureInitialized();
      var db = FirebaseFirestore.instance;
      CollectionReference users = db.collection('transactions');
      QuerySnapshot querySnapshot = await users.get();
      for (var doc in querySnapshot.docs) {
        dynamic data = doc.data();
        if(data["title"] != null) {
          double amount = 0;
          if(data["amount"].runtimeType == String) {
            amount = double.parse(data["amount"]);
          }
          else if(data["amount"].runtimeType == int) {
            amount = data["amount"].toDouble();
          }
          else if(data["amount"].runtimeType == double) {
            amount = data["amount"];
          }
          
          transactions.add(
            TransactionWidget(
              title: data["title"],
              imagePath: data["icon"],
              date: data["date"],
              amount: amount,
            )
          );
          transactions.add(const SizedBox(height: 10));
        }
      }
      setState(() {
        hasReceivedTransactions = true;
        print("got transactions");
      });
    }
  }

  var balance = 0;
  Future getBalance() async {
    if(!hasReceivedBalance) {
      var db = FirebaseFirestore.instance;
      DocumentReference docRef = db.collection('user').doc('archerdoc13@gmail.com');
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        setState(() {
          balance = int.parse(doc["balance"]);
          print(balance);
          hasReceivedBalance = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getTransactions();
    getBalance();
    
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
      children: [
        const Text(
          "Total Balance",
          style: TextStyle(fontSize: 15, color: Colors.black54)
        ),
        SizedBox(height: 10),
        Text(
          "\$$balance.00",
          style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)
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
          heroTag: "adfvdfvd",
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
          heroTag: "adfvdfvderer",
          elevation: 0,
          backgroundColor: Colors.white,
          onPressed: (){}, 
          shape: floatingButtonBorder,
          child: Icon(Icons.qr_code, size: 24, color: accentColor),
        ),
        const SizedBox(width: 25),
        FloatingActionButton(
          heroTag: "adfvdfvdvvcc",
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
            padding: const EdgeInsets.all(10),
            width: 150,
            child: const Text('Transactions', textAlign: TextAlign.center)
          ), 
          Container(
            padding: const EdgeInsets.all(10),
            width: 150,
            child: const Text('Upcoming Bills',  textAlign: TextAlign.center)
          ), 
        ],
      ),
    );
  }

  List<Widget> bills = const [
    BillWidget(
        title: "Netflix",
        imagePath: "assets/images/netflix.png",
        date: "01/05/2023",
    ),
    SizedBox(height: 10),
    BillWidget(
      title: "Youtube",
      imagePath: "assets/images/youtube.png",
      date: "01/05/2023",
    ),
    SizedBox(height: 10),
    BillWidget(
      title: "Youtube",
      imagePath: "assets/images/youtube.png",
      date: "01/05/2023",
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