import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}
class _AddPageState extends State<AddPage> {
  String _scanResult = 'No barcode scanned';
  bool _isBarcodeScanned = false;
  final TextEditingController _nameController = TextEditingController();

  String? _selectedCategory;

  final List<String> _categories = ['Category 1', 'Category 2', 'Category 3'];

  void _onBarcodeScanned(String barcode) {
    setState(() {
      _scanResult = barcode;
      _isBarcodeScanned = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Veuillez scanner le barcode:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Barcode scanning camera feed
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: MobileScanner(
                    onDetect: (BarcodeCapture barcodeCapture) {
                      final List<Barcode> barcodes = barcodeCapture.barcodes;
                      for (final barcode in barcodes) {
                        if (barcode.rawValue != null) {
                          _onBarcodeScanned(barcode.rawValue!); // Barcode detected
                        }
                      }
                    },
                  ),
                ),
                if (_isBarcodeScanned)
                  const Positioned(
                    child: Icon(Icons.check_circle, color: Colors.green, size: 60),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'Barcode: $_scanResult',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Entrez le nom:',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown for category selection
            DropdownButtonFormField<String?>(
              value: _selectedCategory,
              items: _categories
                  .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Sélectionnez la catégorie:',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
              hint: const Text('Veuillez sélectionner la catégorie',style:TextStyle(color: Colors.blueAccent)),
            ),
            const SizedBox(height: 20),

            // Add button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_isBarcodeScanned && _nameController.text.isNotEmpty && _selectedCategory != null) {
                    // Handle the adding logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Barcode: $_scanResult\nNom: ${_nameController.text}\nCatégorie: ${_selectedCategory!}'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez scanner un code-barres et entrer un nom.'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
