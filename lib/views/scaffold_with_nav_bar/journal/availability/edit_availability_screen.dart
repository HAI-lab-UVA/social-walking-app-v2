import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:social_walking_2/models/classes/sw_availability_slot.dart';
import 'package:social_walking_2/models/classes/sw_time.dart';
import 'package:social_walking_2/models/classes/sw_time_range.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';

class EditAvailabilityScreen extends ConsumerStatefulWidget {
  const EditAvailabilityScreen({super.key});

  @override
  ConsumerState<EditAvailabilityScreen> createState() =>
      _EditAvailabilityScreenState();
}

class _EditAvailabilityScreenState
    extends ConsumerState<EditAvailabilityScreen> {
  List<SWAvailabilitySlot> availabilitySlots = [];
  bool isLoading = true;
  bool changesMade = false;

  Future<void> loadAvailabilitySlots() async {
    final currentUser = await ref
        .read(userRepositoryProvider)
        .getCurrentUser()
        .first;
    if (mounted) {
      setState(() {
        availabilitySlots = currentUser.availability;
        isLoading = false;
        changesMade = false;
      });
    }
  }

  Future<void> saveAvailabilitySlots() async {
    final uid = ref.read(authRepositoryProvider).getCurrentUserId();
    await ref
        .read(userRepositoryProvider)
        .updateUserInfo(
          uid: uid,
          key: "availability",
          value: availabilitySlots.map((e) => e.toJson()).toList(),
        );

    setState(() {
      changesMade = false;
    });
  }

  @override
  void initState() {
    loadAvailabilitySlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Weekly Availability",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: SWColor.black),
          ),
          backgroundColor: SWColor.white,
          scrolledUnderElevation: 0.0,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      canPop: !changesMade,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        confirmDialog(
          context: context,
          title: "Save Changes?",
          callback: () async {
            await saveAvailabilitySlots();
            if (context.mounted) {
              context.pop();
            }
          },
          noCallback: () => context.pop(),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weekly Availability",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: SWColor.black),
          ),
          backgroundColor: SWColor.white,
          scrolledUnderElevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: SWColor.grayLight,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            saveAvailabilitySlots();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: const Text('Changes Saved')),
                            );
                          },
                          icon: Icon(Symbols.save, weight: 600.0, size: 28.0),
                        ),
                        IconButton(
                          onPressed: () {
                            confirmDialog(
                              context: context,
                              title: "Clear all availability?",
                              callback: () {
                                setState(() {
                                  availabilitySlots =
                                      SWTimeRange(
                                            start: SWTime(hour: 7, minute: 0),
                                            stop: SWTime(hour: 6, minute: 45),
                                            interval: 15,
                                          )
                                          .getTimes()
                                          .map(
                                            (e) => SWAvailabilitySlot(time: e),
                                          )
                                          .toList();
                                  changesMade = true;
                                });
                              },
                            );
                          },
                          icon: Icon(
                            Symbols.ink_eraser,
                            weight: 600.0,
                            size: 28.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Symbols.calendar_add_on,
                            weight: 600.0,
                            size: 28.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    // Day of Week names
                    flex: 3,
                    child: Row(
                      children: [
                        for (var day in [
                          "MO",
                          "TU",
                          "WE",
                          "TH",
                          "FR",
                          "SA",
                          "SU",
                        ])
                          Expanded(
                            child: Text(
                              day,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(color: SWColor.black),
                              textAlign: TextAlign
                                  .center, // Center text over the boxes
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      // Time slot names
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (var slot in availabilitySlots)
                                (slot.time.minute % 30 == 0)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: Text(
                                          slot.time.to12HourString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: SWColor.black,
                                                fontSize: 13.0,
                                              ),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    : const SizedBox(height: 28),
                            ],
                          ),
                        ),
                        Expanded(
                          // Time slots
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10),
                              for (var slot in availabilitySlots)
                                Row(
                                  children: [
                                    for (var i = 0; i < 7; i++)
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              slot.availability[i] =
                                                  !slot.availability[i]!;
                                              changesMade = true;
                                            });
                                          },
                                          child: Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: slot.availability[i]!
                                                  ? SWColor.green
                                                  : SWColor.grayLight,
                                              border: Border.all(
                                                color: SWColor.gray,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
