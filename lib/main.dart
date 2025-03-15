import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/core/styles/colors.dart';
import 'package:starzinfinite/features/home/presentation/providers/tipovuelo_provider.dart';
import 'package:starzinfinite/features/reservas/presentation/providers/reservas_provider.dart';
import 'features/auth/presentation/controller/auth_provider.dart';
import 'features/auth/presentation/pages.dart';
import 'features/home/data/datasources/aeropuerto_local_ds.dart';
import 'features/home/data/repositories/aeropuertos_repository_impl.dart';
import 'features/home/domain/usercases/get_aeropuertos.dart';
import 'features/home/presentation/providers/aeropuerto_provider.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/home/presentation/providers/pasajeros_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Importaciones para inyección de dependencias
import 'features/vuelos/presentation/bloc/flight_bloc.dart';
import 'service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");

  // Configura el contenedor de inyección
  await setupLocator();

  // Dependencias de Aeropuertos
  final aeropuertosRepository =
      AeropuertosRepositoryImpl(AeropuertosLocalDataSourceImpl());
  final getAeropuertos = GetAeropuertos(aeropuertosRepository);

  runApp(MyApp(getAeropuertos: getAeropuertos));
}

class MyApp extends StatelessWidget {
  final GetAeropuertos getAeropuertos;

  const MyApp({super.key, required this.getAeropuertos});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthState()),
        ChangeNotifierProvider(
            create: (context) => AeropuertosProvider(getAeropuertos)),
        ChangeNotifierProvider(create: (context) => TipoVueloProvider()),
        ChangeNotifierProvider(create: (context) => PasajerosProvider()),
        ChangeNotifierProvider(create: (context) => ReservasProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FlightBloc>(
            create: (context) => sl<FlightBloc>(), // Se obtiene del contenedor
          ),
        ],
        child: MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', 'ES'),
          ],
          title: 'Starz Infinite',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const ColorScheme(
              primary: starzAzul,
              primaryContainer: starzAzulOscuro,
              secondary: starzAzulClaro,
              secondaryContainer: starzAzul,
              surface: blanco,
              background: blanco,
              error: rojo,
              onPrimary: blanco,
              onSecondary: blanco,
              onSurface: blackBeePay,
              onBackground: blackBeePay,
              onError: blanco,
              brightness: Brightness.light,
            ),
          ),
          home: const AuthWrapper(),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authState = Provider.of<AuthState>(context, listen: false);
    bool loggedIn = await authState.tryLogin();
    print(loggedIn);
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    if (!loggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);

    if (_isLoading) {
      return const SplashScreen();
    } else {
      return authState.isAuthorized ? const HomeScreen() : const LoginPage();
    }
  }
}
