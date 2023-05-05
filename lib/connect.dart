import 'package:flutter/material.dart';

class ConnectCardPage extends StatefulWidget {
  const ConnectCardPage({super.key});

  @override
  State<ConnectCardPage> createState() => _ConnectCardPageState();
}

class _ConnectCardPageState extends State<ConnectCardPage> {
  
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
            width: 150,
            child: const Text('Cards', textAlign: TextAlign.center)
          ), 
          Container(
            width: 150,
            child: const Text('Accounts',  textAlign: TextAlign.center)
          ), 
        ],
      ),
    );
  }

  Widget toggleContents() {
    return _toggleSelected[0] ? 
    cardContents()
    : 
    accountContents();
  }

  Widget cardContents() {
    return Column(
      children: [
        const SizedBox(height: 15),
        cardView(),
        const SizedBox(height: 15),
        cardEditors(),
      ],
    );
  }

  TextStyle numberStyle = const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Comme');
  TextStyle nameStyle = const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Comme');
  Widget cardView() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8 * 0.56,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Debit\nCard",
                style: TextStyle(color: Colors.white, fontSize: 15)
              ),
              Text(
                "Mono",
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(
            height: 30,
            child: Image(image: AssetImage("assets/images/chip.png")),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(debit1, style: numberStyle),
              Text(debit2, style: numberStyle),
              Text(debit3, style: numberStyle),
              Text(debit4, style: numberStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: nameStyle),
              const SizedBox(width: 10),
              Text(expiration, style: nameStyle),
            ],
          ),
        ],
      )
    );
  }
 
 var borderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(85, 134, 131, 1), width: 1.5),
  );
  var borderLabelStyle = const TextStyle(
    color: Colors.black45,
    fontSize: 12,
    fontWeight: FontWeight.w500
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController debitController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController expirationController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  String name = "John Doe";
  String debit1 = "0000";
  String debit2 = "0000";
  String debit3 = "0000";
  String debit4 = "0000";
  String expiration = "01/23";
  Widget cardEditors() {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            focusedBorder: borderStyle,
            border: const OutlineInputBorder(),
            hintText: 'John Doe',
            label: Text("NAME ON CARD", style: borderLabelStyle)
          ),
          textInputAction: TextInputAction.continueAction,
          keyboardType: TextInputType.name,
          onChanged: (value) => {
            setState(() {
              name = value;
            })
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextField(
              controller: debitController,
              decoration: InputDecoration(
                focusedBorder: borderStyle,
                border: const OutlineInputBorder(),
                hintText: '0000 0000 0000',
                label: Text("DEBIT CARD NUMBER", style: borderLabelStyle)
              ),
              textInputAction: TextInputAction.continueAction,
              keyboardType: TextInputType.number,
              onChanged: (value) => {
                setState(() {
                  if(value.length <= 4) {
                    debit1 = value;
                  }
                  if(4 < value.length && value.length <= 8) {
                    debit1 = value.substring(0, 4);
                    debit2 = value.substring(4);
                  }
                  if(8 < value.length && value.length <= 12) {
                    debit1 = value.substring(0, 4);
                    debit2 = value.substring(4, 8);
                    debit3 = value.substring(8);
                  }
                  if(value.length >= 12) {
                    debit1 = value.substring(0, 4);
                    debit2 = value.substring(4, 8);
                    debit3 = value.substring(8, 12);
                    debit4 = value.substring(12);
                  }
                })
              },
            ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextField(
              controller: cvcController,
              decoration: InputDecoration(
                focusedBorder: borderStyle,
                border: const OutlineInputBorder(),
                hintText: '000',
                label: Text("CVC", style: borderLabelStyle)
              ),
              textInputAction: TextInputAction.continueAction,
              keyboardType: TextInputType.number,
            ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextField(
              controller: expirationController,
              decoration: InputDecoration(
                focusedBorder: borderStyle,
                border: const OutlineInputBorder(),
                hintText: '01/23',
                label: Text("EXPIRATION MM/YY", style: borderLabelStyle)
              ),
              textInputAction: TextInputAction.continueAction,
              keyboardType: TextInputType.datetime,
              onChanged: ((value) => {
                setState(() {
                  RegExp r = RegExp(r"^\d{2}/\d{2}$");
                  if (r.hasMatch(value)) {
                    expiration = value;
                  }
                })
              }),
            ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextField(
              controller: zipController,
              decoration: InputDecoration(
                focusedBorder: borderStyle,
                border: const OutlineInputBorder(),
                hintText: '000',
                label: Text("ZIP", style: borderLabelStyle)
              ),
              textInputAction: TextInputAction.continueAction,
              keyboardType: TextInputType.number,
            ),
            ),
          ],
        ),
      ],
    );
  }

  Widget accountContents() {
    return Column(
      children: [
        const SizedBox(height: 30),
        accountTypeButton(Icons.account_balance, "Bank Link", "Connect your bank account to deposit & fund", 0),
        const SizedBox(height: 30),
        accountTypeButton(Icons.paid_outlined, "Microdeposits", "Connect bank in 5-7 days", 1),
        const SizedBox(height: 30),
        accountTypeButton(Icons.paypal, "Paypal", "Connect you paypal account", 2),
        const SizedBox(height: 50),
        accountNextButton()
      ],
    );
  }

  int activeAccountIndex = 0;
  Widget accountTypeButton(IconData icon, String title, String explanation, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          activeAccountIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              child: FloatingActionButton(
                onPressed: (){},
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: activeAccountIndex == index ? accentColor : Colors.black38,
                child: Icon(icon, size: 30),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: activeAccountIndex == index ? accentColor : Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    explanation,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: activeAccountIndex == index ? accentColor : Colors.black38,
                      fontSize: 13
                    ),
                  )
                ),
              ],
            ),
            activeAccountIndex == index ? 
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.check_circle, color: accentColor, size: 30),
            )
            :
            Text("")
          ],
        )
      )
    );
  }

  Widget accountNextButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: accentColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: BorderSide(
            color: accentColor,
          ),
        ),
        child: const Text("Next")
      ),
    );
  }
}