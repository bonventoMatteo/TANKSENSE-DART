import 'dart:math';
import 'dart:async';
import 'dart:io';

void main() {
  final Map<String, dynamic> tanque = {
    'altura': 100.0, // cm
    'historico': <Map<String, dynamic>>[],
  };

  Timer.periodic(Duration(seconds: 3), (timer) {
    final distancia = 5.0 + Random().nextDouble() * tanque['altura'];
    final nivel = max(0, tanque['altura'] - distancia + 5);
    final percentual = min(100, max(0, (nivel / tanque['altura']) * 100));

    String status;
    String cor;

    if (percentual >= 75) {
      status = "ALTO";
      cor = "\x1b[32m";
    } else if (percentual >= 30) {
      status = "MÉDIO";
      cor = "\x1B[33m"; // amarelo
    } else {
      status = "BAIXO";
      cor = "\x1B[31m"; // vermelho
    }

    tanque['historico'].add({
      'distancia': distancia,
      'nivel': nivel,
      'percentual': percentual,
      'status': status,
      'timestamp': DateTime.now(),
    });

    if (tanque['historico'].length > 10) {
      tanque['historico'].removeAt(0);
    }

    // Limpa a tela (funciona na maioria dos terminais Unix/Windows modernos)
    stdout.write("\x1B[2J\x1B[0;0H");

    // Agora imprime tudo de novo no mesmo lugar
    stdout.writeln("--------------------------------");
    stdout.writeln(" ");
    stdout.writeln("~~~~~~~~~~ TANKSENSE ~~~~~~~~~~");
    stdout.writeln(" ");
    stdout.writeln("Distancia: ${distancia.toStringAsFixed(2)} cm");
    stdout.writeln("Nivel: ${nivel.toStringAsFixed(2)} cm");
    stdout.writeln("Percentual: ${percentual.toStringAsFixed(1)}%");
    stdout.writeln("Status: $cor$status\x1b[0m");
    stdout.writeln(" ");
    stdout.writeln("--------------------------------");
  });
}
