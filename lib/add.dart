import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Color mainColor = const Color.fromRGBO(94, 143, 140, 1);
  String errorText = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
      appBar: appBar(),
      body: Stack(
        children: [
          topBox(),
          mainArea(),
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
      actions: [
        IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})
      ]
    );
  }

  Widget mainArea() {
    return Positioned(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: Colors.white70,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: mainContent()
          ),
        )
      )
    );
  }  

  var amountController = TextEditingController();
  var dateController = TextEditingController();
  var focusedBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(85, 134, 131, 1), width: 1.5),
  );
  var errorBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
  );
  var borderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1),
  );
  var borderLabelStyle = const TextStyle(
    color: Colors.black45,
    fontSize: 17,
    fontWeight: FontWeight.w500
  );
  bool isAmountError = false;
  bool isDateError = false;

  Widget mainContent() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "NAME",
            style: borderLabelStyle,
          ),
        ),
        dropdownButton(),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "AMOUNT",
            style: borderLabelStyle,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: (value) => {
            if(double.tryParse(value) != null) {
              setState(() {
                isAmountError = false;
              })
            }
          },
          controller: amountController,
          decoration: InputDecoration(
            focusedBorder: isAmountError ? errorBorderStyle : focusedBorderStyle,
            enabledBorder: isAmountError ? errorBorderStyle : borderStyle,
            hintText: '\$10.0',
            suffixIcon: IconButton(
              onPressed: amountController.clear,
              icon: const Icon(Icons.clear),
            ),
          ),
          textInputAction: TextInputAction.continueAction,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "DATE",
            style: borderLabelStyle,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: (value) => {
            if(isDateValid(value)) {
              setState(() {
                isDateError = false;
              })
            }
          },
          controller: dateController,
          decoration: InputDecoration(
            focusedBorder: isDateError ? errorBorderStyle : focusedBorderStyle,
            enabledBorder: isDateError ? errorBorderStyle : borderStyle,
            hintText: '01/05/2023',
            suffixIcon: IconButton(
              onPressed: dateController.clear,  
              icon: const Icon(Icons.clear),
            ),
          ),
          textInputAction: TextInputAction.continueAction,
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 25),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "INVOICE",
            style: borderLabelStyle,
          ),
        ),
        const SizedBox(height: 10),
        invoiceButton(),
        const SizedBox(height: 40),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(85, 134, 131, 1), elevation: 0),
            onPressed: () {
              addTransaction();
            },
            child: const Text("Add")
          ),
        ),
        const SizedBox(height: 15),
        Text(errorText, style: TextStyle(color: Colors.red, fontSize: 20))
      ],
    );
  }


  String? dropdownvalue = 'Netflix'; 
  Widget dropdownButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButton(
        value: dropdownvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: [
          dropdownItem("Apple"),
          dropdownItem("Youtube"),
          dropdownItem("Amazon"),
          dropdownItem("Spotify"),
          dropdownItem("Paypal"),
          dropdownItem("Netflix")
        ],
        onChanged: (value) {
          setState(() {
            dropdownvalue = value!;
          });
        }
      )
    );
  }

  DropdownMenuItem<String> dropdownItem(String value) {
    String imagePath = "assets/images/$value.png";

    return DropdownMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Image(
            image: AssetImage(imagePath.toLowerCase()),
            width: 30,
          ),
          const SizedBox(width: 20),
          Text(value)
        ],
      ),
    );
  }

  Widget topBox() {
    return const Positioned(
      top: 0,
      child: Image(image: AssetImage("assets/images/top.png")),
    );
  }

  Widget invoiceButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        child: TextButton(
          onPressed: () => { },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_circle, color: Colors.black45),
              const SizedBox(width: 10),
              Text('Download', style: borderLabelStyle)
            ],
          ), // <-- Text
        ),
      )
    );
  }

  bool isDateValid(String input) {
    const datePattern = r'^\d{2}\/\d{2}\/\d{4}$';
    final regExp = RegExp(datePattern);
    bool isFormatted = regExp.hasMatch(input);
    if(isFormatted) {
      if(int.parse(input.substring(0, 2)) > 31 || int.parse(input.substring(3, 5)) < 0) {
        return false;
      }
      if(int.parse(input.substring(3, 5)) > 12 || int.parse(input.substring(3, 5)) < 0) {
        print(int.parse(input.substring(3, 5)));
        return false;
      }
    }
    return isFormatted;
  }

  Future addTransaction() async {
    // Validate Amount
    if(double.tryParse(amountController.value.text) == null) {
      setState(() {
        errorText = "Invalid Amount";
        isAmountError = true;
      });
      return;
    }
    setState(() {
      isAmountError = false;
    });
    // Validate Date
    if(!isDateValid(dateController.text.trim())) {
      setState(() {
        errorText = "Invalid Date";
        isDateError = true;
      });
      return;
    }
    setState(() {
      isDateError = false;
      errorText = "";
    });
    WidgetsFlutterBinding.ensureInitialized();
    var db = FirebaseFirestore.instance;
    final transaction = <String, dynamic>{
      "amount": amountController.value.text,
      "date": dateController.value.text,
      "title": dropdownvalue,
      "icon": "assets/images/$dropdownvalue.png".toLowerCase()
    };
    db.collection("transactions").add(transaction).then((doc) => {
      print('DocumentSnapshot added with ID: ${doc.id}'),
      Navigator.pop(context)
    });
  }
}