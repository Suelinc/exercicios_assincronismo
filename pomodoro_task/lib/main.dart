import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: PomodoroTask()));
}

class PomodoroTask extends StatefulWidget {
  const PomodoroTask({Key? key}) : super(key: key);

  @override
  State<PomodoroTask> createState() => PomodoroTaskState();
}

class PomodoroTaskState extends State<PomodoroTask> {
  Color cor1 = Colors.amber.shade800;
  Color cor2 = Colors.tealAccent.shade700;
  Color cor3 = const Color(0xFF363640);
  Color cor4 = const Color(0xFF232323);
  Color corBotao = Colors.amber.shade800;
  Color corCirculo = const Color(0xFF363640);

  TextEditingController campoTask = TextEditingController();

  String task = 'Adicionar uma tarefa';
  String cronometro = 'Pomodoro Task';
  String textoBotao = 'Iniciar Pomodoro';
  bool isPomodoro = false;
  bool isDescanso = false;
  double porcentagem = 1.0;
  int tempoTotal = 25;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: cor4,
          padding: const EdgeInsets.all(15.0),
          child: ListView(children: [
            MaterialButton(
                color: cor3,
                onPressed: () {
                  modalTask();
                },
                child: Text(
                  task,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(
              height: 25.0,
            ),
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(15.0),
                        width: 250.0,
                        height: 250.0,
                        child: CircularProgressIndicator(
                          value: porcentagem,
                          color: corCirculo,
                          strokeWidth: 25,
                        )),
                  ),
                  Center(
                      child: Text(cronometro,
                          style: const TextStyle(
                            fontSize: 32.0,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
            const SizedBox(height: 45.0),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                ),
                child: MaterialButton(
                  color: corBotao,
                  child: Text(
                    textoBotao,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    iniciarPomodoro();
                  },
                ))
          ])),
    );
  }

  modalTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Column(children: [
            TextField(
              controller: campoTask,
              autofocus: true,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              onPressed: () {
                adicionarTask();
              },
              color: cor1,
              child: const Text('Adicionar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
            MaterialButton(
              onPressed: () {
                limparTask();
              },
              color: cor4,
              child: const Text('Limpar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            )
          ]));
        });
  }
  
  void adicionarTask() {
    if (campoTask.text.isNotEmpty) {
      setState(() {
        task = campoTask.text;
      });
    }
    Navigator.pop(context, false);
  }

  void limparTask() {
    setState(() {
      task = 'Adicionar uma tarefa +';
      campoTask.text = '';
    });
    Navigator.pop(context, false);
  }

  void iniciarPomodoro() {
    if (!isPomodoro && !isDescanso) {
      isPomodoro = true;
      tempoTotal = 25;
      int tempo = tempoTotal;
      setState(() {
        corCirculo = cor1;
        cronometro = tempo > 9 ? "00:$tempo" : "00:0$tempo";
      });

      Timer.periodic(const Duration(seconds: 1), (timer) {
        tempo = tempoTotal - timer.tick;
        if (tempo > 0) {
          setState(() {
            cronometro = tempo > 9 ? "00:$tempo" : "00:0$tempo";
            porcentagem -= (100 / tempoTotal) / 100;
          });
        } else {
          timer.cancel();
          isPomodoro = false;
          isDescanso = true;
          tempoTotal = 5;
          setState(() {
            corCirculo = cor2;
            corBotao = cor2;
            cronometro = 'Descanse!';
            textoBotao = 'Iniciar Descanso';
            porcentagem = 1;
          });
        }
      });
    } else if (isDescanso && !isPomodoro) {
      isPomodoro = true;
      int tempo = tempoTotal;

      Timer.periodic(const Duration(seconds: 1), (timer) {
        tempo = tempoTotal - timer.tick;

        if (tempo > 0) {
          setState(() {
            cronometro = tempo > 9 ? "00:$tempo" : "00:0$tempo";
            porcentagem -= (100 / tempoTotal) / 100;
          });
        } else {
          timer.cancel();
          isPomodoro = false;
          isDescanso = true;
          tempoTotal = 25;
          porcentagem = 1;
          setState(() {
            cronometro = "Pomodoro Task";
            corCirculo = cor3;
            corBotao = cor1;
            textoBotao = "Iniciar Pomodoro";
          });
        }
      });
    }
  }
}
