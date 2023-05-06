import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:transactions/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.carousel});

  final CarouselController carousel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Color balanceCardColor = const Color.fromRGBO(70, 124, 121, 1);
  final Color helloCardColor = const Color.fromRGBO(77, 135, 131, 1);
  final List<Widget> transactions = [];
  bool hasReceived = false;

  Future getTransactions() async {
    if(!hasReceived) {
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
        hasReceived = true;
        print("got transactions");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getTransactions();

    return SingleChildScrollView(
      child: Stack(
        children: [
          helloBox(),
          notificationsButton(),
          Center (
            child: mainArea()
          ),
        ]
      )
    );
  }

  Widget mainArea() {
    return Column(
      children: [
        const SizedBox(height: 150),
        balanceBox(),
        transactionHistory(),
      ]
    );
  }

  Widget balanceBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        border: Border.all(
          color: balanceCardColor,
        ),
        color: balanceCardColor,
      ),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          totalBalanceText(),
          totalBalanceAmount(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              balanceBoxIncome(),
              balanceBoxExpense()
            ],
          ),
        ],
      ),
    );
  }

  Widget totalBalanceText() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Total Balance:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),  
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: (){}, 
                  backgroundColor: Colors.white.withOpacity(0),
                  elevation: 0,
                  child: const Icon(
                    Icons.arrow_upward,
                    size: 15,
                  )
                ),
              ),
            ]
          ),
          SizedBox(
            width: 40,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white.withOpacity(0),
              elevation: 0,
              onPressed: () {}, 
              child: const Icon(Icons.more_horiz)
            )
          ),
        ]
      )
    );
  }

  Widget totalBalanceAmount() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "\$2,500",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )
      ),
    );
  }

  Widget balanceBoxIncome() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(94, 143, 140, 1),
                  onPressed: (){},
                  child: const Icon(Icons.arrow_downward, size: 15),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Income",
                style: TextStyle(color: Colors.white, fontSize: 20)
              )
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "\$1,840", 
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget balanceBoxExpense() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(94, 143, 140, 1),
                  onPressed: (){},
                  child: const Icon(Icons.arrow_upward, size: 15),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Expense",
                style: TextStyle(color: Colors.white, fontSize: 20)
              )
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "\$1,840", 
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget transactionHistory() {
    return SizedBox(
      height:  MediaQuery.of(context).size.height - 350,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Transactions History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              TextButton(
                onPressed: (){
                  widget.carousel.jumpToPage(2);
                }, 
                child: const Text(
                  "See all",
                  style: TextStyle(color: Colors.black45)
                )
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 450,
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];
                return transaction;
              },
            )
          ),
        ],
      ),
    );
  }

  Widget helloBox() {
    return Positioned(
      top: 0,
      child: Stack(
        children: [
          const Image(image: AssetImage("assets/images/top.png")),
          Padding(
            padding: const EdgeInsets.symmetric(
            vertical: 75,
            horizontal: 25,
          ),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: const [
               Text(
                 "Good afternoon,",
                 style: TextStyle(color: Colors.white, fontSize: 15),
               ),
               Text(
                 "Khosbilegt Bilegsaikhan",
                 style: TextStyle(color: Colors.white, fontSize: 25),
               ),
             ],
           ),
          )
        ],
      ),
    );
  }

  Widget notificationsButton() {
    return Positioned(
      top: 90,
      right: 25,
      child: SizedBox(
        height: 40,
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: const Color.fromRGBO(94, 143, 140, 1),
          elevation: 1,
          onPressed: () {},
          child: const Icon(Icons.notifications),
        ),
      )
    );
  }

  Widget sendAgain() {
    return Row(
      children: [
        FloatingActionButton(onPressed: () {}, child: const Image(image: AssetImage("assets/images/youtube.png")))
      ],
    );
  }
}
