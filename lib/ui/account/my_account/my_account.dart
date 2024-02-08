import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyAccountWidget extends StatefulWidget {
  const MyAccountWidget({super.key});

  @override
  State<MyAccountWidget> createState() => _MyAccountWidgetState();
}

class _MyAccountWidgetState extends State<MyAccountWidget> {
  Map<String, dynamic>? userData;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? genderNameController;
  TextEditingController? countryController;
  TextEditingController? cityController;
  TextEditingController? numberController;
  TextEditingController? emailController;
  TextEditingController? addressController;
  TextEditingController? lgaController;
  TextEditingController? userName;

  bool isLoading = true;

  String? selectedValue = 'Lagos';

  String? locationValue;

  @override
  void initState() {
    userData = Provider.of<AccountState>(context, listen: false).userDetails;
    // ignore: avoid_print
    print(userData);
    super.initState();
    getUserDetail();
    // ignore: avoid_print
    print(userData);
    firstNameController = TextEditingController(text: userData?['firstname']);
    lastNameController = TextEditingController(text: userData?['lastname']);
    genderNameController = TextEditingController(text: userData?['sex']);
    // ignore: avoid_print
    print(genderNameController?.text);
    countryController = TextEditingController(text: 'Nigeria');
    cityController = TextEditingController(text: userData?['address']['state']);
    numberController = TextEditingController(text: userData?['phone']);
    lgaController = TextEditingController(text: userData?['address']['lga']);
    emailController = TextEditingController(text: userData?['email']);
    addressController =
        TextEditingController(text: userData?['address']['address']);

    userName = TextEditingController(text: userData?['username']);
  }

  Future<void> getUserDetail() async {
    isLoading = true;
    userData = Provider.of<AccountState>(context, listen: false).userDetails;
    setState(() {
      isLoading = false;
    });
  }

  List<String> genderList = ['male', 'female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton('My Account', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: themes().primaryColor,
                          radius: 40,
                          backgroundImage: NetworkImage(userData!['image'] ??
                              ''), // Replace with your image URL
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: themes().primaryColor,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 11,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'personal information',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    OutlineInput(
                      labelText: 'first name',
                      controller: firstNameController,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    OutlineInput(
                      labelText: 'last name',
                      controller: lastNameController,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 19,
                    ),

                    //select gender
                    OutlineInput(
                      labelText: 'Gender',
                      controller: genderNameController,
                      readOnly: true,
                    ),

                    // DropdownSearch<String>(
                    //   onChanged: (value) {
                    //     setState(() {
                    //       // locationValue = value;
                    //       genderNameController?.text = value!;
                    //     });
                    //   },
                    //   onSaved: (newValue) {
                    //     setState(() {
                    //       genderNameController?.text = newValue!;
                    //     });
                    //   },
                    //   selectedItem: genderNameController?.text,
                    //   validator: (String? value) {
                    //     if (value!.isEmpty) {
                    //       return 'Field must not be empty';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   items: genderList,
                    //   dropdownButtonProps: DropdownButtonProps(
                    //     icon: Icon(
                    //       MdiIcons.chevronDown,
                    //       color: themes().primaryColor,
                    //     ),
                    //   ),
                    //   dropdownDecoratorProps: DropDownDecoratorProps(
                    //       dropdownSearchDecoration:
                    //           OtherWidget().resubleInputDecoration('Gender')),
                    //   popupProps: PopupProps.menu(
                    //       fit: FlexFit.loose,
                    //       menuProps: const MenuProps(
                    //         backgroundColor: Color(0xffFAFAFA),
                    //         elevation: 4,
                    //       ),
                    //       showSearchBox: true,
                    //       searchFieldProps: TextFieldProps(
                    //           decoration: InputDecoration(
                    //               hintText: 'Gender',
                    //               fillColor: Colors.white,
                    //               filled: true,
                    //               border: OutlineInputBorder(
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(4)),
                    //                 borderSide: BorderSide(
                    //                     width: 0, color: Colors.grey.shade300),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(4)),
                    //                 borderSide: BorderSide(
                    //                     width: 0, color: Colors.grey.shade300),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(4)),
                    //                 borderSide: BorderSide(
                    //                     width: 0, color: Colors.grey.shade300),
                    //               ),
                    //               hintStyle:
                    //                   TextStyles().blackTextStyle400()))),
                    // ),
                    const SizedBox(
                      height: 19,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Address  information',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    OutlineInput(
                      labelText: 'Address',
                      readOnly: true,
                      controller: addressController,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    OutlineInput(
                      labelText: 'Country',
                      readOnly: true,
                      controller: countryController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    OutlineInput(
                      labelText: 'State',
                      readOnly: true,
                      controller: cityController,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //select local government

                    // DropdownSearch<String>(
                    //   onChanged: (value) {
                    //     setState(() {

                    //       lgaController!.text = value!;
                    //     });
                    //   },
                    //   onSaved: (newValue) {
                    //     setState(() {
                    //       lgaController?.text = newValue!;
                    //     });
                    //   },
                    //   selectedItem: lgaController?.text,
                    //   validator: (String? value) {
                    //     if (value!.isEmpty) {
                    //       return 'Field must not be empty';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   items: NigerianStatesAndLGA.getStateLGAs(
                    //       selectedValue.toString()),
                    //   dropdownButtonProps: DropdownButtonProps(
                    //     icon: Icon(
                    //       MdiIcons.chevronDown,
                    //       color: themes().primaryColor,
                    //     ),
                    //   ),
                    //   dropdownDecoratorProps: DropDownDecoratorProps(
                    //       dropdownSearchDecoration: OtherWidget()
                    //           .resubleInputDecoration('local Government')),
                    //   popupProps: PopupProps.menu(
                    //       fit: FlexFit.loose,
                    //       menuProps: const MenuProps(
                    //         backgroundColor: Color(0xffFAFAFA),
                    //         elevation: 4,
                    //       ),
                    //       showSearchBox: true,
                    //       searchFieldProps: TextFieldProps(
                    //           decoration: InputDecoration(
                    //               hintText: 'Select a state...',
                    //               fillColor: Colors.white,
                    //               filled: true,
                    //               border: OutlineInputBorder(
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(4)),
                    //                 borderSide: BorderSide(
                    //                     width: 0, color: Colors.grey.shade300),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(4)),
                    //                 borderSide: BorderSide(
                    //                     width: 0, color: Colors.grey.shade300),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(4)),
                    //                 borderSide: BorderSide(
                    //                     width: 0, color: Colors.grey.shade300),
                    //               ),
                    //               hintStyle:
                    //                   TextStyles().blackTextStyle400()))),
                    // ),

                    OutlineInput(
                      labelText: 'lga',
                      controller: lgaController,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'contact information',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    OutlineInput(
                      labelText: 'Number',
                      controller: numberController,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    OutlineInput(
                      labelText: 'Usernmae',
                      controller: userName,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    OutlineInput(
                      labelText: 'Email',
                      controller: emailController,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // MyButton(
                    //   text: 'Save Changes',
                    //   onPressed: () {
                    //     var data = {
                    //       'image':
                    //           'https://image/storage/36255688/v/l/6-900901636933-1',
                    //       'firstname': firstNameController?.text,
                    //       'lastname': lastNameController?.text,
                    //       'middlename': 'Blick',
                    //       'sex': genderNameController?.text,
                    //       // Address details
                    //       'country': countryController?.text,
                    //       'state': selectedValue,
                    //       'lga': lgaController?.text,
                    //       'address': addressController?.text,
                    //       // contact info
                    //       'phone': numberController?.text,
                    //       'username': userName?.text,
                    //       'email': emailController?.text
                    //     };

                    //     AccountSerice().updateProfile(context, data);
                    //   },
                    // )
                  ],
                ),
        ),
      ),
    );
  }

  Container accountTierWidget(String text) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(33, 255, 188, 31),
      ),
      child: Text(
        text,
        style: TextStyles()
            .blackTextStyle400()
            .copyWith(color: const Color(0xfff6a609), fontSize: 12),
      ),
    );
  }

  DropdownSearch<String> gender(
      TextEditingController controller, String textStyle, List<String> list) {
    return DropdownSearch<String>(
      onChanged: (value) {
        setState(() {
          selectedValue = value;
          cityController!.text = value!;
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
      items: list,
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
          menuProps: const MenuProps(
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
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    borderSide:
                        BorderSide(width: 0, color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    borderSide:
                        BorderSide(width: 0, color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    borderSide:
                        BorderSide(width: 0, color: Colors.grey.shade300),
                  ),
                  hintStyle: TextStyles().blackTextStyle400()))),
    );
  }
}
