import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: QuantasPalavras()));
}

class QuantasPalavras extends StatefulWidget {
  const QuantasPalavras({Key? key}) : super(key: key);

  @override
  State<QuantasPalavras> createState() => _QuantasPalavrasState();
}

class _QuantasPalavrasState extends State<QuantasPalavras> {
  TextEditingController palavraControl = TextEditingController();

  final listaPalavras = const [
    'Lorem',
    'ipsum',
    'dolor',
    'sit',
    'amet',
    'consectetur',
    'adipiscing',
    'elit',
    'Ut',
    'eu',
    'ex',
    'tortor',
    'Proin',
    'nulla',
    'arcu',
    'iaculis',
    'amet',
    'gravida',
    'tempus',
    'faucibus',
    'malesuada',
    'leo',
    'Nunc',
    'in',
    'faucibus',
    'orci',
    'Aenean',
    'dignissim',
    'tellus',
    'quis',
    'feugiat',
    'convallis',
    'Curabitur',
    'vitae',
    'tempus',
    'diam',
    'Curabitur',
    'molestie',
    'sapien',
    'id',
    'auctor',
    'faucibus',
    'sem',
    'elementum',
    'purus',
    'eget',
    'pharetra',
    'mauris',
    'metus',
    'nec',
    'tellus',
    'Phasellus',
    'mollis',
    'fermentum',
  ];

  String palavraSorteada = '';
  String tempo = '';
  int pontos = 0;
  bool isStart = false;
  final foco = FocusNode();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        toolbarHeight: 60.0,
        title: Text(
          isStart ? tempo : 'Quantas Palavras',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 200.0,
            ),
            Text(palavraSorteada,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 29.0,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: palavraControl,
              keyboardType: TextInputType.text,
              focusNode: foco,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: checarPalavra,
              child: const Text('ENVIAR'),
            ),
            ElevatedButton(
              onPressed: startGame,
              child: const Text('Start Game'),
            ),
            ElevatedButton(
              onPressed: showDialogOrientacao,
              child: const Text('?'),
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
      randomPalavra();

      for (var index = tempTime; index > 0; index--) {
        await Future.delayed(const Duration(seconds: 1));
        tempTime -= 1;
        setState(() {
          if (tempTime == 0) {
            tempo = '00:00';
            palavraSorteada = '';
            isStart = false;
            palavraControl.text = '';
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

  String randomPalavra() {
    final random = Random();

    final tempNumber = random.nextInt(listaPalavras.length);

    final tempPalavra = listaPalavras[tempNumber];

    palavraSorteada = tempPalavra;

    return palavraSorteada;
  }

  void checarPalavra() {
    if (isStart) {
      if (palavraControl.text == palavraSorteada) {
        pontos += 1;
      }
      palavraControl.text = '';
      randomPalavra();
      foco.unfocus();
    }
  }
}
