import 'package:api_practica/network/api_nasa_images.dart';
import 'package:flutter/material.dart';

import '../models/image_api_model.dart';

class SearchApiDelegate extends SearchDelegate<ImageApiModel> {
  final List<ImageApiModel> historial;

  SearchApiDelegate(this.historial);

  @override
  String? get searchFieldLabel => 'Buscar imagen';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => this.query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => this.close(context, ImageApiModel()),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.trim().isEmpty) {
      return Text('No se encontraron resultados');
    }

    final apinasaimages = NasaApiImages();

    return FutureBuilder(
      future: apinasaimages.getImagesApi(query),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _showImages(snapshot.data);
        } else if (snapshot.hasError) {
          return ListTile(
            title: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return _showImages(historial);
  }

  Widget _showImages(List<ImageApiModel> nasa) {
    if (nasa.length == 0) {
      return const ListTile(title: Text('No se encontraron resultados'));
    }
    return ListView.builder(
        itemCount: nasa.length,
        itemBuilder: (context, i) {
          final image = nasa[i];
          return ListTile(
            leading: Image.network(
              image.links![0].href!,
              width: 45,
            ),
            title: Text(image.data![0].title!),
            subtitle: Text(image.data![0].dateCreated!),
            trailing: Text(image.data![0].center!),
            onTap: () {
              this.close(context, image);
            },
          );
        });
  }
}
