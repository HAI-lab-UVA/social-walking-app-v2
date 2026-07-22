import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:social_walking_2/models/classes/sw_user.dart';
import 'package:social_walking_2/models/enums/sw_gender.dart';
import 'package:social_walking_2/models/enums/sw_walk_preference.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/repositories/image_repository.dart';
import 'package:social_walking_2/repositories/user_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_walking_2/ui/user_profile_image.dart';

class OnboadingScreen extends ConsumerStatefulWidget {
  const OnboadingScreen({super.key});

  @override
  ConsumerState<OnboadingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends ConsumerState<OnboadingScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  late DateTime dateOfBirth;
  late String pronouns;
  late SWGender gender;
  late List<SWWalkPreference> walkPreferences;
  String? profileImageURL;

  final formKey = GlobalKey<FormState>();
  bool isProcessingOnboarding = false;

  void confirmFinished() {
    if (formKey.currentState!.validate()) {
      confirmDialog(
        context: context,
        title: "Are you done setting up your profile?",
        content: "You can edit your profile information at any time.",
        callback: createAccount,
      );
    }
  }

  void createAccount() async {
    if (!isProcessingOnboarding) {
      setState(() {
        isProcessingOnboarding = true;
      });
      if (formKey.currentState!.validate()) {
        final uid = ref.read(authRepositoryProvider).getCurrentUserId();
        final newUser = SWUser(
          created: DateTime.now(),
          id: uid,
          fcmToken: "placeholder",
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          dateOfBirth: dateOfBirth,
          gender: gender,
          biography: bioController.text,
          profileImageURL: profileImageURL,
        );
        ref.read(userRepositoryProvider).createUser(uid, newUser).then((_) {
          if (mounted) {
            context.go("/permission-request");
          }
        });
      } else {
        setState(() {
          isProcessingOnboarding = false;
        });
      }
    }
  }

  Future<void> selectImage() async {
    setState(() {
      isProcessingOnboarding = true;
    });
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    if (file != null) {
      if (mounted) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: SWColor.blue,
              toolbarWidgetColor: SWColor.white,
              cropStyle: CropStyle.circle,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
              ],
            ),
            IOSUiSettings(
              title: 'Cropper',
              cropStyle: CropStyle.circle,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
              ],
            ),
            WebUiSettings(context: context),
          ],
        );

        if (croppedFile != null) {
          final imageData = await croppedFile.readAsBytes();
          final mime = file.mimeType;
          final imageRepository = ref.watch(imageRepositoryProvider);
          profileImageURL = await imageRepository.uploadImage(
            imageData,
            mime: mime,
          );
          setState(() {
            isProcessingOnboarding = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listViewItems = [
      SizedBox(height: 30),
      multiColorSentence(
        text: ["Hello! ", "Welcome to the Social Walking Community"],
        colors: [SWColor.blue, SWColor.black],
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text(
        "Tell us about yourself!",
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: SWColor.black),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 30),
      Form(
        key: formKey,
        child: IntrinsicWidth(
          child: Column(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textInputField(
                hintText: "FIRST NAME",
                controller: firstNameController,
                context: context,
                maxLength: 25,
                maxLines: 1,
                minLines: 1,
                showCounterText: false,
                validator: (value) {
                  if (value == null || value.replaceAll(" ", "") == "") {
                    return "First name cannot be blank.";
                  }
                  return null;
                },
              ),
              textInputField(
                hintText: "LAST NAME",
                controller: lastNameController,
                context: context,
                maxLength: 25,
                maxLines: 1,
                minLines: 1,
                showCounterText: false,
                validator: (value) {
                  if (value == null || value.replaceAll(" ", "") == "") {
                    return "Last name cannot be blank.";
                  }
                  return null;
                },
              ),
              dropdownMenu(
                hintText: "GENDER",
                data: SWGenderExtension.formattedNames(),
                context: context,
                onChanged: (v) {
                  setState(() {
                    if (v != null) {
                      gender = SWGenderExtension.fromFormattedName(v)!;
                    }
                  });
                },
                validator: (value) {
                  if (value == null || value == "") {
                    return "Gender cannot be blank.";
                  }
                  return null;
                },
              ),
              tappableReadOnlyInputField(
                hintText: "DATE OF BIRTH",
                controller: dateOfBirthController,
                context: context,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Date of birth cannot be blank.";
                  }
                  return null;
                },
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      Duration(days: 365 * 100),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    if (mounted) {
                      setState(() {
                        dateOfBirth = pickedDate;
                        dateOfBirthController.text = DateFormat(
                          'MM-dd-yyyy',
                        ).format(pickedDate);
                      });
                    }
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "YOUR BIO",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: SWColor.black),
                  textAlign: TextAlign.center,
                ),
              ),
              textInputField(
                hintText:
                    "Tell others about yourself. What are your interests?",
                controller: bioController,
                context: context,
                maxLength: 400,
                maxLines: 5,
                minLines: 5,
                showCounterText: true,
                validator: null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "CHOOSE YOUR WALKING PREFERENCES",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: SWColor.black),
                  textAlign: TextAlign.center,
                ),
              ),
              dropdownMenuMultiSelectWithSearch(
                hintText: "Choose a few preferences...",
                data: SWWalkPreferenceExtension.formattedNames(),
                context: context,
                onChanged: (newValue) {
                  setState(() {
                    walkPreferences = newValue
                        .map(
                          (e) =>
                              SWWalkPreferenceExtension.fromFormattedName(e!)!,
                        )
                        .toList();
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "TAP TO UPLOAD A PROFILE PHOTO",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: SWColor.black),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: selectImage,
                child: Center(
                  child: UserProfileImage(
                    imageURL: profileImageURL,
                    radius: 100,
                    showStatusDot: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20),

      customButton(
        text: "NEXT",
        onPressed: confirmFinished,
        backgroundColor: SWColor.blueLight,
      ),

      SizedBox(height: 100),
    ];
    return Scaffold(
      backgroundColor: SWColor.white,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: listViewItems.length,
          itemBuilder: (context, index) => listViewItems[index],
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
        ),
      ),
    );
  }
}
