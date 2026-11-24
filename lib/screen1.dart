import 'package:material_ui/material_ui.dart';
//lab part b
// created a class called car with its respective properties 
//and created a stateful widget called screen1 to display 
//the data in a data table with sorting functionality.

class Car {
  final String make;
  final int model;
  final double price;

  Car({required this.make, required this.model, required this.price});
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  int? sortColumnIndex;
  bool sortAscending = true;

  List<Car> cars = [
    Car(make: 'Toyota', model: 2020, price: 28000),
    Car(make: 'Honda', model: 2019, price: 24500),
    Car(make: 'Ford', model: 2021, price: 32000),
  ];

  void sortBy(int columnIndex, bool ascending, int Function(Car a, Car b) compare) {
    setState(() {
      cars.sort((a, b) => ascending ? compare(a, b) : compare(b, a));
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Cars')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: DataTable(
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          border: TableBorder.all(color: Colors.black),
          headingRowColor: WidgetStateProperty.all<Color>(Colors.grey),
          columns: [
            DataColumn(
              label: const Text('Car Make'),
              onSort: (i, asc) => sortBy(i, asc, (a, b) => a.make.compareTo(b.make)),
            ),
            DataColumn(
              label: const Text('Model'),
              onSort: (i, asc) => sortBy(i, asc, (a, b) => a.model.compareTo(b.model)),
            ),
            DataColumn(
              label: const Text('Price'),
              numeric: true,
              onSort: (i, asc) => sortBy(i, asc, (a, b) => a.price.compareTo(b.price)),
            ),
          ],
          rows: cars.map((car) {
            return DataRow(
              cells: [
                DataCell(Text(car.make)),
                DataCell(Text(car.model.toString())),
                DataCell(Text('\$${car.price.toStringAsFixed(0)}')),
              ],
            );
          }).toList(),
        ),
        )
      ),
    );
  }
}