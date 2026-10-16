import 'dart:io';

void clearScreen() {
  print('\x1B[2J\x1B[0;0H');
}

final Map<String, Map<String, dynamic>> units = {
  '1': {'name': 'Meter', 'symbol': 'm', 'factor': 1.0},
  '2': {'name': 'Kilometer', 'symbol': 'km', 'factor': 1000.0},
  '3': {'name': 'Centimeter', 'symbol': 'cm', 'factor': 0.01},
  '4': {'name': 'Millimeter', 'symbol': 'mm', 'factor': 0.001},
  '5': {'name': 'Mile', 'symbol': 'mi', 'factor': 1609.344},
  '6': {'name': 'Yard', 'symbol': 'yd', 'factor': 0.9144},
  '7': {'name': 'Foot', 'symbol': 'ft', 'factor': 0.3048},
  '8': {'name': 'Inch', 'symbol': 'in', 'factor': 0.0254},
};

double convert({
  required double fromFactor,
  required double toFactor,
  required double value
}) {
  final baseValue = value * fromFactor;
  return baseValue / toFactor;
}

void startProgram() {
  clearScreen();

  units.forEach((key, value) {
    print("$key. ${value['name']} (${value['symbol']})");
  });

  var fromLength, length, toLength;

  while (true) {
    print("\nconvert From (Choose a number from the menu): ");
    fromLength = stdin.readLineSync() ?? '';

    if (units.containsKey(fromLength)) {
      break;
    }

    print("\nInvalid Input!");
  }

  while (true) {
    print("\nLength: ");
    length = double.tryParse(stdin.readLineSync() ?? '');

    if (length is double) {
      break;
    }

    print("\nInvalid Input!");
  }

  while (true) {
    print("\nConvert To (Choose a number from the menu): ");
    toLength = stdin.readLineSync() ?? '';

    if (units.containsKey(toLength)) {
      break;
    }

    print("\nInvalid Input!");
  }

  final fromUnit = units[fromLength]!;
  final toUnit = units[toLength]!;

  final result = convert(
    fromFactor: fromUnit['factor'] as double,
    toFactor: toUnit['factor'] as double,
    value: length);

    clearScreen();
    print("\n$length ${fromUnit['symbol']} = ${result.toStringAsFixed(4)} ${toUnit['symbol']}");
    print("\nPress Enter..");
    stdin.readLineSync() ?? '';
}

void main () {
  while (true) {
    clearScreen();
    print("--- Welcome To Length Converter ---\n");
    print("1. Convert");
    print("2. Exit");

    stdout.write("\nEnter your choice: ");
    var userInput = stdin.readLineSync() ?? '';

    if (userInput == '1') {
      startProgram();
    } else if (userInput == '2') {
      print("\nGoodbye..");
      break;
    } else {
      print("\nInvalid Input.");
      stdout.write("\nPress Enter.. ");
      stdin.readLineSync() ?? '';
    }
  }
}