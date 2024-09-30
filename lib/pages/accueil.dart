import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  @override
  String selectedCategory = 'Category 1';  // Default selected item
  String selectedArea = 'Area 3';          // Default selected area
  int touchedIndex = -1;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategorySection(),
              SizedBox(height: 20),
              _buildDonutChartSection(),
              SizedBox(height: 20),
              _buildMaterialSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Categories Section
  Widget _buildCategorySection() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildCategoryCard('Category 1', '50%'),
        _buildCategoryCard('Category 2', '34%'),
        _buildCategoryCard('Category 3', '10%'),
        _buildCategoryCard('Category 4', '6%'),
      ],
    );
  }

  Widget _buildCategoryCard(String title, String percentage) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Spacer(),
            Text(percentage, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            // Placeholder for a graph line
            Container(
              height: 70,

              child: Image.asset("images/chart.jpeg"),
            ),
          ],
        ),

      ),
    );
  }

  // Widget for Donut Chart Section
  Widget _buildDonutChartSection() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: Container(
              height: 180,
              width: 180,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      }
                    },
                  ),
                  sectionsSpace: 0,  // No space between the sections
                  centerSpaceRadius: 40,  // Creates the donut effect
                  sections: _buildPieChartSections(),  // Pie chart sections
                ),
                swapAnimationDuration: Duration(milliseconds: 800),  // Enables chart animation
                swapAnimationCurve: Curves.easeOutExpo,  // Smooth animation curve
              ),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildChartLegend('Option A', Colors.blue, '6%'),
              _buildChartLegend('Option B', Colors.orange, '10%'),
              _buildChartLegend('Option C', Colors.yellow, '34%'),
              _buildChartLegend('Option D', Colors.red, '50%'),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25.0 : 16.0;
      final double radius = isTouched ? 60.0 : 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 6,
            title: '6%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 34,
            title: '34%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red,
            value: 50,
            title: '50%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildChartLegend(String label, Color color, String percentage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        SizedBox(width: 4),
        Text('$label $percentage'),
      ],
    );
  }
  Widget _buildMaterialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDropdownButton(
                'Category 1',
                ['Category 1', 'Category 2', 'Category 3'],
                    (newValue) {
                  selectedCategory = newValue!;
                }
            ),
            _buildDropdownButton(
                'Area 3',
                ['Area 1', 'Area 2', 'Area 3'],
                    (newValue) {
                  selectedArea = newValue!;
                }
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildMaterialCard('Material 1', 'Category', 'Area'),
        _buildMaterialCard('Material 2', 'Category', 'Area'),
        _buildMaterialCard('Material 3', 'Category', 'Area'),
      ],
    );
  }

  Widget _buildDropdownButton(String selectedItem, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedItem,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildMaterialCard(String materialName, String category, String area) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.settings, color: Colors.red, size: 30),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(materialName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('$category | $area', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}