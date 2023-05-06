import 'package:flutter/material.dart';

class BillPaymentPage extends StatefulWidget {
  const BillPaymentPage({super.key});

  @override
  State<BillPaymentPage> createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  
  TextStyle textStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(106, 157, 152, 1),
  );

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
            child: mainContent()
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
      children: [
        billInfo(),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price: ", style: infoStyle),
            Text("\$9.99", style: priceStyle)
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
            const Text("\$12.99", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
        paymentInfo()
      ],
    );
  }

  Widget billInfo() {
    return Row(
      children:[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: const Image(
            height: 20,
            image: AssetImage("assets/images/youtube.png")
          )
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Youtube Premium", 
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)
            ),
            Text(
              "Feb 28, 2022", 
              style: TextStyle(color: Colors.black45 ,fontSize: 12)
            )
          ],
        )
      ],
    );
  }

  Widget paymentInfo() {
    return Column(
      children: [
        Text("payment")
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1;

    final start = Offset(0, size.height / 2);
    final end = Offset(size.width, size.height / 2);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}