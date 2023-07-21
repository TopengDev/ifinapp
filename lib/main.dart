import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthenticationService authenticationService;
  late UserService userService;

  @override
  void initState() {
    authenticationService = AuthenticationService();
    userService = UserService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => authenticationService,
        ),
        RepositoryProvider(
          create: (context) => userService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationDataCubit(
              authenticationService: authenticationService,
            )..init(),
          ),
          BlocProvider(
            create: (context) => UserCubit(
              userService: userService,
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ifin',
            theme: ThemeData.light().copyWith(
              primaryColor: primaryColor,
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
                background: primaryColor,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: primaryColor,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: primaryColor,
                ),
              ),
            ),
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
            ),
            onGenerateRoute: RouteConfig.onGenerateRoute,
          );
        }),
      ),
    );
  }
}
