import 'package:flutter/material.dart';

class CalendarScrollView extends StatefulWidget {
  CalendarScrollView({super.key});

  @override
  State<CalendarScrollView> createState() => _CalendarScrollViewState();
}

class _CalendarScrollViewState extends State<CalendarScrollView> {
  final List<int> shades = [100, 200, 300, 400, 500, 600, 700, 800, 900];
  final List<String> daysOfTheWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  late ScrollController _horizontal0;
  late ScrollController _horizontal1;

  late ScrollController _vertical0; //for scrolling table vertically
  late ScrollController _vertical1; //for scrolling left column vertically

  @override
  void initState() {
    super.initState();
    _horizontal0 = ScrollController();
    _horizontal1 = ScrollController();

    _vertical0 = ScrollController();
    _vertical1 = ScrollController();

    _vertical0.addListener(() {
      _vertical1.jumpTo(_vertical0.offset);
    });

    _horizontal0.addListener(() {
      _horizontal1.jumpTo(_horizontal0.offset);
    });
  }

  double? columnSpacing = 120;
  double rowSpacing = 100.0;

  @override
  void dispose() {
    _horizontal0.dispose();
    _vertical1.dispose();
    _vertical0.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 20),
              child: Container(
                // color: Colors.grey,
                height: 20,
                child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    controller: _horizontal1,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 20,
                          width: 100,
                          //color: Colors.primaries[index],
                          child: Center(
                            child: Text(
                              daysOfTheWeek[index],
                              style: TextStyle(
                                color: Colors.primaries[index],
                              ),
                            ),
                          ));
                    }),
              ),
            ),

            //table and left column
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 500,
                  width: 50,
                  child: ListView.builder(
                    controller: _vertical1,
                    itemCount: Colors.primaries.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: rowSpacing + 40,
                        width: 50,
                        child: Center(
                          child: Text(
                            '$index',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //table
                Container(
                  // color: Colors.grey,
                  height: 500,
                  width: 340,
                  child: Scrollbar(
                    controller: _vertical0,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: Scrollbar(
                      controller: _horizontal0,
                      thumbVisibility: true,
                      trackVisibility: true,
                      notificationPredicate: (notif) => notif.depth == 1,
                      child: SingleChildScrollView(
                        controller: _vertical0,
                        child: SingleChildScrollView(
                          controller: _horizontal0,
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 100,
                            dataRowHeight: rowSpacing,
                            border: const TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                              verticalInside: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            dataRowColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context).colorScheme.primary;
                                }
                                return null; // Use default value.
                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            columns: <DataColumn>[
                              for (var day in daysOfTheWeek)
                                DataColumn(
                                  label: Container(
                                    height: 50,
                                    width: 50,
                                    margin: const EdgeInsets.all(8),
                                    child: Center(child: Text(day)),
                                  ),
                                ),
                            ],
                            rows: [
                              for (var color in Colors.primaries)
                                for (var shade in shades)
                                  DataRow(
                                    cells: [
                                      DataCell(Text('$shade')),
                                      DataCell(
                                        Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: color[shade]
                                                  ?.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                      ),
                                      DataCell(Container(
                                        height: 50,
                                        width: 50,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                color[shade]?.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      )),
                                      DataCell(Container(
                                        height: 50,
                                        width: 50,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                color[shade]?.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      )),
                                      DataCell(Container(
                                        height: 50,
                                        width: 50,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                color[shade]?.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      )),
                                      DataCell(Container(
                                        height: 50,
                                        width: 50,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                color[shade]?.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      )),
                                      DataCell(Container(
                                        height: 50,
                                        width: 50,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                color[shade]?.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      )),
                                    ],
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: Text('Add Column')),
                TextButton(onPressed: () {}, child: Text('Delete Row')),
                TextButton(onPressed: () {}, child: Text('Delete Column')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
