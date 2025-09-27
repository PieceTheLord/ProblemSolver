import 'package:appwrite/models.dart' show Row;
import 'package:flutter/material.dart' hide Row;
import 'package:flutter_educational_shop/pages/ProfilePage.dart';
import 'package:flutter_educational_shop/ui/ChangeThemeBtn.dart';
import 'package:flutter_educational_shop/models/KpiDataCard.dart';
import 'package:flutter_educational_shop/models/ProgressBar.dart';
import 'package:flutter_educational_shop/ui/SignOut.dart';
import 'package:flutter_educational_shop/models/UserDataCard.dart';
import 'package:flutter_educational_shop/features/appwrite_service.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => Profilepage())),
          ),
        ],
      ),
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
            TaskProgressBar(),
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
            Text(ref.watch(isAuth)?.email ?? ""),
            SignOut(),
            ChangeThemeBtn(),
          ],
        ),
      ),
    );
  }
}
