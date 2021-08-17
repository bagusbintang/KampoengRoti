class FaqModel {
  int id;
  bool isExpanded;
  int number;
  String title;
  String desc;

  FaqModel({
    this.number,
    this.title,
    this.desc,
    this.isExpanded = false,
  });

  FaqModel.fromJson(Map<String, dynamic> faqJson) {
    id = faqJson['faq_id'];
    title = faqJson['faq_title'];
    desc = faqJson['faq_desc'];
    number = faqJson['faq_no'];
  }

  Map<String, dynamic> toJson() {
    return {
      'plist_id': id,
      'plist_title': title,
      'plist_desc': desc,
      'plist_no': number,
    };
  }
}
