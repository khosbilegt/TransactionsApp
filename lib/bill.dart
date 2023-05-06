import 'package:flutter/material.dart';
import 'package:transactions/bill_payment.dart';

class BillWidget extends StatefulWidget {
  const BillWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.date,
    required this.amount,
    required this.name
  });

  final String title;
  final String imagePath;
  final String date;
  final String name;
  final double amount;

  @override
  State<BillWidget> createState() => _BillWidgetState();
}

class _BillWidgetState extends State<BillWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        billDetails(),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromRGBO(238, 249, 249, 1),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BillPaymentPage(
                  amount: widget.amount,
                  title: widget.title,
                  name: widget.name,
                  date: widget.date
                )),
              );
            }, 
            child: const Text(
              "Pay", 
              style: TextStyle(color: Color.fromRGBO(85, 134, 131, 1), fontSize: 16)
            )
          )
        )
      ],
    );
  }

  Widget billDetails() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Image(
            width: 35,
            image: AssetImage(widget.imagePath),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              widget.date,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14
              ),
            ),
          ],
        ),
      ]
    );
  }
}