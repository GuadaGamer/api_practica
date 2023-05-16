import 'package:api_practica/screens/presentacion_card.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final data = [
    CardData(
        title: "TecNM en Celaya",
        subtitle: "Aplicación sobre imagenes, videos de la nasa",
        //image: const AssetImage('assets/itce.png'),
        backgraundColor: const Color.fromARGB(255, 28, 28, 28),
        titleColor: Colors.pink,
        subtitleColor: Colors.white,
        backgraund: Lottie.asset('assets/espacio.json')),
    CardData(
        title: "Como utilizarla",
        subtitle: "Contribuir a la transformación de la sociedad a través de la formación de ciudadanas y ciudadanos libres y responsables",
        //image: const AssetImage('assets/mision.png'),
        backgraundColor: const Color.fromARGB(255, 21, 21, 58),
        titleColor: Colors.green,
        subtitleColor: Colors.white,
        backgraund: Lottie.asset('assets/tierra.json')),
    CardData(
        title: "Visión",
        subtitle: "Ser una institución de educación superior tecnológica reconocida a nivel internacional por el destacado dersempeño de sus egresadas y egresados",
        //image: const AssetImage('assets/vision.png'),
        backgraundColor: const Color.fromARGB(255, 28, 28, 28),
        titleColor: Colors.white,
        subtitleColor: Colors.blue,
        backgraund: Lottie.asset('assets/espacio.json')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgraundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardApi(data: data[index]);
        },
        onFinish: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}