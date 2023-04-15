import 'package:api_practica/models/image_api_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class DetailImageScreen extends StatelessWidget {
  final ImageApiModel model;
  const DetailImageScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(child: Container()),
            Text(
              model.data![0].title!,
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                GestureDetector(
                    onTap: () {
                      showImageViewer(
                          context, Image.network(model.links![0].href!).image,
                          swipeDismissible: true, doubleTapZoomable: true);
                    },
                    child: Image.network(model.links![0].href!)),
                Positioned(
                    bottom: 5,
                    right: 5,
                    child: Text(model.data![0].photographer!.isNotEmpty
                        ? model.data![0].photographer!
                        : model.data![0].secondarycreator!.isNotEmpty
                            ? model.data![0].secondarycreator!
                            : model.data![0].dateCreated!))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Descripcion: \n${model.data![0].description!}',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('keywords'),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.data![0].keywords!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 100),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(104, 116, 111, 111),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        model.data![0].keywords![index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(model.data![0].nasaId!),
              subtitle: Text(model.data![0].center!),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(model.data![0].dateCreated!),
          ],
        ),
      ),
    );
  }
}
