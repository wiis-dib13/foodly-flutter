import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class PersonalRecipePage extends StatefulWidget {
  final String mealType;
  final DateTime date;

  const PersonalRecipePage({
    required this.mealType,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  _PersonalRecipePageState createState() => _PersonalRecipePageState();
}

class _PersonalRecipePageState extends State<PersonalRecipePage> {
  XFile? _image;
  Uint8List? _webImage;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  List<String> ingredientsList = [];
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = pickedFile;
      _webImage = await pickedFile.readAsBytes();
      setState(() {});
    }
  }

  void _submitRecipe() {
    if (_formKey.currentState!.validate() && ingredientsList.isNotEmpty) {
      Navigator.pop(context, {
        'mealType': widget.mealType,
        'date': widget.date,
        'name': _nameController.text,
        'image': _webImage,
      });
    }
  }

  void _addIngredient(String value) {
    if (value.trim().isNotEmpty && !ingredientsList.contains(value.trim())) {
      setState(() {
        ingredientsList.add(value.trim());
        _ingredientController.clear();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _stepsController.addListener(() {
      final text = _stepsController.text;
      if (text.endsWith('\n')) {
        final newText = text + '\u2022 ';
        _stepsController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sectionTitleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Segoe UI',
    );

    return Scaffold(
      appBar: AppBar(title: Text('Upload Personal Recipe')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: _webImage == null
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.image_outlined, size: 64, color: Colors.grey[300]),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 32, color: Colors.grey[700]),
                                SizedBox(height: 4),
                                Text('Add Image', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                              ],
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _webImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Recipe Name'),
                style: TextStyle(fontSize: 16),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              SizedBox(height: 20),
              Text('Description (optional)', style: sectionTitleStyle),
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text('Ingredients', style: sectionTitleStyle),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: ingredientsList
                    .map((ingredient) => Chip(
                          label: Text(ingredient),
                          deleteIcon: Icon(Icons.close),
                          onDeleted: () => setState(() => ingredientsList.remove(ingredient)),
                        ))
                    .toList(),
              ),
              TextField(
                controller: _ingredientController,
                decoration: InputDecoration(hintText: 'Type an ingredient and press enter'),
                onSubmitted: _addIngredient,
              ),
              SizedBox(height: 20),
              Text('Steps', style: sectionTitleStyle),
              TextFormField(
                controller: _stepsController,
                decoration: InputDecoration(
                  hintText: 'Each line will start with a bullet point',
                ),
                maxLines: 6,
                style: TextStyle(fontSize: 16),
                validator: (value) => value == null || value.isEmpty ? 'Steps are required' : null,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitRecipe,
                  icon: Icon(Icons.check),
                  label: Text('Add Recipe'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
