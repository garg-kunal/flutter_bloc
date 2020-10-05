import 'package:flutter/material.dart';
import 'home_viewmodel.dart';
import 'package:stacked/stacked.dart';


class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeView>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: new AppBar(
                title: new Text(model.title),
              ),
              body: new Column(
                children: [
                  new Text(model.count.toString()),
                  new RaisedButton(
                      child: new Text('Plus'),
                      onPressed: () {
                        model.updatecount();
                      }),
                ],
              ),
            ),
        viewModelBuilder: () => new HomeView());
  }
}
