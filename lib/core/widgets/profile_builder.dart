import 'package:chat/core/utils/app_colors.dart';
import 'package:chat/core/utils/constants/app_constants.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:chat/core/widgets/custom_divider.dart';
import 'package:chat/core/widgets/custom_text_feild.dart';
import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBuilder extends StatelessWidget {
  const ProfileBuilder({
    super.key,
    required this.user,
    this.nameController,
    this.bioController,
    this.me = false,
  });
  final UserEntity user;
  final TextEditingController?nameController,bioController;
  final bool me;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is UpdateProfileDataSuccess) {
          AppConstants.showToast(context,
              msg: "Data updated successfully", color: AppColors.successColor);
        }
        if (state is UpdateProfileImageSuccess) {
          AppConstants.showToast(context,
              msg: "Profile image updated successfully",
              color: AppColors.successColor);
        }
        if (state is UpdateProfileDataFailure) {
          AppConstants.showToast(context,
              msg: state.errMsg, color: AppColors.failureColor);
        }
        if (state is UpdateProfileImageFailure) {
          AppConstants.showToast(context,
              msg: state.errMsg, color: AppColors.failureColor);
        }
      },
      builder: (context, state) {
        final TextInputType keyboardType;
        if (me) {
          // true ==> my profile
          keyboardType = TextInputType.text;
        } else {
          keyboardType = TextInputType.none;
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (state is UpdateProfileImageLoading ||
                  state is UpdateProfileDataLoading)
                const LinearProgressIndicator(),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: AppColors.primaryColor,
                    child: CircleAvatar(
                      radius: 62,
                      backgroundImage: NetworkImage(user.profileImage!),
                    ),
                  ),
                  if (me)
                    IconButton(
                      onPressed: () {
                        AuthenticationCubit.get(context).changeProfilePhoto();
                      },
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: AppColors.primaryColor,
                        size: 32,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomDivider(),
              CustomTextField(
                initialValue: user.name,
                keyboardType: keyboardType,
                prefixIcon: Icons.person_2_rounded,
                hintText: "Name",
                onChanged: (p0) {
                  if(nameController!=null){
                  nameController!.text = p0;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                initialValue: user.bio,
                prefixIcon: Icons.summarize_rounded,
                keyboardType: keyboardType,
                hintText: "BIO",
                onChanged: (p0) {
                  if(bioController!=null){
                  bioController!.text = p0;
                  }
                },
              ),
              const CustomDivider(),
              if (me)
                CustomButton(
                  buttonTxt: "UPDATE",
                  onButtonPressed: () {
                    AuthenticationCubit.get(context).updataProfileData(
                        newName: nameController!.text,
                        newBio: bioController!.text);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
