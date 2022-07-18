import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: PomodoroTask()));
}

class PomodoroTask extends StatefulWidget {
  const PomodoroTask({Key? key}) : super(key: key);

  @override
  State<PomodoroTask> createState() => PomodoroTaskState();
}

class PomodoroTaskState extends State<PomodoroTask> {
  TextEditingController tarefaControl = TextEditingController();

  
  String tempo = '';
  int pontos = 0;
  bool isStart = false;
  final foco = FocusNode();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
            
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100.0,
            ),
            ElevatedButton(
              onPressed: (){},
              // style:  const ButtonStyle(backgroundColor: Colors.blueGrey,),
              child: const Text('Adicionar uma tarefa +'),
            ),
            
            const SizedBox(
              height: 5.0,
            ),
            // TextField(
            //   controller: tarefaControl,
            //   keyboardType: TextInputType.text,
            //   focusNode: foco,
            // ),
            // const SizedBox(
            //   height: 10.0,
            // ),
            ElevatedButton(
              onPressed: (){},
              child: const Text('Iniciar Pomodoro'),
            ),
            
            
          ],
        ),
      ),
    );
  }

  Future<void> startGame() async {
    var tempTime = 30;

    if (!isStart) {
      pontos = 0;
      isStart = true;
      

      for (var index = tempTime; index > 0; index--) {
        await Future.delayed(const Duration(seconds: 1));
        tempTime -= 1;
        setState(() {
          if (tempTime == 0) {
            tempo = '00:00';
            
            isStart = false;
            tarefaControl.text = '';
            showDialogAcertou();
            foco.requestFocus();
          } else {
            foco.requestFocus();
            tempo = (tempTime > 9 ? '00:$tempTime' : '00:0$tempTime');
          }
        });
      }
    }
  }

  void showDialogAcertou() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text("Acertou $pontos palavra(s)!"),
        );
      },
    );
  }

  void showDialogOrientacao() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(
            'Clique em Start Game, digite a palavra mostrada e que em Enviar',
            style: TextStyle(
              color: Colors.blue.shade900,
            ),
          ),
        );
      },
    );
  }

  
}
