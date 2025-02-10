import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:teste_guia_de_moteis/src/data/models/motel_model.dart';
import 'package:teste_guia_de_moteis/src/data/models/response_model.dart';
import 'package:teste_guia_de_moteis/src/data/models/suite_model.dart';
import 'package:teste_guia_de_moteis/src/data/repositories/motels_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_guia_de_moteis/src/core/http_client/http_client_interface.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_guia_de_moteis/src/domain/repositories/motels_repository.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/home_page.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/home_viewmodel.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/widgets/go_now.dart';

import '../../repositories/response_mock.dart';

class MockHttpClientService extends Mock implements IHttpClientService {
  @override
  Future<http.Response> get(
    String path, {
    String? unencodedPath,
    Map<String, String>? headers,
  }) {
    return super.noSuchMethod(
      Invocation.method(
        #get,
        [path],
        {#unencodedPath: unencodedPath, #headers: headers},
      ),
      returnValue: Future.value(
        http.Response(jsonEncode(ResponseMockTest.mock), 200),
      ),
      returnValueForMissingStub: Future.value(
        http.Response(jsonEncode(ResponseMockTest.mock), 200),
      ),
    );
  }
}

class MockHomeViewmodel extends HomeViewmodel {
  MockHomeViewmodel(IMotelsRepository motelsRepository)
    : super(motelsRepository);

  /* ResponseModel */
  ResponseModel? _responseModel;
  @override
  ResponseModel? get responseModel => _responseModel;

  @override
  Future<void> getMotels() async {
    try {
      _responseModel = ResponseModel.fromJson(ResponseMockTest.mock["data"]);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  /* Filters */
  List<String> getFilters() {
    final filters = <String>{};
    _responseModel?.moteis.forEach((motel) {
      for (var suite in motel.suites) {
        for (var item in suite.categoriaItens) {
          filters.add(item.nome);
        }
      }
    });
    return filters.toList();
  }
}

void main() {
  late MockHttpClientService mockHttpClientService;
  late MotelsRepository repository;
  late MockHomeViewmodel viewModel;

  setUp(() {
    mockHttpClientService = MockHttpClientService();
    repository = MotelsRepository(mockHttpClientService);
    viewModel = MockHomeViewmodel(repository);
  });

  Widget goHomePage() {
    return Builder(builder: (context) => HomePage());
  }

  Widget goNowPage() {
    return Builder(
      builder: (context) => GoNowPage(viewModel: viewModel, context: context),
    );
  }

  Widget goNowPageMotelInfos(MotelModel motel) {
    return Builder(
      builder:
          (context) => GoNowPage(
            viewModel: viewModel,
            context: context,
          ).motelInfos(motel),
    );
  }

  Widget goNowPageFilters() {
    return Builder(
      builder:
          (context) =>
              GoNowPage(viewModel: viewModel, context: context).filters(),
    );
  }

  Widget goNowPageSuiteImages(SuiteModel suite) {
    return Builder(
      builder:
          (context) => GoNowPage(
            viewModel: viewModel,
            context: context,
          ).suiteImages(suite),
    );
  }

  Widget goNowPagePeriodos(SuiteModel suite) {
    return Builder(
      builder:
          (context) =>
              GoNowPage(viewModel: viewModel, context: context).periodos(suite),
    );
  }

  Widget createWidgetUnderTest(Widget child) {
    return MultiProvider(
      providers: [
        Provider<IMotelsRepository>.value(value: repository),
        ChangeNotifierProvider<HomeViewmodel>.value(value: viewModel),
      ],
      child: MaterialApp(home: child),
    );
  }

  testWidgets('should display loading indicator while fetching data', (
    WidgetTester tester,
  ) async {
    when(mockHttpClientService.get("any")).thenAnswer(
      (_) async =>
          Future.value(http.Response(jsonEncode(ResponseMockTest.mock), 200)),
    );

    await tester.pumpWidget(createWidgetUnderTest(goNowPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should switch tabs when a tab is tapped', (
    WidgetTester tester,
  ) async {
    when(mockHttpClientService.get("any")).thenAnswer(
      (_) async =>
          Future.value(http.Response(jsonEncode(ResponseMockTest.mock), 200)),
    );

    await tester.pumpWidget(createWidgetUnderTest(goHomePage()));
    expect(find.byType(TabBarView), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await viewModel.getMotels();
    await mockNetworkImages(
      () async => tester.pumpWidget(createWidgetUnderTest(goHomePage())),
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await mockNetworkImages(() async {
      await tester.pumpWidget(createWidgetUnderTest(goHomePage()));
      viewModel.changeTab(1);
      await tester.pumpAndSettle();

      expect(viewModel.tabIndex, 1);
    });
  });

  testWidgets(
    'should display the motels name when data is fetched successfully',
    (WidgetTester tester) async {
      when(mockHttpClientService.get("any")).thenAnswer(
        (_) async => Future.value(
          http.Response(json.encode(ResponseMockTest.mock), 200),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await viewModel.getMotels();
      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await mockNetworkImages(
        () async => tester.pumpWidget(
          createWidgetUnderTest(
            goNowPageMotelInfos(viewModel.responseModel!.moteis[0]),
          ),
        ),
      );
      expect(
        find.text(viewModel.responseModel?.moteis[0].fantasia ?? ""),
        findsOneWidget,
      );
      expect(
        find.text(viewModel.responseModel?.moteis[0].bairro ?? ""),
        findsOneWidget,
      );
      expect(
        find.textContaining(
          viewModel.responseModel?.moteis[0].qtdAvaliacoes.toString() ?? "",
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'should display the list of suites when data is fetched successfully',
    (WidgetTester tester) async {
      when(mockHttpClientService.get("any")).thenAnswer(
        (_) async => Future.value(
          http.Response(json.encode(ResponseMockTest.mock), 200),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await viewModel.getMotels();
      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await mockNetworkImages(
        () async => tester.pumpWidget(
          createWidgetUnderTest(
            goNowPageSuiteImages(viewModel.responseModel!.moteis[0].suites[0]),
          ),
        ),
      );
      expect(
        find.text(viewModel.responseModel?.moteis[0].suites[0].nome ?? ""),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'should display the list items of the suite when data is fetched successfully',
    (WidgetTester tester) async {
      when(mockHttpClientService.get("any")).thenAnswer(
        (_) async => Future.value(
          http.Response(json.encode(ResponseMockTest.mock), 200),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await viewModel.getMotels();
      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await mockNetworkImages(
        () async => tester.pumpWidget(
          createWidgetUnderTest(
            goNowPagePeriodos(viewModel.responseModel!.moteis[0].suites[0]),
          ),
        ),
      );
      expect(
        find.text(
          viewModel
                  .responseModel
                  ?.moteis[0]
                  .suites[0]
                  .periodos[0]
                  .tempoFormatado ??
              "",
        ),
        findsOneWidget,
      );

      expect(
        find.text(
          viewModel.formatCurrency(
            viewModel.responseModel!.moteis[0].suites[0].periodos[0].valor,
          ),
        ),
        findsOneWidget,
      );

      expect(
        find.text(
          viewModel.formatCurrency(
            viewModel
                    .responseModel!
                    .moteis[0]
                    .suites[0]
                    .periodos[0]
                    .desconto
                    ?.desconto ??
                0,
          ),
        ),
        findsNothing,
      );

      expect(
        find.text(
          viewModel.formatCurrency(
            viewModel.responseModel!.moteis[0].suites[0].periodos[2].valor,
          ),
        ),
        findsOne,
      );
      expect(
        find.text(
          viewModel.formatCurrency(
            viewModel.responseModel!.moteis[0].suites[0].periodos[2].valorTotal,
          ),
        ),
        findsOne,
      );
      expect(
        find.text(
          viewModel.formatDiscount(
            viewModel.responseModel!.moteis[0].suites[0].periodos[2].valorTotal,
            viewModel.responseModel!.moteis[0].suites[0].periodos[2].valor,
          ),
        ),
        findsOne,
      );
    },
  );

  testWidgets(
    'should display the filtered list of suites when data is fetched successfully',
    (WidgetTester tester) async {
      when(mockHttpClientService.get("any")).thenAnswer(
        (_) async => Future.value(
          http.Response(json.encode(ResponseMockTest.mock), 200),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await viewModel.getMotels();
      await tester.pumpWidget(createWidgetUnderTest(goNowPage()));
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await mockNetworkImages(
        () async =>
            tester.pumpWidget(createWidgetUnderTest(goNowPageFilters())),
      );
      expect(
        find.text(
          viewModel.responseModel?.moteis[0].suites[0].categoriaItens[0].nome ??
              "",
        ),
        findsOneWidget,
      );
    },
  );
}
