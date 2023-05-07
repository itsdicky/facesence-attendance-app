import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sistem_presensi/feature/presentation/styles/color_style.dart';
import 'package:sistem_presensi/feature/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/feature/presentation/widget/appbar_widget.dart';

class PermissionForm extends StatefulWidget {

  const PermissionForm({super.key});

  @override
  State<PermissionForm> createState() => _PermissionFormState();
}

class _PermissionFormState extends State<PermissionForm> {
  final List<String> itemsCategory = [
    'Izin',
    'Sakit',
    'Kegiatan sekolah',
    'Lain-lain',
  ];
  String? selectedValue;

  final TextEditingController _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBar(title: 'Permohonan Izin',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 32,),
              Image.asset(
                'assets/images/permission-form-image.png',
                height: 114,
              ),
              const SizedBox(height: 48,),
              Center(
                child: Text(
                  'Apa alasan anda?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 64,),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text('Pilih alasan', style: Theme.of(context).textTheme.bodyMedium,),
                  items: _addDividersAfterItems(itemsCategory),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  iconStyleData: const IconStyleData(
                      icon: Icon(Icons.keyboard_arrow_down)
                  ),
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.fromLTRB(8, 4, 24, 4),
                    decoration: BoxDecoration(
                      color: ColorStyle.lightGrey,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Theme.of(context).primaryColorLight, width: 1),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    elevation: 4,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    customHeights: _getCustomItemsHeights(itemsCategory),
                  ),
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 16,),
              TextField(
                controller: _detailController,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: WidgetStyle.textfieldDecoration(hintText: 'Deskripsi'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 36,),
              TextButton(
                style: WidgetStyle.textButtonStyle(),
                onPressed: () {},
                child: Text('Lanjut', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void dropDownCallBack(String? selectedValue) {
  //   if (selectedValue is String) {
  //     setState(() {
  //       _dropdownValue = selectedValue;
  //     });
  //   }
  // }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(item, style: Theme.of(context).textTheme.bodyMedium,),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights(List<String> items) {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
  }
}