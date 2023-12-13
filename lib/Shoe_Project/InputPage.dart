// ignore_for_file: library_private_types_in_public_api, unused_import, avoid_print, unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/Shoe_Project/Database.dart';
import 'package:new_app/Shoe_Project/DbHelper.dart';
import 'package:new_app/Shoe_Project/Details_Page.dart';
import 'package:new_app/Shoe_Project/Main_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _finalPriceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  

  File? _image;
  Map<String, dynamic> _getShoeDetails() {
    return {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'price': double.parse(_priceController.text),
      'discount': double.parse(_discountController.text),
      'finalPrice': double.parse(_finalPriceController.text),
      'imageUrl': _imageUrlController.text,
      'imageFile': _image,
    };
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _finalPriceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Discount'),
            ),
            TextField(
              controller: _finalPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Final Price'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text('Select Image'),
            ),
            _image != null
                ? Image.file(
                    _image!,
                    height: 50,
                  )
                : _imageUrlController.text.isNotEmpty
                    ? Image.network(
                        _imageUrlController.text,
                        height: 50,
                      )
                    : Container(),
            SizedBox(height: 10),
           ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  _saveShoe();
                  Navigator.pop(context, _getShoeDetails());
                }
              },
              child: Text('Add Card'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageUrlController.text = '';
      });
    }
  }

  bool _validateInputs() {
  
    return true;
  }

  Future<void> _saveShoe() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    double price = double.parse(_priceController.text);
    double discount = double.parse(_discountController.text);
    double finalPrice = double.parse(_finalPriceController.text);
    String imageUrl = _imageUrlController.text;

    if (_image != null) {
      imageUrl = await _saveImageToStorage(_image!);
    }

    Shoe newShoe = Shoe(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      description: description,
      price: price,
      discount: discount,
      finalPrice: finalPrice,
      imageUrl: imageUrl,
    );

    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.insertShoe(newShoe);
      databaseHelper.close();
      print('Shoe saved successfully!');
    } catch (e) {
      print('Error saving shoe: $e');
    }
  }

  Future<String> _saveImageToStorage(File imageFile) async {
   
   
    return 'path/to/your/image';
  }
}
