import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/globals/globals.dart';
import 'package:news/data/model/news.dart';
import 'package:news/futures/core_widgets/card_news.dart';
import 'package:news/futures/main/bloc/news_bloc.dart';
import 'package:news/futures/web_view_news/web_view_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey, // <= this

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
          News? news = state.pageState.news;
          return Scaffold(
            appBar: AppBar(
              title: const Text("News"),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      onPressed: () =>
                          context.read<NewsBloc>().add(NewsMakeAllReadEvent()),
                      icon: const Icon(Icons.checklist_outlined),
                    )),
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: news?.articles.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CardNews(
                                  imgUrl: news?.articles[index].urlToImage,
                                  title: news?.articles[index].title));
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: news?.articles.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (news?.articles[index].url?.isNotEmpty ??
                                    false) {
                                  context
                                      .read<NewsBloc>()
                                      .add(NewsMakeOneReadEvent(index));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebViewExample(
                                              url: news!.articles[index].url!,
                                            )),
                                  );
                                }
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    news?.articles[index].title ?? '' ,style: TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: state.pageState.isRead[index]
                                      ? const Icon(
                                          Icons.done_outlined,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.notification_important_outlined,
                                          color: Colors.red,
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
