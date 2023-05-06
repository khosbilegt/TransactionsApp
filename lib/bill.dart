import 'package:flutter/material.dart';

class BillWidget extends StatefulWidget {
  const BillWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.date,
  });


  final String title;
  final String imagePath;
  final String date;

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