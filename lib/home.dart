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
  bool hasReceivedTransactions = false;
  bool hasReceivedBalance = false;
  bool isTotalBalanceHidden = false;

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
        }
      }
      transactions.sort((a, b) {
        DateTime aDate = DateTime.parse((a as TransactionWidget).date.split("/").reversed.join());
        DateTime bDate = DateTime.parse((b as TransactionWidget).date.split("/").reversed.join());
        return bDate.compareTo(aDate);
      });
      transactions.removeRange(6, transactions.length);
      calculateIncomeExpense();
      for (int i = 1; i < transactions.length; i += 2) {
        transactions.insert(i, const SizedBox(height: 10));
      }
      setState(() {
        hasReceivedTransactions = true;
        print("got transactions");
      });
    }
  }

  double income = 0;
  double expense = 0;
  void calculateIncomeExpense() {
    for(int i = 0; i < transactions.length; i++) {
      double amount = (transactions[i] as TransactionWidget).getAmount;
      if(amount > 0) {
        income += amount;
      } else {
        expense += amount.abs();
      }
    }
    print(income);
    print(expense);
  }

  var balance = 0;
  Future getBalance() async {
    if(!hasReceivedBalance) {
      var db = FirebaseFirestore.instance;
      DocumentReference docRef = db.collection('user').doc('archerdoc13@gmail.com');
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        setState(() {
          if(doc["balance"].runtimeType == String) {
            balance = int.parse(doc["balance"]);
          }
          if(doc["balance"].runtimeType == int) {
            balance = doc["balance"];
          }
          hasReceivedBalance = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getTransactions();
    getBalance();

    return SingleChildScrollView(
      child: Stack(
        children: [
          helloBox(),
          notificationsButton(),
          Center (
            child: mainArea()
          ),
          sendAgain()
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
      height: isTotalBalanceHidden ? 130 : 200,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          totalBalanceText(),
          isTotalBalanceHidden ? const Text("") :
          totalBalanceAmount(),
          isTotalBalanceHidden ? const Text("") :
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
                  heroTag: "fdfdwwr",
                  onPressed: (){
                    setState(() {
                      isTotalBalanceHidden = !isTotalBalanceHidden;
                    });
                  }, 
                  backgroundColor: Colors.white.withOpacity(0),
                  elevation: 0,
                  child: Icon(
                    isTotalBalanceHidden ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                    size: 30,
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
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        "\$$balance.00",
        textAlign: TextAlign.start,
        style: const TextStyle(
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
          Text(
            "\$$income", 
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
          Text(
            "\$$expense", 
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
      top: 70,
      right: 15,
      child: Container(
        height: 40,
        width: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(94, 143, 140, 1),
          ),
          onPressed: () {},
          child: const Center(
            child: Icon(Icons.notifications, size: 20),
          )
        ),
      )
    );
  }

  Widget sendAgain() {
    return Positioned(
      bottom: isTotalBalanceHidden ? 10 : 80,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Send Again", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    TextButton(
                      onPressed: (() => {

                      }),
                      child: const Text("See all", style: TextStyle(fontSize: 15, color: Colors.black54)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sendButton("assets/images/person1.png"),
                    sendButton("assets/images/person2.png"),
                    sendButton("assets/images/person3.png"),
                    sendButton("assets/images/person4.png"),
                    sendButton("assets/images/person5.png"),
                  ],
                ),
              ],
            ),
        )
      )
    );
  }

  Widget sendButton(String image) {
    return FloatingActionButton(
      onPressed: () {}, 
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 200,
      )
    );
  }
}
