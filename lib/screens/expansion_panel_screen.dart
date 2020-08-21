import 'package:flutter/material.dart';

class ExpansionpanelScreen extends StatefulWidget {
  @override
  _ExpansionpanelScreenState createState() => _ExpansionpanelScreenState();
}

class Item {
  bool isExpanded;
  Widget headerValue;
  Widget expandedValue;

  Item({this.isExpanded = false, this.headerValue, this.expandedValue});
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Expanded(
                child: Icon(Icons.cloud),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Day $index',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Expanded(
                child: Text(
                  '23',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Expanded(
                child: Text(
                  '24',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
      expandedValue: Column(
        children: [
          Row(
            children: [Text('Precipitation'), Text('Wind')],
          ),
          Row(
            children: [Text('Humidity'), Text('Pressure')],
          )
        ],
      ),
    );
  });
}

class _ExpansionpanelScreenState extends State<ExpansionpanelScreen> {
  List<Item> _data = generateItems(10);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    ListView(children: [
      ExpansionPanelList(
        animationDuration: Duration(milliseconds: 500),
        dividerColor: Color(0xFFc41a43),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: item.headerValue,
              );
            },
            body: ListTile(
              focusColor: Colors.blueAccent,
              title: item.expandedValue,
            ),
            isExpanded: item.isExpanded,
            canTapOnHeader: true,
          );
        }).toList(),
      ),
    ]);
  }
}
