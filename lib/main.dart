import 'package:flutter/material.dart';

void main() {
  runApp(TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter Temperatura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white), // Cor do texto da label
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),  // Borda roxa
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),  // Borda roxa ao não focar
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 239, 140, 11)), // Borda laranja ao focar
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),  // Texto branco por padrão
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celsius para Fahrenheit e Kelvin'),
        centerTitle: true,  // Centraliza o título da AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.orange],  // Gradiente roxo e laranja
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center,  // Centraliza horizontalmente
            children: [
              Container(
                width: 300,  // Define a largura máxima do campo de texto
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),  // Texto em branco
                  decoration: InputDecoration(
                    labelText: 'Temperatura em Celcius',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 200,  // Define uma largura menor para o botão
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.orange],  // Gradiente roxo e laranja no botão
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Remove a cor sólida para o gradiente
                    shadowColor: Colors.transparent, // Remove a sombra
                  ),
                  onPressed: () {
                    double? celsius = double.tryParse(_controller.text);
                    if (celsius != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(celsius: celsius),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Número invalido')),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Converter',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double celsius;

  ResultScreen({required this.celsius});

  double _celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double _celsiusToKelvin(double celsius) {
    return celsius + 273.15;
  }

  @override
  Widget build(BuildContext context) {
    double fahrenheit = _celsiusToFahrenheit(celsius);
    double kelvin = _celsiusToKelvin(celsius);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
        centerTitle: true,  // Centraliza o título da AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.orange],  // Gradiente roxo e laranja
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center,  // Centraliza horizontalmente
            children: [
              Text(
                'Celsius: $celsius°C',
                style: TextStyle(fontSize: 24, color: Colors.white),  // Texto branco
              ),
              SizedBox(height: 10),
              Text(
                'Fahrenheit: $fahrenheit°F',
                style: TextStyle(fontSize: 24, color: Colors.white),  // Texto branco
              ),
              SizedBox(height: 10),
              Text(
                'Kelvin: $kelvin K',
                style: TextStyle(fontSize: 24, color: Colors.white),  // Texto branco
              ),
              SizedBox(height: 20),
              Container(
                width: 200,  // Define uma largura menor para o botão
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.orange],  // Gradiente roxo e laranja no botão
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Remove a cor sólida para o gradiente
                    shadowColor: Colors.transparent, // Remove a sombra
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Voltar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
