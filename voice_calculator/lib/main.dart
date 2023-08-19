// import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
// import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart';
// import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  // final Map<String, HighlightedWord> _highlights = {
  //   'flutter': HighlightedWord(
  //     onTap: () => print('flutter'),
  //     textStyle: const TextStyle(
  //       color: Colors.blue,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'voice': HighlightedWord(
  //     onTap: () => print('voice'),
  //     textStyle: const TextStyle(
  //       color: Colors.green,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'subscribe': HighlightedWord(
  //     onTap: () => print('subscribe'),
  //     textStyle: const TextStyle(
  //       color: Colors.red,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'like': HighlightedWord(
  //     onTap: () => print('like'),
  //     textStyle: const TextStyle(
  //       color: Colors.blueAccent,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'comment': HighlightedWord(
  //     onTap: () => print('comment'),
  //     textStyle: const TextStyle(
  //       color: Colors.green,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  // };

  // stt.SpeechToText _speech;
  static var _speech = SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  String f='';
  @override
  void initState() {
    super.initState();
    // _speech = SpeechToText();
  }

  String checkValidExp(String s){
    String k="";
    // print(s);
    // if(s==RegExp(r'^[a-zA-Z]+$')){
      for(int i=0;i<s.length;i++){
        if(RegExp(r'^[a-zA-Z]+$').hasMatch(s[i])){
        }else{
          k=k+s[i];
        }
      }
      // print(k);
    // if(RegExp(r'^[a-zA-Z]+$').hasMatch(s[0])){

    //   print(s[0]);
     
    // }
    // if((int.parse(s[0])>=65 && int.parse(s[0])<=90)||(int.parse(s[0])>=97 && int.parse(s[0])<=122)){
    // if(s.fromCharCode(0)>=65 && s.fromCharCode(0)<=90){
    //   print(s[0]);
    // // }
    //   // print(s[0]);
      return k;
    // }



    // if(s==null){
    //   return false;
    // }
    // else{
      // return false;
    // }
  }

  // String checkValidExp(String t){
  //   String a="";
  //   print("c:");
  //   for(int i=0;i<t.length;i++){
  //     if(!isAlphaabet(t[i])){
  //       a=a+t[i];
  //     //   print(a[i]);
  //     }
  //   }
    
  //   print(a);
  //   return a;
  // }
  var answer;
  void _calculate(){
    // void equalPressed() {
    setState((){
    // _text = _text.replaceAll(' ',"");
    // _text = _text.replaceAll('oneplus',"1+");
    _text = f+_text;
    if(_text.length==0){
      return;
    }
    _text = checkValidExp(_text);
//     f = f+_text;
    if(_text.length==0){
      return;
    }
    print(_text);
    // return;
    String finaluserinput = _text;
    // finaluserinput = _text.replaceAll('x', '*');
 
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    print("f: $answer");
    f = "";
    });
    // show();
  }

  // @override
  // Widget show(){
  //   return Stack(
      
  //     children:[
  //     Text("hi")
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer: $answer'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: 
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
            // Text("$answer"),
          Row(children:[
        FloatingActionButton(
          onPressed: 
            _listen,

          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
        Spacer(),
        FloatingActionButton(
          onPressed:
//             setState((){
//               f = '';
//             });
           _calculate,

          // onPressed: (){
          //   // print(
          //     // isAlphaabet(_text);
          //     isAlphaabet("h1llo");
          //     // );
          // },
          child: Icon(Icons.menu),
        ),
        ]),
      ]),
      // ElevatedButton(
      //   onPressed:(){},
      //   child: Icon(Icons.menu),
      // ),
      // ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child:Column(children:[
            Row(children:[
              Text("$_text"),
            ]),
            Text("$f"),
          ]),
          // child: TextHighlight(
          //   text: _text,
          //   words: _highlights,
          //   textStyle: const TextStyle(
          //     fontSize: 32.0,
          //     color: Colors.black,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
        ),
      ),
    );
  }
  

  void _listen() async {
    if (!_isListening) {
      bool available = 
      await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
//         int i=0;
        _speech.listen(
          onResult: (val) => setState(() {
            
            // print("$_text");
            // print(val.toJson());
            _text = val.recognizedWords;
            // print(_text.runtimeType);
            _text = _text.replaceAll(' ',"");
            _text = _text.replaceAll('oneplus',"1+");
            _text = _text.replaceAll('into',"*");
            _text = _text.replaceAll('divide',"/");
            _text = _text.replaceAll('divided by',"/");
            _text = _text.replaceAll('openparenthesis',"(");
            _text = _text.replaceAll('Openparenthesis',"(");
            _text = _text.replaceAll('closeparenthesis',")");
            _text = _text.replaceAll('Closeparenthesis',")");
            // if(i==0){
            //   f = f+_text;
            //   // print("yes");
            //   i++;
            // }

            // print(_text);
            // _text="";
            
            // if (val.hasConfidenceRating && val.confidence > 0) {
            //   _confidence = val.confidence;
            // }
          }),
        );
        // setState((){
        //   f = f+_text;
        // });
        // _text="";
      }
    } else {
      setState(() => {
        _isListening = false,
        f = f + _text,
      }
      );
      // setState((){
      //   f = f + _text.toString();
      // });
      _speech.stop();
    }
//     setState((){
//       f = f + _text;
//     });
  }
}