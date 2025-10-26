import 'package:flutter/material.dart';

class Template {
  final String title;
  final String message;
  final String reduction;

  Template({
    required this.title,
    required this.message,
    required this.reduction,
  });
}

class TemplateProvider with ChangeNotifier {
  final List<Template> _templates = [];

  List<Template> get templates => _templates;

  void addTemplate(Template template) {
    _templates.add(template);
    notifyListeners();
  }

  void clearTemplates() {
    _templates.clear();
    notifyListeners();
  }
}
