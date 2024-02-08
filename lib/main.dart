import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';

import 'package:airruppies/ui/bill_payment/bill_payment_state/bill_payment_state.dart';
import 'package:airruppies/ui/home/dashboard_state/dashboard_state.dart';

import 'package:airruppies/ui/more/more/more_state.dart';
import 'package:airruppies/ui/savings/savings_state/savings_state.dart';
import 'package:airruppies/ui/send_money/send_money_state/send_money_state.dart';
import 'package:airruppies/ui/splashscreen/splashscreen.dart';
import 'package:airruppies/ui/transactions/transactions_state/transaction_state.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;

import 'package:provider/provider.dart';

void main() async {
 

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoreState>(
            create: (BuildContext context) => MoreState()),
        ChangeNotifierProvider(create: (context) => AuthState()),
        ChangeNotifierProvider(create: (context) => AccountState()),
        ChangeNotifierProvider(create: (context) => BankState()),
        ChangeNotifierProvider(create: (context) => TransactionState()),
        ChangeNotifierProvider(create: (context) => SavingsState()),
        ChangeNotifierProvider(create: (context) => DashboardState()),
        ChangeNotifierProvider(create: (context) => BillPaymentState()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
         tools.oneSignal();

        return MaterialApp(
            title: 'Air Ruppies',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const SplashScreen());
      },
    );
  }
}
