import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroll_social_assignment/theme/app_theme.dart';
import 'package:stroll_social_assignment/utils/app_strings.dart';
import 'core/bloc_observer.dart';
import 'features/task1/presentation/bloc/header_bloc/header_bloc.dart';
import 'features/task1/presentation/bloc/question_bloc/question_bloc.dart';
import 'features/task1/presentation/bloc/user_bloc/user_bloc.dart';
import 'features/task2/presentation/pages/recording_page.dart';
import 'features/task2/presentation/recorder_bloc/recorder_bloc.dart';
import 'package:stroll_social_assignment/features/task1/presentation/bloc/question_bloc/question_bloc_event.dart'
    as question_bloc_event;
import 'package:stroll_social_assignment/features/task1/presentation/bloc/user_bloc/user_bloc_event.dart'
    as user_bloc_event;
import 'features/task1/presentation/bloc/header_bloc/header_bloc_event.dart'
    as header_bloc_event;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => sl<UserBloc>()..add(const user_bloc_event.GetData()),
        ),
        BlocProvider(
          create: (_) =>
              sl<QuestionBloc>()..add(const question_bloc_event.GetData()),
        ),
        BlocProvider(
          create: (_) =>
              sl<HeaderBloc>()..add(const header_bloc_event.GetData()),
        ),
        BlocProvider(
          create: (_) => sl<RecorderBloc>(),
        ),
      ], child: const RecordingPage()),
    );
  }
}
