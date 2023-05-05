import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transactions/home.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  
  TextStyle textStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(106, 157, 152, 1),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        const Image(image: AssetImage("assets/images/onboard.png")),
        Text("Spend Smarter", style: textStyle),
        Text("Save More", style: textStyle),
        const SizedBox(height: 25),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(106, 157, 152, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage(title: "")),
              );
            }, 
            child: const Text("Get Started")
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(
              onPressed: (){
                setOnboard();
              }, 
              child: const Text("Log in")
            )
          ],
        )
      ],
    );
  }

  Future<void> setOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboard", true);
    //print("Sets Onboard");
  }
}