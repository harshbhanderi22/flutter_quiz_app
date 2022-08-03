import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
void main() => runApp(QuizUi());
quiz_brain qb=quiz_brain();

class QuizUi extends StatelessWidget {
  const QuizUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: QuizApp(),
        ),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int score=0;
  void CheckAnswer(bool answer)
  {
    if(qb.isFinished())
      {

        Alert(
          context: context,
          title: "Congratulations!!!",
          desc: 'You have scored $score',
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            ),

          ],
        ).show();

        qb.reset();
        scorecard=[];
        score=0;



      }
    else
      {
        if(qb.getAnswer()==answer)
        {
          scorecard.add(Icon(Icons.check,color: Colors.green,));
          score++;
        }
        else
        {
          scorecard.add(Icon(Icons.close,color: Colors.red,));
        }
        qb.next();
      }
  }
  List<Icon> scorecard=[];

   @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:<Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                qb.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(child:
           Padding(
             padding: const EdgeInsets.all(015.0),
             child: FlatButton(
               color: Colors.green,
               child: const Text("True",
               style: TextStyle(
                 fontSize: 20.0,
                 color: Colors.white,
               ),
               ),
               onPressed: (){
                 setState(() {
                    CheckAnswer(true);
                 });
               },
             ),
           ),
        ),
        Expanded(child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: FlatButton(
            color: Colors.red,
            child: const Text("False",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            onPressed: (){
              setState(() {
                CheckAnswer(false);
              });
            },
          ),
        ),
        ),
        Row(
           children: scorecard,
        )
      ],
    );

  }
}
