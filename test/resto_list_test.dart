import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resto_app/data/model/resto.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/static/resto_list_result_state.dart';
import './mocks/mocks.mocks.dart';

void main() {
  late RestoListProvider provider;
  late MockApiServices mockApiServices;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestoListProvider(mockApiServices);
  });

  group('RestoListProvider Test', () {
    test('State awal provider harus RestoListNoneState', () {
      expect(provider.resultState, isA<RestoListNoneState>());
    });

    test('Harus mengembalikan daftar restoran ketika API sukses', () async {
      // arrange
      final resto = Resto(
        id: "1",
        name: "Resto Enak",
        description: "Deskripsi",
        pictureId: "pic123",
        city: "Jakarta",
        address: "Jl. Sudirman",
        rating: 4.5,
        categories: [],
      );

      final response = RestoListResponse(
        error: false,
        message: "success",
        count: 1,
        restaurants: [resto],
      );

      when(mockApiServices.getrestoList())
          .thenAnswer((_) async => response);

      // act
      await provider.fetchrestoList();

      // assert
      expect(provider.resultState, isA<RestoListLoadedState>());
      final state = provider.resultState as RestoListLoadedState;
      expect(state.data, isNotEmpty);
      expect(state.data.first.name, "Resto Enak");
    });

    test('Harus mengembalikan error ketika API gagal', () async {
      // arrange
      final response = RestoListResponse(
        error: true,
        message: "Failed to load data",
        count: 0,
        restaurants: [],
      );

      when(mockApiServices.getrestoList())
          .thenAnswer((_) async => response);

      // act
      await provider.fetchrestoList();

      // assert
      expect(provider.resultState, isA<RestoListErrorState>());
      final state = provider.resultState as RestoListErrorState;
      expect(state.error, "Failed to load data");
    });
  });
}
