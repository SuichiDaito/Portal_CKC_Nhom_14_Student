import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_ckc/api/controller/call_api_student.dart';
import 'package:portal_ckc/api/services/student_service.dart';
import 'package:portal_ckc/bloc/bloc_event_state/certificates_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/change_password_friendly_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/class_subject_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/danh_sach_sinh_vien_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/delete_report_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/exam_second_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/info_teacher_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/logoutn_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/notificate_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/paper_certificates_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_class_subject_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_exam_second_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/payment_fee_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/response_change_password.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sign_up_certificates_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_comment_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_point_result_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_report_response_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/subject_fail_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/time_table_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/training_point_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/training_program_bloc.dart';
import 'package:portal_ckc/bloc/state/student_state.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
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
      providers: [
        BlocProvider(create: (_) => StudentBloc()),
        BlocProvider(create: (_) => CertificatesBloc()),
        BlocProvider(create: (_) => TrainingPointBloc()),
        BlocProvider(create: (_) => StudentReportResponseBloc()),
        BlocProvider(create: (_) => PaperCertificatesBloc()),
        BlocProvider(create: (_) => StudentPointResultBloc()),
        BlocProvider(create: (_) => PaymentBloc()),
        BlocProvider(create: (_) => ExamBloc()),
        BlocProvider(create: (_) => SignUpCertificatesBloc()),
        BlocProvider(create: (_) => InfoTeacherBloc()),
        BlocProvider(create: (_) => TimeTableBloc()),
        BlocProvider(create: (_) => TrainingProgramBloc()),
        BlocProvider(create: (_) => RequestPaymenFee()),
        BlocProvider(create: (_) => NotificateBloc()),
        BlocProvider(create: (_) => ChangePasswordFriendlyBloc()),
        BlocProvider(create: (_) => ExamSecondBloc()),
        BlocProvider(create: (_) => PaymentExamSecondBloc()),
        BlocProvider(create: (_) => SubjectFailBloc()),
        BlocProvider(create: (_) => ClassSubjectBloc()),
        BlocProvider(create: (_) => PaymentClassSubjectBloc()),
        BlocProvider(create: (_) => CommentBloc()),
        BlocProvider(create: (_) => LogoutBloc()),
        BlocProvider(create: (_) => ListStudentBloc()),
        BlocProvider(create: (_) => ResponseChangePasswordBloc()),
        BlocProvider(create: (_) => DeleteReportBloc()),
      ],
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
