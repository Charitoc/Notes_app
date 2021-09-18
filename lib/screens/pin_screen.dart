import 'package:flutter/material.dart';

class PinScreen extends StatefulWidget {
  static const routeName = '/pin_screen';

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Security PIN',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PINNumber(controller),
                        PINNumber(controller2),
                        PINNumber(controller3),
                        PINNumber(controller4)
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    NumGrid(),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NumGrid extends StatelessWidget {
  const NumGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1 / 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumButton('1'),
              NumButton('4'),
              NumButton('7'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumButton('2'),
              NumButton('5'),
              NumButton('8'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumButton('3'),
              NumButton('6'),
              NumButton('9'),
            ],
          ),
        ],
      ),
    );
  }
}

class NumButton extends StatefulWidget {
  final String number;

  NumButton(this.number);

  @override
  _NumButtonState createState() => _NumButtonState();
}

class _NumButtonState extends State<NumButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(120),
      child: Container(
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 60.0,
              height: 60.0,
              child: Center(
                child: Text(
                  widget.number,
                  style: TextStyle(color: Colors.black, fontSize: 38),
                ),
              ),
            ),
          ),
          color: Colors.transparent,
        ),
        color: Colors.yellow[800],
      ),
    );
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;

  PINNumber(this.textEditingController);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          filled: true,
          fillColor: Colors.white30,
        ),
      ),
    );
  }
}
