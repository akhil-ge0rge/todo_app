import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/authentication/app/user_provider.dart';

import 'core/res/colurs.dart';
import 'features/onboarding/views/onboarding_screen.dart';
import 'features/todo/views/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 867.4),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ToDo App',
              theme: ThemeData(
                scaffoldBackgroundColor: AppColurs.darkBackground,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: ref.watch(userProvider).when(data: (userExists) {
                if (userExists) return const HomeScreen();
                return const OnBoardingScreen();
              }, error: (error, stackTrace) {
                debugPrint(error.toString());
                debugPrint(stackTrace.toString());
                return const OnBoardingScreen();
              }, loading: () {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
            ));
  }
}
