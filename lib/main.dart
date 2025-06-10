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
  Future<List<dynamic>> getApi() async {
    // comments: Response<List<Comment>>
    final List<dynamic> list;
    final response = await CallApi.postServices.getComments();
    if (response.statusCode == 200) {
      final jsonData = response.body;
      list = jsonData.map((comment) => Comment.fromJson(comment)).toList();
      return list;
    } else {
      throw Exception('Failed to load');
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
              final data = snapshot.data! ;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Text(data[index].id);
                },
              );
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
