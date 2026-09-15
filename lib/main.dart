import 'package:flutter/material.dart';

// Culorile aplicației, definite o singură dată
const Color mov = Color(0xFF6C5CE7);
const Color verde = Color(0xFF00B894);
const Color galben = Color(0xFFFDCB6E);
const Color portocaliu = Color(0xFFE17055);
const Color rosu = Color(0xFFD63031);
const Color gri = Color(0xFF95A5A6);
const Color griInchis = Color(0xFF2D3436);

void main() {
  runApp(const AplicatiaMea());
}

// Setările generale ale aplicației (temă, primul ecran)
class AplicatiaMea extends StatelessWidget {
  const AplicatiaMea({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: mov,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const EcranCalculator(),
    );
  }
}

// Ecranul principal cu câmpuri și butoane
class EcranCalculator extends StatefulWidget {
  const EcranCalculator({super.key});

  @override
  State<EcranCalculator> createState() => _EcranCalculatorState();
}

class _EcranCalculatorState extends State<EcranCalculator> {
  // Controller-ele pentru cele două câmpuri de input
  final inaltimeInput = TextEditingController();
  final greutateInput = TextEditingController();
  final verificareFormular = GlobalKey<FormState>();

  // Datele care se schimbă pe ecran
  double imc = 0;
  String categorie = '';
  String descriere = '';
  Color culoareRezultat = gri;
  bool arataRezultat = false;

  // Se apelează când utilizatorul apasă CALCULEAZĂ
  void calculeazaIMC() {
    // Verificăm dacă datele introduse sunt valide
    if (!verificareFormular.currentState!.validate()) return;

    double inaltime = double.parse(inaltimeInput.text);
    double greutate = double.parse(greutateInput.text);

    // Formula IMC: greutate / (înălțime în metri)²
    double inaltimeMetri = inaltime / 100;
    double rezultat = greutate / (inaltimeMetri * inaltimeMetri);

    // Stabilim categoria, descrierea și culoarea după valoarea IMC
    String cat;
    String desc;
    Color culoare;

    if (rezultat < 18.5) {
      cat = 'Subponderal';
      desc = 'Aveți greutate sub normal';
      culoare = galben;
    } else if (rezultat < 25) {
      cat = 'Normal';
      desc = 'Greutate normală';
      culoare = verde;
    } else if (rezultat < 30) {
      cat = 'Supraponderal';
      desc = 'Aveți greutate peste normal';
      culoare = galben;
    } else if (rezultat < 35) {
      cat = 'Obezitate grad I';
      desc = 'Obezitate moderată';
      culoare = portocaliu;
    } else {
      cat = 'Obezitate severă';
      desc = 'Consultați un medic';
      culoare = rosu;
    }

    // setState anunță Flutter să redeseneze ecranul
    setState(() {
      imc = rezultat;
      categorie = cat;
      descriere = desc;
      culoareRezultat = culoare;
      arataRezultat = true;
    });
  }

  // Se apelează când utilizatorul apasă ȘTERGE
  void stergeTot() {
    setState(() {
      inaltimeInput.clear();
      greutateInput.clear();
      imc = 0;
      categorie = '';
      descriere = '';
      arataRezultat = false;
    });
  }

  // Eliberează memoria când ecranul se închide
  @override
  void dispose() {
    inaltimeInput.dispose();
    greutateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator IMC')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: verificareFormular,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Introduceți datele:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: griInchis,
                ),
              ),
              const SizedBox(height: 20),

              // Câmp pentru înălțime
              TextFormField(
                controller: inaltimeInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Înălțime (cm)',
                  hintText: 'Exemplu: 175',
                  prefixIcon: Icon(Icons.height, color: mov),
                  border: OutlineInputBorder(),
                ),
                validator: (valoare) {
                  if (valoare == null || valoare.isEmpty) {
                    return 'Scrieți înălțimea';
                  }
                  double? numar = double.tryParse(valoare);
                  if (numar == null) return 'Nu e un număr';
                  if (numar < 50 || numar > 300) return 'Între 50 și 300';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Câmp pentru greutate
              TextFormField(
                controller: greutateInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Greutate (kg)',
                  hintText: 'Exemplu: 70',
                  prefixIcon: Icon(Icons.monitor_weight, color: mov),
                  border: OutlineInputBorder(),
                ),
                validator: (valoare) {
                  if (valoare == null || valoare.isEmpty) {
                    return 'Scrieți greutatea';
                  }
                  double? numar = double.tryParse(valoare);
                  if (numar == null) return 'Nu e un număr';
                  if (numar < 2 || numar > 500) return 'Între 2 și 500';
                  return null;
                },
              ),
              const SizedBox(height: 25),

              // Cele două butoane
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: calculeazaIMC,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mov,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('CALCULEAZĂ'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: stergeTot,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('ȘTERGE'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Cardul cu rezultat (apare doar după calcul)
              if (arataRezultat)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: culoareRezultat.withOpacity(0.1),
                    border: Border.all(color: culoareRezultat, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'IMC-ul dvs.:',
                        style: TextStyle(fontSize: 14, color: gri),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        imc.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: culoareRezultat,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: culoareRezultat,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categorie,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        descriere,
                        style: const TextStyle(color: griInchis, fontSize: 15),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}