import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/services/student_service.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/state/bloc_state.dart';
import 'package:portal_ckc/bloc/event/bloc_event.dart';
import 'package:portal_ckc/l10n/app_localizations.dart';
import 'package:portal_ckc/api/model/comment.dart';
import 'package:portal_ckc/presentation/sections/button/button_login.dart';
import 'package:portal_ckc/routes/app_route.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => StudentBloc())],
      child: MaterialApp.router(
        routerConfig: RouteName.route,
        debugShowCheckedModeBanner: false,
        title: 'Portal_CKC',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}

class DebugContextWidget extends StatelessWidget {
  final String name;
  const DebugContextWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    print('[$name] Navigator hash: ${Navigator.of(context)}');
    print(
      '[Logout Screen] rootNavigatorKey context: ${RouteName.rootNavigatorKey.currentContext}',
    );
    print(
      '[Logout Screen] rootNavigator Navigator: ${Navigator.of(RouteName.rootNavigatorKey.currentContext!)}',
    );

    return Container();
  }
}
