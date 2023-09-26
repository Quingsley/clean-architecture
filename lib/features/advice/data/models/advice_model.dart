import 'package:clean_architecture/features/advice/domain/entities/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required super.advice, required super.id});

  factory AdviceModel.fromJSON(Map<String, dynamic> json) {
    if (json
        case {
          'advice': String advice,
          'advice_id': int id,
        }) {
      return AdviceModel(advice: advice, id: id);
    } else {
      throw const FormatException('Invalid JSON format');
    }
  }
}
