import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/go_viewmodel.dart';

class GoPage extends StatefulWidget {
  static const route = "/";
  const GoPage({super.key});

  @override
  State<GoPage> createState() => _GoPageState();
}

class _GoPageState extends State<GoPage> {
  late GoViewmodel viewModel = GoViewmodel(context.read())..getMotels();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Motels')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.responseModel == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: viewModel.responseModel!.moteis.length,
            itemBuilder: (context, index) {
              final motel = viewModel.responseModel!.moteis[index];
              return ListTile(title: Text(motel.fantasia));
            },
          );
        },
      ),
    );
  }
}
