import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  
  TextStyle textStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(106, 157, 152, 1),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        toggleButton(),
        toggleContents()
      ],
    );
  }

  final List<bool> _toggleSelected = <bool>[true, false];
  Color accentColor = const Color.fromRGBO(85, 134, 131, 1);
  Widget toggleButton() {
    return Container(
      height: 50,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ToggleButtons(
        selectedColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
        fillColor: accentColor,
        isSelected: _toggleSelected,
        onPressed: (value) {
          if(value == 0) {
            _toggleSelected[0] = true;
            _toggleSelected[1] = false;
          } else {
            _toggleSelected[1] = true;
            _toggleSelected[0] = false;
          }
          setState(() {});
        },
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: 150,
            child: const Text('Cards', textAlign: TextAlign.center)
          ), 
          Container(
            padding: EdgeInsets.all(10),
            width: 150,
            child: const Text('Accounts',  textAlign: TextAlign.center)
          ), 
        ],
      ),
    );
  }

  Widget toggleContents() {
    return _toggleSelected[0] ? Text("Cards") : Text("Accounts");
  }
}