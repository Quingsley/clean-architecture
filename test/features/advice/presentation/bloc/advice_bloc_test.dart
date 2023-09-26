import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/features/advice/presentation/bloc/advice_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('AdviceBloc', () {
    group('should emit', () {
      blocTest<AdviceBloc, AdviceState>(
        'nothing when when no event is added',
        build: () => AdviceBloc(),
        expect: () => <AdviceState>[],
      );
      blocTest<AdviceBloc, AdviceState>(
        '[AdviceLoadingState], [AdviceErrorState] when [AdviceGetEvent] is added',
        build: () => AdviceBloc(),
        act: (bloc) => bloc.add(AdviceGetEvent()),
        wait: const Duration(seconds: 1),
        expect: () => <AdviceState>[
          AdviceLoadingState(),
          const AdviceErrorState(message: 'Error message'),
        ],
      );
    });
  });
}
