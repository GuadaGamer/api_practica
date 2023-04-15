import 'package:api_practica/models/image_api_model.dart';
import 'package:api_practica/models/today_model.dart';
import 'package:api_practica/network/api_day.dart';
import 'package:api_practica/screens/image_api_screen.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';

import '../delegates/search_api_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ApiNasaToday? apiNasaToday;
  Animation<double>? _animation;
  AnimationController? _animationController;
  List<ImageApiModel> historial = [];

  @override
  void initState() {
    apiNasaToday = ApiNasaToday();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    bool inArray = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(child: Container()),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  children: const [
                    Text(
                      'NASA APIS',
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '*Busca para comenzar*',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 8.0, bottom: 8.0, right: 8.0),
                child: FutureBuilder(
                  future: apiNasaToday!.getTodayNasa(),
                  builder: (context, AsyncSnapshot<TodayNasaModel?> snapshot) {
                    if (snapshot.hasData) {
                      TodayNasaModel model = snapshot.data!;
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 112, 112, 112)
                              .withOpacity(.6),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.nightlight,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text('ej: Moon',
                                        style: TextStyle(color: Colors.white)),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () async {
                                          final imageApi = await showSearch(
                                              context: context,
                                              delegate:
                                                  SearchApiDelegate(historial));
                                          setState(() {
                                            if (imageApi != null) {
                                              if (imageApi.data != null) {
                                                for (var element in historial) {
                                                  if (element.data![0].nasaId ==
                                                      imageApi
                                                          .data![0].nasaId) {
                                                    inArray = true;
                                                  }
                                                }
                                                if (inArray == false) {
                                                  this.historial.add(imageApi);
                                                }
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            DetailImageScreen(
                                                                model:
                                                                    imageApi)));
                                              }
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ))
                                  ],
                                )),
                            const Text('Imagen del dia',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0)),
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: FadeInImage(
                                    fit: BoxFit.fitWidth,
                                    placeholder:
                                        const AssetImage('assets/load.webp'),
                                    image: NetworkImage(model.hdurl!),
                                  ),
                                ),
                                Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Text(
                                      model.copyright == null
                                          ? model.date!
                                          : model.copyright!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(model.title!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    decorationStyle: TextDecorationStyle.solid,
                                    letterSpacing: 2)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(model.explanation!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15.0)),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Ocurrio un error${snapshot.error}'),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Imagen",
            iconColor: Colors.white,
            bubbleColor: Colors.blueGrey,
            icon: Icons.image_search,
            titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              showDialog(
                context: context,
                barrierColor: const Color.fromARGB(99, 41, 40, 40),
                builder: (context) {
                  return const AlertDialog(
                    content: Text(
                        'Preciona el boton de busqueda para comenzar.',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                  );
                },
              );
              _animationController?.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title: "Explicación",
            iconColor: Colors.white,
            bubbleColor: Colors.blueGrey,
            icon: Icons.notes,
            titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              showDialog(
                context: context,
                barrierColor: const Color.fromARGB(99, 41, 40, 40),
                builder: (context) {
                  return AlertDialog(
                      content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('API reference.',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center),
                      Text(
                          'The images.nasa.gov API is organized around REST. Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. We use built-in HTTP features, like HTTP authentication and HTTP verbs, which are understood by off-the-shelf HTTP clients. We support cross-origin resource sharing, allowing you to interact securely with our API from a client-side web application. JSON is returned by all API responses, including errors. \nEach of the endpoints described below also contains example snippets which use the curl command-linetool, Unix pipelines, and the python command-line tool to output API responses in an easy-to-read format. We insert superfluous newlines to improve readability in these inline examples, but to run our examples you must remove these newlines.'),
                    ],
                  ));
                },
              );
              _animationController?.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title: "Información",
            iconColor: Colors.white,
            bubbleColor: Colors.blueGrey,
            icon: Icons.not_listed_location,
            titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              showDialog(
                context: context,
                barrierColor: const Color.fromARGB(99, 41, 40, 40),
                builder: (context) {
                  return const AlertDialog(
                      content: Text(
                          'En esta aplicación podemos buscar imagenes proporcionadas por la API de la nasa, donde se utilizara el boton de busqueda y podremos ver la gran cantidad de imagenes existentes.'));
                },
              );
              _animationController?.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation!,

        // On pressed change animation state
        onPress: () => _animationController!.isCompleted
            ? _animationController?.reverse()
            : _animationController?.forward(),

        // Floating Action button Icon color
        iconColor: Colors.black,

        // Flaoting Action button Icon
        iconData: Icons.public,
        backGroundColor: Colors.white,
      ),
    );
  }
}
