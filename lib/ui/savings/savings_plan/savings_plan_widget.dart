import 'package:airruppies/ui/savings/model/savings_plan_model.dart';
import 'package:airruppies/ui/savings/savings_state/savings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AirFixedFeatureWidget extends StatefulWidget {
 const  AirFixedFeatureWidget({
    super.key,
    this.data
  });
  final SavingsPlanModel ?data;

  @override
  State<AirFixedFeatureWidget> createState() => _AirFixedFeatureWidgetState();
}

class _AirFixedFeatureWidgetState extends State<AirFixedFeatureWidget> {
  List<String> featureList = [
    'Fund Locked until the end of the plan',
    'Save from N 10,000 to 1 billion',
    'Save from N 10,000 to 1 billion',
  ];

  List<SavingsPlanModel>? savingPlan;

  @override
  void initState() {
    super.initState();
  }

  void getSavingsPlan() {
    savingPlan = Provider.of<SavingsState>(context, listen: false).savingPlan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Feature',
                style: Theme.of(context).textTheme.displaySmall!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                          color: Color(0xff9310D4), shape: BoxShape.circle),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.data!.features[index],
                      style:
                         Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 28,
                );
              },
              itemCount: widget.data!.features.length)
        ],
      ),
    );
  }
}
