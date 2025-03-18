import 'package:flutter/material.dart';
import 'package:starzinfinite/core/cores.dart';
import '../../data/countries_data.dart';

class CountryDropdown extends StatefulWidget {
  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  String? selectedCountryCode;

  @override
  void initState() {
    super.initState();
    if (countryDialCodes.isNotEmpty) {
      selectedCountryCode = countryDialCodes[18]["dial_code"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      child: DropdownButtonFormField<String>(
        value: selectedCountryCode,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: blackBeePay,
        ),
        items: countryDialCodes.isNotEmpty
            ? countryDialCodes.map((country) {
                return DropdownMenuItem<String>(
                  value: country["dial_code"],
                  child: Text(
                    "${country["dial_code"]} | ${country["country"]}",
                    style: medium(blackBeePay, 15),
                  ),
                );
              }).toList()
            : [],
        onChanged: (newValue) {
          setState(() {
            selectedCountryCode = newValue;
            FileSystemManager.instance.prefijo = selectedCountryCode;
            print(selectedCountryCode);
          });
        },
        selectedItemBuilder: (BuildContext context) {
          return countryDialCodes.map((country) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                country["dial_code"] ?? "",
                style: medium(blackBeePay, 15),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
