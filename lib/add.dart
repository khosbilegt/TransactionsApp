import 'package:flutter/material.dart';

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
          height: MediaQuery.of(context).size.height * 0.6,
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

  Widget mainContent() {
    return Column(
      children: [
        dropdownButton(),
        const SizedBox(height: 25),
        TextField(
          controller: amountController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            label: const Text('Amount'),
            hintText: '\$10.0',
            suffixIcon: IconButton(
              onPressed: amountController.clear,
              icon: const Icon(Icons.clear),
            ),
          ),
          textInputAction: TextInputAction.continueAction,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 25),
        TextField(
          controller: dateController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
            label: const Text('Date'),
            hintText: '01/05/2023',
            suffixIcon: IconButton(
              onPressed: dateController.clear,  
              icon: const Icon(Icons.clear),
            ),
          ),
          textInputAction: TextInputAction.continueAction,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          child: ElevatedButton(
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
}