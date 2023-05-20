import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/src/presentation/widget/common/appbar_widget.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';

import '../../../../constant/app_config.dart';

class PermissionForm extends StatefulWidget {
  final List<String> itemsCategory = AppConfig.permissionCategory;

  const PermissionForm({super.key});

  @override
  State<PermissionForm> createState() => _PermissionFormState();
}

class _PermissionFormState extends State<PermissionForm> {
  String? selectedValue;

  final GlobalKey<FormState> _formPermissionKey = GlobalKey<FormState>();
  final TextEditingController _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CTitleAppBarLight(title: 'Permohonan Izin',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formPermissionKey,
          child: Center(
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: ListView(
                children: [
                  const SizedBox(height: 42,),
                  Image.asset(
                    'assets/images/permission-form-image.png',
                    height: 114,
                  ),
                  const SizedBox(height: 72,),
                  Center(
                    child: Text(
                      'Mengapa mengajukan izin?',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 24,),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                      items: _addDividersAfterItems(widget.itemsCategory),
                      decoration: CWidgetStyle.dropdownButtonDecoration(),
                      isExpanded: true,
                      hint: Text('Pilih alasan', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorStyle.darkGrey),),
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih alasan';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
                        });
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(8, 4, 20, 4),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down),
                        openMenuIcon: Icon(Icons.keyboard_arrow_up),
                        iconEnabledColor: ColorStyle.indigoLight,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        elevation: 4,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        customHeights: _getCustomItemsHeights(widget.itemsCategory),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _detailController,
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan deskripsi';
                      }
                      return null;
                    },
                    decoration: CWidgetStyle.textfieldDecoration(hintText: 'Deskripsi'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 36,),
                  TextButton(
                    style: CWidgetStyle.textButtonStyle(),
                    onPressed: _submitPermissionDetail,
                    child: Text('Lanjut', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitPermissionDetail() {
    if (_formPermissionKey.currentState!.validate()) {
      _formPermissionKey.currentState!.save();
      Navigator.pushNamed(context, PageConst.permissionCameraPage, arguments: [selectedValue!,_detailController.text]);
    }
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: EdgeInsets.zero,
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
        _itemsHeights.add(46);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
  }
}