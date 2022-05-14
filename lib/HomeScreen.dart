import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Uri over = Uri.parse('https://www.cdc.gov/healthyweight/effects/index.html');
  final Uri under = Uri.parse('https://www.healthline.com/health/underweight-health-risks');

  void _launchUrl() async {
    if (!await launchUrl(overWeight ? over : under)) throw 'Could not launch ${overWeight ? over : under}';
  }

  late Timer _timer;

  int age =  18;
  int weight =  60;
  double height =  160.0;

  Color maleColor = Colors.white12;
  Color femaleColor = Colors.white12;


  bool male = false;
  bool female = false;

  late bool overWeight;
  late double result;
  late double minHealthyWeight;
  late double maxHealthyWeight;
  late String weightCase;
  late Color weightCaseColor = Colors.red;

  late String over_or_under;

  bool increaseAge = true;
  bool decreaseAge = true;
  bool increaseWeight = true;
  bool decreaseWeight = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF090E21),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF090E21),
        flexibleSpace:
        const Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text(
            'BMI CALCULATOR',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => {male = true, female = false}),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: male ? Colors.blue.shade800 : Colors.white12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: const [
                              Expanded(
                                child: ImageIcon(
                                  AssetImage("assets/male.png"),
                                  size: 100,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Expanded(
                                child: Text(
                                  'Male',
                                  style: TextStyle(
                                    fontSize: 30,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25,),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => {male = false, female = true}),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: female ? Colors.pink : Colors.white12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: const [
                              Expanded(
                                child: ImageIcon(
                                  AssetImage("assets/female.png"),
                                  size: 100,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Expanded(
                                child: Text(
                                  'Female',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white12,
                  // boxShadow:
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      Text(
                          'HEIGHT',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white38
                        ),
                      ),
                      SizedBox(height:3,),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '${height.round()}',
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            const TextSpan(
                                text: 'cm',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white38
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Slider(
                            value: height,
                            max: 220.0,
                            min: 100.0,
                            inactiveColor: Colors.white12,
                            activeColor: Colors.white12,
                            thumbColor: Colors.pink,
                            onChanged: (value){
                              setState(() {
                                height = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              const Text(
                                'WEIGHT',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF3D95DF)
                                ),
                              ),
                              SizedBox(height:3,),
                              Center(
                                child:
                                Text(
                                  '$weight',
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              SizedBox(height:3,),
                              Row(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                        onTapDown: (TapDownDetails details) => _timer = Timer.periodic(Duration(milliseconds: 100), (t) => setState(() => weight > 2 ? weight-- : null)),
                                        onTapUp: (TapUpDetails details) => _timer.cancel(),
                                        onTapCancel: () => _timer.cancel(),
                                      child: FloatingActionButton(
                                        backgroundColor: Color(0xFF4C4F5E),
                                          onPressed: () => setState(() => weight > 2 ? weight-- : null),
                                          mini: true,
                                        child: Icon(Icons.remove, size: 20, color: Colors.white,)
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTapDown: (TapDownDetails details) => _timer = Timer.periodic(Duration(milliseconds: 100), (t) => setState(() => weight < 300 ? weight++ : null)),
                                      onTapUp: (TapUpDetails details) => _timer.cancel(),
                                      onTapCancel: () => _timer.cancel(),
                                      child: FloatingActionButton(
                                          backgroundColor: Color(0xFF4C4F5E),
                                          onPressed: () => setState(() => weight < 300 ? weight++ : null),
                                            mini: true,
                                          child: Icon(Icons.add, size: 20, color: Colors.white,)
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              Text(
                                'AGE',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF3D95DF)
                                ),
                              ),
                              SizedBox(height:3,),
                              Center(
                                child: Text(
                                    '$age',
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              SizedBox(height:3,),
                              Row(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                        onTapDown: (TapDownDetails details) => _timer = Timer.periodic(Duration(milliseconds: 100), (t) => setState(() => age > 2 ? age-- : null)),
                                        onTapUp: (TapUpDetails details) => _timer.cancel(),
                                        onTapCancel: () => _timer.cancel(),
                                      child: FloatingActionButton(
                                          backgroundColor: Color(0xFF4C4F5E),
                                          onPressed: () => setState(() => age > 2 ? age-- : null),
                                          mini: true,
                                          child: Icon(Icons.remove, size: 20, color: Colors.white,)
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                        onTapDown: (TapDownDetails details) => _timer = Timer.periodic(Duration(milliseconds: 100), (t) => setState(() => age < 120 ? age++ : null)),
                                        onTapUp: (TapUpDetails details) => _timer.cancel(),
                                        onTapCancel: () => _timer.cancel(),
                                      child: FloatingActionButton(
                                          backgroundColor: Color(0xFF4C4F5E),
                                          onPressed: () => setState(() =>  age < 120 ? age++ : null),
                                          mini: true,
                                          child: Icon(Icons.add, size: 20,color: Colors.white,)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(18.0)
              ),
              width: double.infinity,
              height: 60,
              child: MaterialButton(
                child: const Text('CALCULATE'),
                onPressed: !male && !female ? () {
                 var snackBar = SnackBar(
                      content: const Text('Select your gender!', style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                      ),
                    action: SnackBarAction(
                        label: 'Ok',
                        onPressed: (){}),
                    // action: ,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                    : () {
                   // _launchUrl();

                  // setState(() {
                  //
                  // });
                  weightCaseColor = Colors.red;
                  // if (age > 20) {
                    result = weight / pow((height / 100), 2);
                    minHealthyWeight = 18.5 * pow((height / 100), 2);
                    maxHealthyWeight = 25.0 * pow((height / 100), 2);

                    if (result > 25.0) overWeight = true;
                    if (result < 18.5) overWeight = false;

                    if (result < 16.0) {weightCaseColor = Colors.red.shade900; weightCase = 'Severe Thinness';}
                    if (result > 16.0 && result <= 17.0) {weightCaseColor = Colors.red.shade500; weightCase = 'Moderate Thinness';}
                    if (result > 17.0 && result <= 18.5) {weightCaseColor = Colors.brown;weightCase = 'Mild Thinness';}
                    if (result > 18.5 && result <= 25.0) {weightCaseColor = Colors.lightGreenAccent; weightCase = 'Normal';}
                    if (result > 25.0 && result <= 30.0) {weightCaseColor = Colors.brown; weightCase = 'Overweight';}
                    if (result > 35.0 && result <= 40.0) {weightCaseColor = Colors.red.shade700;  weightCase = 'Obese Class II';}
                    if (result > 30.0 && result <= 35.0) {weightCaseColor = Colors.red.shade500;  weightCase = 'Obese Class I';}
                    if (result > 40.0) {weightCaseColor = Colors.red.shade900; weightCase = 'Obese Class III';}

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        elevation: 20.0,
                        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        contentPadding: const EdgeInsets.only(
                          top: 15, right: 30, left: 30,),
                        title: Text(
                            '$weightCase\n BMI: ${result.toStringAsPrecision(3)}',
                            style: TextStyle(color: weightCaseColor),
                            textAlign: TextAlign.center,
                        ),
                        content: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(height: 2.0, ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Healthy BMI range: 18.5 - 25\n'
                                      'Healthy weight: ${minHealthyWeight.toStringAsPrecision(2)} kgs - ${maxHealthyWeight.toStringAsFixed(1)} kgs\n'
                              ),
                             TextSpan(
                                  text: result < 18.5 || result > 25 ? (
                                     overWeight ? ('You have to lose ${(weight - maxHealthyWeight).toStringAsPrecision(3)} kgs.\n')
                                                : 'You have to gain ${(minHealthyWeight - weight).toStringAsPrecision(3)} kgs\n'
                                ) : null,
                               style: const TextStyle(color: Colors.redAccent)
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Align(alignment: Alignment.center,child: Text(result < 18.5 || result > 25 ?  (overWeight ? 'Risks associated with being overweight' : 'Risks associated with being underweight') : 'You\'re doing great, keep on! :)',textAlign: TextAlign.center,style: TextStyle(color: Colors.blueAccent, fontSize: 13,),)),
                              onPressed: result >= 18.5 && result <= 25 ?  null : () => _launchUrl(),
                          )
                        ],
                      ),
                    );
                  }
                // }else{}
              ),
            ),
          ],
        ),
      ),
    );
  }
}


