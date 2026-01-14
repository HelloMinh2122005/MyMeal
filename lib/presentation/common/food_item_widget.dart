import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/widgets/update_modal.dart';
import 'package:my_flutter_app/usecase/food_usecase.dart';
import 'package:my_flutter_app/usecase/type_usecase.dart';
import '../../core/styles/app_color.dart';

class FoodItemWidget extends StatelessWidget {
  final int itemId;
  final String itemName;
  final String itemImageUrl;
  final String itemMealType;
  final bool isEditable;

  const FoodItemWidget({
    super.key,
    required this.itemId,
    required this.itemName,
    required this.itemImageUrl,
    required this.itemMealType,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        leading: Image.network(
          itemImageUrl,
          width: 60,
          height: 40,
          fit: BoxFit.cover,
        ),
        title: Text(
          itemName,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          itemMealType,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Arial',
            color: Colors.grey,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isEditable) ...[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider(
                        create: (_) => MenuModalBloc(
                          foodUsecase: context.read<FoodUsecase>(),
                          typeUsecase: context.read<TypeUsecase>(),
                          itemId: itemId,
                        ),
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: UpdateModal(itemId: itemId),
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/edit.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF2F8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle remove action
                  },
                  child: SvgPicture.asset(
                    'assets/remove.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
