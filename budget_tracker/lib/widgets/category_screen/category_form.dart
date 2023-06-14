import 'package:flutter/material.dart';
import '../../models/category_model.dart';

class CategoryForm extends StatefulWidget {
  final CategoryModel? category;
  final IconData? icon;
  final void Function(CategoryModel) onSave;
  final VoidCallback onCancel;

  const CategoryForm({
    Key? key,
    this.category,
    this.icon,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  IconData? _selectedIcon;
  bool _nameError = false;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.category?.categoryName ?? '');
    _descriptionController =
        TextEditingController(text: widget.category?.categoryDescription ?? '');
    _selectedIcon = widget.icon ?? Icons.category; // Define o ícone padrão
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nome',
              errorText:
                  _nameError ? 'Informe um nome! Campo obrigatório.' : null,
            ),
            controller: _nameController,
            onChanged: (_) {
              setState(() {
                _nameError = false;
              });
            },
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: const InputDecoration(labelText: 'Descrição'),
            controller: _descriptionController,
          ),
          const SizedBox(height: 16.0),
          Column(
            children: [
              Text(
                'Ícone',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).textTheme.subtitle1?.color,
                ),
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                  _showIconSelectionDialog();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    _selectedIcon!,
                    size: 32,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Clique para selecionar',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: widget.onCancel,
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {
                  final name = _nameController.text;
                  final description = _descriptionController.text;
                  final icon = _selectedIcon!.codePoint;

                  if (name.isEmpty) {
                    setState(() {
                      _nameError = true;
                    });
                  } else {
                    widget.onSave(CategoryModel(
                      categoryName: name,
                      categoryDescription: description,
                      icon: icon,
                    ));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showIconSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: IconsDataList.iconDataList.length,
              itemBuilder: (context, index) {
                final iconData = IconsDataList.iconDataList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = iconData;
                    });
                    Navigator.pop(context);
                  },
                  child: Icon(
                    iconData,
                    size: 40,
                    color:
                        _selectedIcon == iconData ? Colors.blue : Colors.black,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class IconsDataList {
  static List<IconData> iconDataList = [
    Icons.category,
    Icons.home,
    Icons.work,
    Icons.school,
    Icons.data_usage,
    Icons.desktop_mac,
    Icons.directions_car,
    Icons.directions_transit,
    Icons.directions_walk,
    Icons.drafts,
    Icons.email,
    Icons.error,
    Icons.event,
    Icons.favorite,
    Icons.flight,
    Icons.gavel,
    Icons.headset,
    Icons.help,
    Icons.home,
    Icons.info,
    Icons.landscape,
    Icons.language,
    Icons.lock,
    Icons.mail,
    Icons.money,
    Icons.music_note,
    Icons.navigation,
    Icons.notifications,
    Icons.palette,
    Icons.pets,
    Icons.phone,
    Icons.photo,
    Icons.public,
    Icons.radio,
    Icons.search,
    Icons.shopping_cart,
    Icons.star,
    Icons.thumb_up,
    Icons.train,
    Icons.verified_user,
    Icons.video_call,
    Icons.wifi,
  ];
}
