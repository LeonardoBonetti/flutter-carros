import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listView.dart';
import 'package:carros/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = await Prefs.getInt("tabIdx");
    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carro"),
        centerTitle: true,
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [Tab(text: "Clássicos"), Tab(text: "Esportivos"), Tab(text: "Luxo")],
              ),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                CarrosListView(TipoCarro.luxo),
                CarrosListView(TipoCarro.esportivos),
                CarrosListView(TipoCarro.luxo),
              ],
            ),
      drawer: DrawerList(),
    );
  }
}
