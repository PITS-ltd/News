import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        channelShowBadge: true,
        channelDescription: 'test',
      ),
    ],
  );
  runApp(const MyApp());
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
      create: (context) =>
      NewsBloc()
        ..add(NewsGet(0)),
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
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.purple,
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
                              decoration: InputDecoration(
                                label: Text('Search in local storage'),
                                  prefixIcon: SvgPicture.asset(
                                    fit: BoxFit.scaleDown,
                                'assets/search.svg',
                              )),
                              onChanged: (text) {
                                context
                                    .read<NewsBloc>()
                                    .add(NewsSearchEvent(text));
                              })
                      )),
                  Visibility(
                      visible: !state.pageState.isOffline,
                      child: SizedBox(
                        height: 80,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: state.pageState.category.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  child: Chip(
                                    label:
                                    Text(state.pageState.category[index], style: TextStyle(color: Colors.white),),
                                    backgroundColor:
                                    index == state.pageState.selectedCat
                                        ? Colors.purple
                                        : Colors.purple[200],
                                  ),
                                  onTap: () {
                                    context
                                        .read<NewsBloc>()
                                        .add(NewsGet(index));
                                  },
                                ),
                              );
                            }),
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
                                            builder: (context) =>
                                                WebViewExample(
                                                  url: results[index].url ??
                                                      'https://www.nytimes.com',
                                                )),
                                      );
                                    }
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      //set border radius more than 50% of height and width to make circle
                                    ),
                                    color: Colors.purple,
                                    child: Column(
                                      children: [
                                        Image.network(state.pageState.results[index].multimedia.first.url,
                                          errorBuilder: (BuildContext context, Object exception,
                                              StackTrace? stackTrace) {
                                            return const SizedBox();
                                          },
                                        ),
                                        ListTile(
                                          title: Text(
                                            results[index].title ?? '',
                                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: SvgPicture.asset(
                                            fit: BoxFit.scaleDown,
                                            'assets/angle-right.svg',
                                          ),
                                        ),
                                      ],
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
