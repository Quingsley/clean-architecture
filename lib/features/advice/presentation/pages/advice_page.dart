import 'package:clean_architecture/features/advice/presentation/cubit/advice_cubit.dart';
import 'package:clean_architecture/features/advice/presentation/widgets/advice_field.dart';
import 'package:clean_architecture/features/advice/presentation/widgets/custom_button.dart';
import 'package:clean_architecture/features/advice/presentation/widgets/error_message.dart';
import 'package:clean_architecture/injection.dart';
import 'package:clean_architecture/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AdviceCubit>(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends ConsumerWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDarkModeOn = ref.watch(themeService);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adviser',
          style: theme.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
              value: isDarkModeOn,
              onChanged: (val) {
                ref.read(themeService.notifier).state = val;
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Center(
              child: BlocBuilder<AdviceCubit, AdviceCubitState>(
                builder: (context, state) {
                  if (state is AdviceLoadingState) {
                    return CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.secondary),
                    );
                  } else if (state is AdviceLoadedState) {
                    return AdviceField(advice: state.advice);
                  } else if (state is AdviceErrorState) {
                    return ErrorMessage(message: state.message);
                  } else if (state is AdviceInitial) {
                    return Text(
                      'Your Advice is waiting for you!',
                      style: theme.textTheme.displayLarge,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )),
            const SizedBox(
              height: 200,
              child: Center(child: CustomButton()),
            ),
          ],
        ),
      ),
    );
  }
}
