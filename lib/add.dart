import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Color mainColor = const Color.fromRGBO(94, 143, 140, 1);
  
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
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: mainContent()
          ),
        )
      )
    );
  }  

  var amountController = TextEditingController();
  var dateController = TextEditingController();
  var borderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(85, 134, 131, 1), width: 1.5),
  );
  var borderLabelStyle = const TextStyle(
    color: Colors.black45,
    fontSize: 17,
    fontWeight: FontWeight.w500
  );

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
          controller: amountController,
          decoration: InputDecoration(
            focusedBorder: borderStyle,
            border: const OutlineInputBorder(),
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
          controller: dateController,
          decoration: InputDecoration(
            focusedBorder: borderStyle,
            border: const OutlineInputBorder(),
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
              Navigator.pop(context);
            },
            child: const Text("Add")
          ),
        ),
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
    return DropdownMenuItem<String>(
      value: value,
      child: Row(
        children: [
          const Image(
            image: AssetImage("assets/images/netflix.jpg"),
            height: 30,
          ),
          Text(value)
        ],
      ),
    );
  }

  Widget topBox() {
    return Positioned(
      top: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(
            color: mainColor,
          ),
          color: mainColor,
        ),
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 75,
            horizontal: 25
          ),
          child: Text(""),
        ),
      )
    );
  }

  Widget invoiceButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        child: TextButton(
          onPressed: () => {print("Clicked")},
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
}
/*
ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white
        ),
        onPressed: (){}, 
        child: Text("Test", style: borderLabelStyle)
      )
      */
