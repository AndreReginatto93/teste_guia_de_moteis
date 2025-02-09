// coverage:ignore-file
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:teste_guia_de_moteis/src/core/http_client/http_client.dart';
import 'package:teste_guia_de_moteis/src/core/http_client/http_client_interface.dart';
import 'package:teste_guia_de_moteis/src/core/routing/navigation_handler.dart';
import 'package:teste_guia_de_moteis/src/data/repositories/motels_repository.dart';
import 'package:teste_guia_de_moteis/src/domain/repositories/motels_repository.dart';

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providers {
  return [
    Provider(create: (context) => NavigationHandler() as INavigationHandler),
    Provider(create: (context) => HttpClient() as IHttpClientService),
    Provider(
      create:
          (context) => MotelsRepository(context.read()) as IMotelsRepository,
    ),
  ];
}
