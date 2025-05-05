import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LDSW Interfaz Usuario',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _weather = "Cargando..."; // Inicialmente, muestra "Cargando..."

  // Función para obtener el pronóstico del clima
  Future<void> fetchWeather() async {
    const String apiKey = 'TU_API_KEY_AQUI'; // Sustituye con tu clave API
    const String city = 'Mexico City'; // Puedes cambiar la ciudad

    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=es';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weather = 'Temperatura: ${data['main']['temp']}°C\n'
              'Clima: ${data['weather'][0]['description']}';
        });
      } else {
        setState(() {
          _weather = 'Error al obtener los datos.';
        });
      }
    } catch (e) {
      setState(() {
        _weather = 'Error de conexión.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Llamamos a la función al inicio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.jpg'), // Asegúrate de tener esta imagen en tu proyecto
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Capa semi-transparente para mejorar lectura
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          // Contenido principal
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  FlutterLogo(size: 100),
                  SizedBox(height: 20),

                  // Mensaje de bienvenida
                  Text(
                    '¡Bienvenido a LDSW!',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Nombre de la app
                  Text(
                    'Interfaz de Usuario',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Mostrar el pronóstico del clima
                  Text(
                    _weather,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Campos de texto
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  // Botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                        ),
                        child: Text('Ingresar'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text('Registrarse'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
