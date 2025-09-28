import 'package:appwrite/models.dart' show Row;
import 'package:flutter/material.dart' hide Row;
import 'package:flutter_educational_shop/pages/ProfilePage.dart';
import 'package:flutter_educational_shop/ui/ChangeThemeBtn.dart';
import 'package:flutter_educational_shop/models/KpiDataCard.dart';
import 'package:flutter_educational_shop/models/ProgressBar.dart';
import 'package:flutter_educational_shop/ui/SignOut.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_educational_shop/ui/createKPIBtn.dart';
import 'package:flutter_educational_shop/widgets/createKPIWidget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Create New KPI"),
                content: CreateKPIWidget(),
                actions: [
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
