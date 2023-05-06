import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BillPaymentPage extends StatefulWidget {
  const BillPaymentPage({
    super.key, 
    required this.amount, 
    required this.title,
    required this.name,
    required this.date
  });

  final double amount;
  final String title;
  final String name;
  final String date;

  @override
  State<BillPaymentPage> createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  
  TextStyle textStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(106, 157, 152, 1),
  );

  bool isPaying = false;
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      extendBodyBehindAppBar: true,
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
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: Colors.black.withOpacity(0),
      elevation: 0,
      foregroundColor: Colors.white,
      title: const Text("Bill Details")
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
          height: MediaQuery.of(context).size.height - 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: Colors.white70,
            ),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: isConfirmed ? paymentSuccess() : mainContent()
          ),
        )
      ],
    );
  }

  TextStyle infoStyle = const TextStyle(
    color: Colors.black54
  );
  TextStyle priceStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400
  );
  Widget mainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        billInfo(),
        const SizedBox(height: 25),
        priceInfo(),
        const SizedBox(height: 25),
        
        isPaying 
        ? Text("") 
        : const Text(
          "Select payment method", 
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16)
        ),
        const SizedBox(height: 15),
        isPaying 
        ? const Text("") 
        : paymentMethod(),
        const SizedBox(height: 50),
        payButton()
      ],
    );
  }

  Widget priceInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price: ", style: infoStyle),
            Text("\$${widget.amount}", style: priceStyle)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fee: ", style: infoStyle),
            Text("\$1.99", style: priceStyle)
          ],
        ),
        const SizedBox(height: 25),
        CustomPaint(
          size: const Size(double.infinity, 2),
          painter: LinePainter(),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total: ", style: infoStyle),
            Text("\$${widget.amount + 1.99}", 
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
      ],
    );
  }

  Widget billInfo() {
    String billFor = widget.name;
    if(isPaying) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Image(
              height: 30,
              image: AssetImage("assets/images/${widget.title.toLowerCase()}.png")
            )
          ),
          const SizedBox(height: 15),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'You will pay ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: billFor,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: " for one month with BCA OneKlik",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ]
      );
    }
    return Row(
      children:[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Image(
            height: 20,
            image: AssetImage("assets/images/${widget.title.toLowerCase()}.png")
          )
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              billFor, 
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)
            ),
            Text(
              widget.date, 
              style: TextStyle(color: Colors.black45 ,fontSize: 12)
            )
          ],
        )
      ],
    );
  }

  Widget paymentMethod() {
    return Column(
      children: [
        paymentButton(0, Icons.payment, "Debit Card"),
        const SizedBox(height: 25),
        paymentButton(1, Icons.paypal, "Paypal")
      ],
    );
  }

  int activeType = 0;
  Color activePaymentColor = const Color.fromRGBO(237, 243, 243, 1);
  Color inactivePaymentColor = const Color.fromRGBO(250, 250, 250, 1);
  Color accentColor = const Color.fromRGBO(85, 134, 131, 1);
  Widget paymentButton(int type, IconData icon, String buttonText) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: (){
          setState(() {
            activeType = type;
          });
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: type == activeType ? activePaymentColor : inactivePaymentColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.white,
              ),
              child: Icon(icon, color: type == activeType ? accentColor : Colors.black54),
            ),
            const SizedBox(width: 10),
            Text(buttonText, style: TextStyle(color: type == activeType ? accentColor : Colors.black54)),
            const SizedBox(width: 10),
            Icon(type == activeType ?  Icons.radio_button_checked : Icons.radio_button_off, color: accentColor)
          ],
        )
      )
    );
  }

  Widget payButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          if(!isPaying) {
            setState(() {
              isPaying = true;
            });
          } else {
            addTransaction();
          }
        }, 
        child: Text(isPaying ? "Confirm and Pay" : "Pay Now")
      )
    );
  }

  Widget paymentSuccess() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Icon(Icons.check_circle, size: 30, color: accentColor)
        ),
        const SizedBox(height: 10),
        Text(
          "Payment Successful",
          style: TextStyle(
            color: accentColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )
        ),
        const Text(
          "Youtube Premium",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        transactionDetails(),
        priceInfo(),
        const SizedBox(height: 30),
        shareButton()
      ],
    );
  }

  bool isHidden = false;
  String transactionId = "";
  Widget transactionDetails() {
    DateTime now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Transaction Details ", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
            IconButton(
              onPressed: (){
                setState(() {
                  isHidden = !isHidden;
                });
              }, 
              icon: isHidden ? const Icon(Icons.arrow_drop_down_sharp) : const Icon(Icons.arrow_drop_up_sharp)
            ),
          ],
        ),
        isHidden ? Text("")
        : Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment Method: ", style: infoStyle),
                Text(activeType == 0 ? "Debit Card" : "Paypal", style: priceStyle)
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status: ", style: infoStyle),
                Text("Completed", style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w500
                  )
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time: ", style: infoStyle),
                Text('${now.hour}:${now.minute.toString().padLeft(2, '0')}', style: priceStyle)
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date: ", style: infoStyle),
                Text(DateFormat('MMM d, y').format(now), style: priceStyle)
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transaction ID: ", style: infoStyle),
                Text(transactionId, style: priceStyle)
              ],
            ),
            const SizedBox(height: 25),
            CustomPaint(
              size: const Size(double.infinity, 2),
              painter: LinePainter(),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ],
    );
  }

  Widget shareButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: accentColor),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        }, 
        child: const Text("Share Receipt")
      )
    );
  }

  Future addTransaction() async {
    DateTime now = DateTime.now();
    // Validate Amount
    WidgetsFlutterBinding.ensureInitialized();
    var db = FirebaseFirestore.instance;
    final transaction = <String, dynamic>{
      "amount": widget.amount,
      "date": DateFormat('dd/MM/yyyy').format(now),
      "title": widget.title,
      "icon": "assets/images/${widget.title}.png".toLowerCase()
    };
    db.collection("transactions").add(transaction).then((doc) => {
      print('DocumentSnapshot added with ID: ${doc.id}'),
      addBalance().then((value) => {
        Navigator.pop(context)
      })
    });
  }

  Future addBalance() async {
    var db = FirebaseFirestore.instance;
      DocumentReference docRef = db.collection('user').doc('archerdoc13@gmail.com');
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        int balance = 0;
        if(doc["balance"].runtimeType == String) {
          balance = int.parse(doc["balance"]);
        }
        if(doc["balance"].runtimeType == int) {
          balance = doc["balance"];
        }
        double newBalance = balance - widget.amount;
        await docRef.update({'balance': newBalance.toInt()});
        setState(() {
          isConfirmed = true;
        });
      }
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1;

    final start = Offset(0, size.height / 2);
    final end = Offset(size.width, size.height / 2);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}