import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_service/registration_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class RegisterPage extends StatefulWidget {
   const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedValue = 'Lagos';

  String? locationValue;
  TextEditingController? nameController;
  TextEditingController? middleNameController;
  TextEditingController? genderController;
  TextEditingController? phoneController;
  TextEditingController? dobController;
  TextEditingController? userNameController;
  TextEditingController? homeAddressController;
  TextEditingController? stateController;
  TextEditingController? lgaController;
  TextEditingController? emailController;
  TextEditingController? referral;

  var isChecked = false;

  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();
    userNameController = TextEditingController();
    homeAddressController = TextEditingController();
    stateController = TextEditingController();
    middleNameController = TextEditingController();
    lgaController = TextEditingController();
    emailController = TextEditingController();
    referral = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themes().whiteColor,
      appBar: AppBars().backButton(context),
      body: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Getting Started',
                  style:
                      TextStyles().blackTextStyle700().copyWith(fontSize: 24)),
               const SizedBox(
                height: 15,
              ),
              Text(
                'Create an account to continue',
                style: TextStyles().greyTextStyle400(),
              ),
               const SizedBox(
                height: 40,
              ),
              OutlineInput(
                preffixWidget:  Icon(MdiIcons.account),
                labelText: 'Full name',
                controller: nameController,
              ),
               const SizedBox(
                height: 20,
              ),
              OutlineInput(
                preffixWidget:  Icon(MdiIcons.account),
                labelText: 'Middle name',
                controller: middleNameController,
              ),
               const SizedBox(
                height: 20,
              ),
              OutlineInput(
                preffixWidget:  Icon(MdiIcons.phone),
                labelText: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.number,
              ),
                const SizedBox(
                height: 20,
              ),
              OutlineInput(
                preffixWidget:  Icon(MdiIcons.account),
                labelText: 'Referred by ',
                controller: referral,
              ),
               const SizedBox(
                height: 20,
              ),
              OutlineInput(
                preffixWidget:  Icon(MdiIcons.calendar),
                labelText: 'Date of birth',
                controller: dobController,
                onTap: () {
                  setState(() async {
                    dateTime = await tools.selectDate(context);
                    final DateFormat formatter = DateFormat('dd-MM-yyyy');
                    dobController!.text =
                        formatter.format(DateTime.parse(dateTime.toString()));
                  });

                  //Navigator.pop(context);
                },
              ),
               const SizedBox(
                height: 20,
              ),
              OutlineInput(
                preffixWidget:  Icon(
                  MdiIcons.account,
                ),
                labelText: 'Username',
                controller: userNameController,
              ),
               const SizedBox(
                height: 20,
              ),
              OutlineInput(
                preffixWidget:  Icon(
                  MdiIcons.home,
                ),
                labelText: 'home address',
                controller: homeAddressController,
              ),
               const SizedBox(
                height: 20,
              ),

              DropdownSearch<String>(
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    stateController!.text = value!;
                  });
                },
                onSaved: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                selectedItem: selectedValue,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Field must not be empty';
                  } else {
                    return null;
                  }
                },
                items: NigerianStatesAndLGA.allStates,
                dropdownButtonProps: DropdownButtonProps(
                  icon: Icon(
                    MdiIcons.chevronDown,
                    color: themes().primaryColor,
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration:
                        OtherWidget().resubleInputDecoration('state')),
                popupProps: PopupProps.menu(
                    fit: FlexFit.loose,
                    menuProps:  const MenuProps(
                      backgroundColor: Color(0xffFAFAFA),
                      elevation: 4,
                    ),
                    //showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                            hintText: 'Select a state...',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                   const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 0, color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                   const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 0, color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                   const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 0, color: Colors.grey.shade300),
                            ),
                            hintStyle: TextStyles().blackTextStyle400()))),
              ),

               const SizedBox(
                height: 20,
              ),

              //select local government

              DropdownSearch<String>(
                onChanged: (value) {
                  setState(() {
                    locationValue = value;
                    lgaController!.text = value!;
                  });
                },
                onSaved: (newValue) {
                  setState(() {
                    locationValue = newValue;
                  });
                },
                selectedItem: locationValue,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Field must not be empty';
                  } else {
                    return null;
                  }
                },
                items: NigerianStatesAndLGA.getStateLGAs(selectedValue.toString()),
                dropdownButtonProps: DropdownButtonProps(
                  icon: Icon(
                    MdiIcons.chevronDown,
                    color: themes().primaryColor,
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: OtherWidget()
                        .resubleInputDecoration('local Government')),
                popupProps: PopupProps.menu(
                    fit: FlexFit.loose,
                    menuProps:  const MenuProps(
                      backgroundColor: Color(0xffFAFAFA),
                      elevation: 4,
                    ),
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                            hintText: 'Select a state...',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                   const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 0, color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                   const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 0, color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                   const BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 0, color: Colors.grey.shade300),
                            ),
                            hintStyle: TextStyles().blackTextStyle400()))),
              ),

               const SizedBox(
                height: 20,
              ),

              OutlineInput(
                labelText: 'Email Address',
                preffixWidget:  Icon(MdiIcons.email),
                controller: emailController,
              ),

               const SizedBox(
                height: 40,
              ),

              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: themes().primaryColor,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                   const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'By creating an account, you aggree to our Terms and Conditions',
                    style:
                        TextStyles().purpleTextStyle().copyWith(fontSize: 13),
                  )),
                ],
              ),

               const SizedBox(
                height: 40,
              ),

              MyButton(
                text: 'Register',
                onPressed: () {
                  var body = {
                    'name': nameController!.text,
                    'middlename': '',
                    'birthdate': dobController!.text,
                    'phone': phoneController!.text,
                    'email': emailController!.text,
                    'username': userNameController!.text,
                    'address': homeAddressController!.text,
                    'lga': lgaController!.text,
                    'state': stateController!.text,
                    'device_id': 'mobile',
                    'referral': referral!.text
                  };

                  RegistrationSerice().registerUser(context, body);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
