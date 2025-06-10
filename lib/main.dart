import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portal_ckc/api/controller/call_api.dart';
import 'package:portal_ckc/l10n/app_localizations.dart';
import 'package:portal_ckc/api/model/comment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal_CKC',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> getApi() async {
    // try {
    //   final response = await CallApi.postServices.getPosts();
    //   if (response.isSuccessful) {
    //     print(response.body);
    //   } else {
    //     print(response.error);
    //   }
    // } catch (Ex) {
    //   Error.safeToString(Ex);
    // }

    // comments: Response<List<Comment>>
    final response = await CallApi.postServices.getComments();
    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context!).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: getApi(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              print(snapshot);
              return Text('Data: Has data');
            } else if (snapshot.hasError) {
              return Text('Error Data');
            } else {
              return Text("No data");
            }
          },
        ),
      ),
    );
  }
}
