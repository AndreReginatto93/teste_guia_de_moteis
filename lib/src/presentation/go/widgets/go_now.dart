import 'package:flutter/material.dart';
import 'package:teste_guia_de_moteis/src/core/themes/colors.dart';
import 'package:teste_guia_de_moteis/src/core/themes/dimens.dart';
import 'package:teste_guia_de_moteis/src/data/models/motel_model.dart';
import 'package:teste_guia_de_moteis/src/data/models/suite_model.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/home_viewmodel.dart';

class GoNowPage extends StatelessWidget {
  const GoNowPage({super.key, required this.viewModel, required this.context});
  final HomeViewmodel viewModel;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.responseModel == null) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(children: [filters(), list()]);
      },
    );
  }

  Widget filters() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 4),
          height: 50,
          child: SingleChildScrollView(
            padding: Dimens.of(context).edgeInsetsScreenHorizontal,
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  viewModel.getFilters().map((filter) {
                    return GestureDetector(
                      onTap: () {
                        viewModel.toggleFilter(filter);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              viewModel.isFilterSelected(filter)
                                  ? AppColors.red1
                                  : AppColors.white1,
                          border: Border.all(
                            color:
                                viewModel.isFilterSelected(filter)
                                    ? AppColors.red1
                                    : AppColors.grey2,
                          ),
                        ),
                        child: Text(
                          filter,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(
                            color:
                                viewModel.isFilterSelected(filter)
                                    ? AppColors.white1
                                    : AppColors.black2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
        SizedBox(height: 4),
        Divider(color: AppColors.grey2, height: 0),
      ],
    );
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        itemCount: viewModel.filteredMotels?.length ?? 0,
        itemBuilder: (context, index) {
          final motel = viewModel.filteredMotels![index];

          return Column(
            children: [
              motelInfos(motel),
              SizedBox(
                height: 700,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.90),
                  itemCount: motel.suites.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final quarto = motel.suites[index];

                    return Column(
                      children: [
                        suiteImages(quarto),
                        suiteItems(quarto),
                        periodos(quarto),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget motelInfos(MotelModel motel) {
    return Padding(
      padding: Dimens.of(context).edgeInsetsScreenHorizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(motel.logo), radius: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  motel.fantasia,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: AppColors.black2),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  motel.bairro,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: AppColors.black2),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.gold),
                      ),
                      child: Row(
                        spacing: 2,
                        children: [
                          Icon(Icons.star, size: 12, color: AppColors.gold),
                          Text(
                            motel.media.toString(),
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: AppColors.black2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${motel.qtdAvaliacoes} avaliações",
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: AppColors.black2),
                    ),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: AppColors.black2,
                      size: 20,
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          Icon(Icons.favorite_border),
        ],
      ),
    );
  }

  Widget suiteImages(SuiteModel quarto) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(quarto.fotos[0]),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200,
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                quarto.nome,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.black2),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget suiteItems(SuiteModel quarto) {
    return SizedBox(
      height: 75,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.from(
              quarto.categoriaItens
                  .take(4)
                  .map(
                    (e) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.grey1,
                      ),
                      child: Image.network(e.icone, width: 36),
                    ),
                  )
                  .toList()
                ..add(
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 32),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: Text(
                                      quarto.nome,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: AppColors.black2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(child: Divider(thickness: 0.3)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          "principais itens",
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        ),
                                      ),
                                      Expanded(child: Divider(thickness: 0.3)),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  Wrap(
                                    spacing: 16,
                                    runSpacing: 16,
                                    children:
                                        quarto.categoriaItens.map((e) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: 4,
                                            children: [
                                              Image.network(e.icone, width: 24),
                                              Text(
                                                e.nome,
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.bodySmall,
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                  ),
                                  SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(child: Divider(thickness: 0.3)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          "tem também",
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        ),
                                      ),
                                      Expanded(child: Divider(thickness: 0.3)),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Text(
                                      quarto.itens
                                          .map((e) => e.nome)
                                          .join(", "),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "ver\ntodos",
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Icon(Icons.arrow_drop_down, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }

  Widget periodos(SuiteModel quarto) {
    return Column(
      children: List.from(
        quarto.periodos.map((e) {
          return SizedBox(
            height: 100,
            child: Card(
              child: Padding(
                padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              e.tempoFormatado.toString(),
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: AppColors.black2),
                            ),
                            Visibility(
                              visible: e.desconto != null,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.turquoise,
                                    ),
                                  ),
                                  child: Text(
                                    "${((1 - (e.valorTotal / e.valor)) * 100).round()}% OFF",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: AppColors.turquoise),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "R\$ ${e.valor.toStringAsFixed(2).replaceAll('.', ',')}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color:
                                    e.desconto != null
                                        ? AppColors.grey3
                                        : AppColors.black2,

                                decoration:
                                    e.desconto != null
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                decorationColor: AppColors.grey3,
                              ),
                            ),
                            Visibility(
                              visible: e.desconto != null,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  "R\$ ${e.valorTotal.toStringAsFixed(2).replaceAll('.', ',')}",
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(color: AppColors.black2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.grey3,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
