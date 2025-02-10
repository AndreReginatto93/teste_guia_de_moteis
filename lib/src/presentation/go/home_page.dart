import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_guia_de_moteis/src/core/themes/colors.dart';
import 'package:teste_guia_de_moteis/src/core/themes/dimens.dart';
import 'package:teste_guia_de_moteis/src/data/models/motel_model.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/home_viewmodel.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/widgets/go_now.dart';

class HomePage extends StatefulWidget {
  static const route = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomeViewmodel viewModel = HomeViewmodel(context.read())..getMotels();

  late final TabController? _tabController = TabController(
    length: 2,
    vsync: this,
  )..addListener(() {
    viewModel.changeTab(_tabController!.index);
  });

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Column(
          children: [
            header(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey1,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: TabBarView(
                  // dragStartBehavior: DragStartBehavior.down,
                  controller: _tabController,
                  children: [
                    GoNowPage(viewModel: viewModel, context: context),
                    Center(child: Text('Página "Ir Outro Dia"')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.only(
        left: Dimens.paddingHorizontal,
        right: Dimens.paddingHorizontal,
        top: Dimens.paddingVertical,
      ),
      height: 100,
      child: Column(
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.list, color: AppColors.white1),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blackTransparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tabButton(
                      tabName: "ir agora",
                      icon: Icons.flash_on,
                      index: 0,
                    ),
                    tabButton(
                      tabName: "ir outro dia",
                      icon: Icons.calendar_today,
                      index: 1,
                    ),
                  ],
                ),
              ),
              Icon(Icons.search, color: AppColors.white1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "grande sp",
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: AppColors.white1),
              ),
              Icon(Icons.arrow_drop_down, size: 18, color: AppColors.white1),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabButton({
    required String tabName,
    required IconData icon,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => _tabController?.animateTo(index),
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color:
                  viewModel.tabIndex == index
                      ? AppColors.white1
                      : AppColors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              spacing: 4,
              children: [
                Icon(
                  icon,
                  color:
                      viewModel.tabIndex == index
                          ? AppColors.red1
                          : AppColors.white1,
                  size: 16,
                ),
                Text(
                  tabName,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color:
                        viewModel.tabIndex == index
                            ? AppColors.black1
                            : AppColors.white1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
