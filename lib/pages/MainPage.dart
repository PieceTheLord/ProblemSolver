import 'package:appwrite/models.dart' show Row;
import 'package:flutter/material.dart' hide Row;
import 'package:flutter_educational_shop/components/KpiDataCard.dart';
import 'package:flutter_educational_shop/components/ProgressBar.dart';
import 'package:flutter_educational_shop/components/UserDataCard.dart';
import 'package:flutter_educational_shop/pages/AppPage.dart';
import 'package:flutter_educational_shop/services/appwrite_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController kpiTitleController = TextEditingController();
  TextEditingController kpiGoalController = TextEditingController();
  List<Row> data = [];
  List<Row> kpis = [];

  Future<void> getKpis() async {
    List<Row> kpisData = (await appwrite.getAllKPIs()).cast<Row>();
    setState(() {
      kpis = kpisData;
    });
  }

  Future<void> clearKPIs() async {
    setState(() {
      kpis.clear();
    });
  }

  Future<void> getUsers() async {
    List<Row> users = (await appwrite.getUsers()).cast<Row>();
    setState(() {
      data = users;
    });
  }

  void clearUsers() {
    setState(() {
      data.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: data.map((e) => UserDataCard(row: e)).toList()),
            ElevatedButton(onPressed: getUsers, child: const Text("get users")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: clearUsers, child: const Text("clear")),
            SizedBox(height: 20),
            SizedBox(height: 20),
            TextField(
              controller: kpiTitleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: kpiGoalController,
              decoration: const InputDecoration(
                labelText: "Goal",
                border: OutlineInputBorder(),
              ),
            ),
            ProgressBarExample(),
            SizedBox(
              width: 700, // Set the desired width
              child: GridView.count(
                crossAxisCount: 1,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                childAspectRatio: 10,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await appwrite.insertKpiData(
                        title: kpiTitleController.text,
                        goal: kpiGoalController.text,
                      );
                    },
                    child: Text("Create KPI"),
                  ),
                  ElevatedButton(
                    onPressed: getKpis,
                    child: const Text("get KPIs"),
                  ),
                  ElevatedButton(
                    onPressed: clearKPIs,
                    child: const Text("clear KPIs"),
                  ),
                ],
              ),
            ),
            Column(
              children: kpis
                  .map(
                    (e) => KpiDataCard(
                      title: e.data["title"],
                      goal: e.data["goal"] ?? "N/A",
                      createdAt: e.$createdAt,
                      updatedAt: e.$updatedAt,
                    ),
                  )
                  .toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                await appwrite.account.deleteSession(sessionId: 'current');
                await Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => AppPage()));
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
