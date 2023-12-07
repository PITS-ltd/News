import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news/core/globals/globals.dart';
import 'package:news/data/model/news.dart';
import 'package:news/futures/core_widgets/card_news.dart';
import 'package:news/futures/main/bloc/news_bloc.dart';
import 'package:news/futures/web_view_news/web_view_container.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true, channelDescription: 'test',
      ),
    ],
  );  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  final myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(NewsGet()),
      child: BlocConsumer<NewsBloc, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (state is NewsError) {
            return Scaffold(
              body: Center(child: Text(state.pageState.error)),
            );
          }
          List<Results> results = state.pageState.results;
          return Scaffold(
            appBar: AppBar(
              title: Text("News update at ${state.pageState.dateTime}"),
            ),
            body: Center(
              child: Column(
                children: [
                  Visibility(
                    visible: state.pageState.isOffline,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: myController,
                            onChanged: (text) {
                              print('e;flpvepok ${state.pageState.results.length}');
                              context.read<NewsBloc>().add(NewsSearchEvent(text));
                            }
                        )
                      )),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: results.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (results[index].url?.isNotEmpty ??
                                    false) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebViewExample(
                                              url: results[index].url ?? 'https://www.nytimes.com',
                                            )),
                                  );
                                }
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    results[index].title ?? '',
                                    style: TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ));
                        }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// // Define a custom Form widget.
// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({super.key});
//
//   @override
//   State<MyCustomForm> createState() => _MyCustomFormState();
// }
//
// // Define a corresponding State class.
// // This class holds data related to the Form.
// class _MyCustomFormState extends State<MyCustomForm> {
//   // Create a text controller. Later, use it to retrieve the
//   // current value of the TextField.
//
//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     myController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//       create: (context) => NewsBloc(),
//       child: BlocConsumer<NewsBloc, NewsState>(
//         listener: (context, state) {
//           // TODO: implement listener
//         },
//         builder: (context, state) {
//           return
//         },
//       ),
//     );
//
//   }
// }
