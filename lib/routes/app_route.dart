import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/bloc/bloc_event_state/student_bloc.dart';
import 'package:portal_ckc/bloc/event/student_event.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/pages/page_change_password_student.dart';
import 'package:portal_ckc/presentation/pages/page_show_exam_second_student.dart';
import 'package:portal_ckc/presentation/pages/page_training_program.dart';
import 'package:portal_ckc/presentation/pages/appbar_bottombar/page_app_bar.dart';
import 'package:portal_ckc/presentation/pages/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_roster_admin.dart';
import 'package:portal_ckc/presentation/pages/page_conduct_evaluation_admin.dart';
import 'package:portal_ckc/presentation/pages/page_course_section_student_list.dart';
import 'package:portal_ckc/presentation/pages/page_info_teacher.dart';
import 'package:portal_ckc/presentation/pages/page_list_certificates_for_student.dart';
import 'package:portal_ckc/presentation/pages/page_login.dart';
import 'package:portal_ckc/presentation/pages/page_meeting_minutes_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_payment_study_fee.dart';
import 'package:portal_ckc/presentation/pages/page_report_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_admin.dart';
import 'package:portal_ckc/presentation/pages/page_search_info_general_student.dart';
import 'package:portal_ckc/presentation/pages/page_show_point_student.dart';
import 'package:portal_ckc/presentation/pages/page_signup_certificates.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';
import 'package:portal_ckc/presentation/pages/page_user_detail_information.dart';
import 'package:portal_ckc/presentation/pages/page_main_layout_home_admin.dart';
import 'package:portal_ckc/presentation/pages/appbar_bottombar/page_home_admin.dart';
import 'package:portal_ckc/presentation/pages/page_applications_admin.dart';
import 'package:portal_ckc/presentation/references/page_login_admin.dart';
import 'package:portal_ckc/presentation/references/page_management_group_admin.dart';
import 'package:portal_ckc/presentation/references/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_admin.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';

class RouteName {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellAppBarNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter route = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),

      /// 🔁 ShellRoute dùng `shellNavigatorKey` static
      /// use for home_admin, applications, notifications and user.
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => AdminHomePage(child: child),
        routes: [
          GoRoute(
            path: '/home/admin',
            builder: (context, state) => MainLayoutHomeAdminPage(),
          ),
          ShellRoute(
            navigatorKey: shellAppBarNavigatorKey,
            builder: (context, state, child) =>
                AppBarNavigationHomePage(child: child),
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) => const NotificationPage(),
              ),
              GoRoute(
                path: '/apps',
                builder: (context, state) => const ApplicationsAdminPage(),
              ),
              // DashboardScreen
              GoRoute(
                path: '/admin/information/user',
                builder: (context, state) => const UserDetailInformationPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/admin/class_book_admin',
        builder: (context, state) => const PageClassBookAdmin(),
      ),
      GoRoute(
        path: '/admin/management_group_admin',
        builder: (context, state) => const PageQuanlyphongAdmin(),
      ),
      GoRoute(
        path: '/admin/class_management_admin',
        builder: (context, state) => PageClassManagementAdmin(),
      ),
      GoRoute(
        path: '/admin/class_detail_admin',
        builder: (context, state) => PageClassDetailAdmin(),
      ),
      GoRoute(
        path: '/admin/conduct_evaluation_admin',
        builder: (context, state) => PageConductEvaluationAdmin(),
      ),

      GoRoute(
        path: '/admin/class_roster_admin',
        builder: (context, state) => PageClassRosterAdmin(),
      ),
      GoRoute(
        path: '/admin/meeting_minutes_admin',
        builder: (context, state) => PageMeetingMinutesAdmin(),
      ),
      GoRoute(
        path: '/admin/teaching_schedule_admin',
        builder: (context, state) => PageTeachingScheduleAdmin(),
      ),

      GoRoute(
        path: '/admin/course_student_list',
        builder: (context, state) => PageCourseSectionStudentList(),
      ),
      GoRoute(
        path: '/admin/exam_schedule_admin',
        builder: (context, state) => PageExamScheduleAdmin(),
      ),
      //LecturerInfoScreen
      GoRoute(
        path: '/student/info/teacher',
        builder: (context, state) => LecturerInfoScreen(),
      ),
      GoRoute(
        path: '/admin/report_detail_admin',
        builder: (context, state) => PageReportDetailAdmin(),
      ),
      // CertificateRegistrationScreen
      GoRoute(
        path: '/student/signup/certificates',
        builder: (context, state) => CertificateRegistrationScreen(),
      ),
      GoRoute(
        path: '/student/show/point',
        builder: (context, state) => StudentGradeScreen(),
      ),
      //ExamSchedulePage
      GoRoute(
        path: '/student/exam/second',
        builder: (context, state) => ExamSchedulePage(),
      ),
      //ChangePasswordScreen
      GoRoute(
        path: '/student/change/password',
        builder: (context, state) => ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/student/training/program',
        builder: (context, state) => TrainingProgramScreen(),
      ),
      GoRoute(
        path: '/student/list/certificates',
        builder: (context, state) {
          return DocumentListPage();
        },
      ),
      //TuitionFeeScreen
      GoRoute(
        path: '/student/payment',
        builder: (context, state) {
          return TuitionFeeScreen();
        },
      ),
      GoRoute(
        path: '/student/search/tuition',
        builder: (context, state) => PageSearchInfoGeneralStudent(),
      ),
      GoRoute(
        path: '/notifications/detail/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return NotificationDetailPage(id: 1);
        },
      ),
    ],
  );
}
