import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isSwitch = false;
  bool? isCheckbox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  debugPrint("Icon Action");
                },
                icon: const Icon(Icons.info_outline) )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/auntyd.png'),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: Colors.black),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                color: Colors.blueGrey,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    "Schedule visit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    debugPrint("Outlined button");
                  },
                  child: const Text("Outlined Button")),
              ElevatedButton(
                  onPressed: () {
                    debugPrint("Elevated button");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isSwitch ? Colors.blue : Colors.green),
                  child: const Text("Elevated Button")),
              // TextButton(
              //     onPressed: () {
              //       debugPrint("Text button");
              //     },
              //     child: const Text("Text Button")),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  debugPrint("This is the row");
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.blue,
                    ),
                    Text("Row Widget"),
                    Icon(Icons.local_airport)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Switch(
                      value: isSwitch,
                      onChanged: (bool newBool) {
                        setState(() {
                          isSwitch = newBool;
                        });
                      }),
                  Checkbox(
                      value: isCheckbox,
                      onChanged: (bool? newBool) {
                        setState(() {
                          isCheckbox = newBool;
                        });
                      })
                ],
              ),
              Image.network('http://ricejs.com/images/headshot.jpg')
            ],
          ),
        ));
  }
}
