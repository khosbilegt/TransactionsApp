import 'package:flutter/material.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.date,
    required this.amount,
  });


  final String title;
  final String imagePath;
  final DateTime date;
  final double amount;

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    String amountText = "";
    if(widget.amount > 0) {
      amountText = "+ \$${widget.amount}";
    } else {
      amountText = "- \$${widget.amount.abs()}";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        transactionDetails(),
        Text(
          amountText,
          style: TextStyle(
            color: widget.amount > 0 ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget transactionDetails() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Image(
            width: 40,
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
                fontSize: 20,
              ),
            ),
            Text(
              parseDate(),
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ]
    );
  }

  String parseDate() {
    DateTime date = widget.date;
    return "${date.day} ${convertMonth(date.month)}, ${date.year}";
  }

  String convertMonth(int month) {
    String result = "";
    switch(month) {
      case 1:
        result = "January";
        break;
      case 2:
        result = "February";
        break;
      case 3:
        result = "March";
        break;
      case 4:
        result = "April";
        break;
      case 5:
        result = "May";
        break;
      case 6:
        result = "June";
        break;
      case 7:
        result = "July";
        break;
      case 8:
        result = "August";
        break;
      case 9:
        result = "September";
        break;
      case 10:
        result = "October";
        break;
      case 11:
        result = "November";
        break;
      default:
        result = "December";
    }
    return result;
  }
}