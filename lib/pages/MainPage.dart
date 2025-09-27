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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getKpis(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> kpis = ref.watch(kpisProvider);
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
                      await getKpis(ref);
                    },
                    child: Text("Create KPI"),
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
                      rowID: e.$id,
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
