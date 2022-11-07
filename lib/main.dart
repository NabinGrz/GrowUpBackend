import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:growup/adapters/practicerecord.dart';
import 'package:growup/adapters/quizhistory.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/courseadapter/studentcourse.dart';
import 'package:growup/downloads/download_provider.dart';
import 'package:growup/screens/paymentscreen/khalti_payment.dart';
import 'package:growup/screens/splash_screen/splashscreen.dart';
import 'package:growup/utility/easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuizHistoryAdapter());
  Hive.registerAdapter(StudentCourseAdapter());
  Hive.registerAdapter(PracticeRecordAdapter());
  await Hive.openBox<PracticeRecord>('practice');
  await Hive.openBox<QuizHistory>('history');
  await Hive.openBox<StudentCourse>('course');

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FileDownloaderProvider(),
          child: SplashScreen(),
        ),
      ],
      child: MaterialApp(
          //SplashScreen
          debugShowCheckedModeBanner: false,
          home: SplashScreen())));
  configLoading();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: darkBlueColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Scaffold(
        body: Stack(
          children: const [
            //DrawerScreen(),
            //   Get.to(() => const KhaltiPaymentApp());
            KhaltiPaymentApp(),
          ],
        ),
      ),
    );
  }
}
