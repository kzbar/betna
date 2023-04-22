import 'dart:math';

import 'package:betna/setup/enumerators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum UpLoadState { done, wait, error, none }


String _chars = '1234567890';
Random _rnd = Random();

String formatNumber(String string) {
  final format = NumberFormat.decimalPattern('en');
  return format.format(int.parse(string));
}

List listLanguages = [
  {'icon': 'assets/flags/en.png', 'lang': 'en', 'title': " English"},
  {'icon': 'assets/flags/ar.png', 'lang': 'ar', 'title': "العربية"},
  {'icon': 'assets/flags/tr.png', 'lang': 'tr', 'title': "Turkish"}
];
List listSocial = [
  {
    "id":"1",
    'icon': 'assets/PNG/1.png',
    'action': 'en',
    'title': {
      'ar': '',
      'tr': '',
      'en': 'whatsapp',
    },
    "url": "https://wa.me/message/WTBMCUW6NPAQA1"
  },
  {
    "id":"2",

    'icon': 'assets/PNG/2.png',
    'action': 'en',
    'title': {
      'ar': '',
      'tr': '',
      'en': 'facebook',
    },
    "url": "https://www.facebook.com/betnatr"
  },
  // {
  //    "id":"3",
  //   'icon': 'assets/PNG/3.png',
  //   'action': 'en',
  //   'title': {
  //     'ar': '',
  //     'tr': '',
  //     'en': 'twitter',
  //   },
  //   "url": ""
  // },
  {
    "id":"4",

    'icon': 'assets/PNG/4.png',
    'action': 'en',
    'title': {
      'ar': '',
      'tr': '',
      'en': 'Instagram',
    },
    "url": "https://www.instagram.com/betnatr"
  },
  {
    "id":"5",

    'icon': 'assets/PNG/5.png',
    'action': 'en',
    'title': {
      'ar': '',
      'tr': '',
      'en': 'location',
    },
    "url": ""
  },
  {
    "id":"6",

    'icon': 'assets/PNG/6.png',
    'action': 'en',
    'title': {
      'ar': '',
      'tr': '',
      'en': 'website',
    },
    "url": "https://betna.net"
  },
  {
    "id":"7",
    'icon': 'assets/PNG/7.png',
    'action': 'en',
    'title': {
      'ar': '',
      'tr': '',
      'en': 'email',
    },
    "url": "mailto:ahmadkzbar@gmail.com"
  },
  {
    "id":"8",
    'icon': 'assets/PNG/8.png',
    'action': 'en',
    'title': {
      'ar': '',
      'tr': '',
      'en': 'phone number',
    },
    "url": "tel:+905525333666"
  },
];

Map<String, dynamic> kHeaderPageModelRent = {
  "id": '1',
  "title": {
    'ar': 'Discover your perfect rental',
    'en': 'Discover your perfect rental',
    'tr': 'Discover your perfect rental'
  },
  "title2": {
    'ar': 'Discover your perfect rental',
    'en': 'Discover your perfect rental',
    'tr': 'Discover your perfect rental'
  },
  "image_url":
      "https://static.rdc.moveaws.com/images/hero/default/landing/hp-hero-rent-desktop.jpg",
  "header_type": "rent",
  "type": "rent",
  "dateInsert": Timestamp.now()
};
Map<String, dynamic> kHeaderPageModelSale = {
  "id": '2',
  "title": {
    'ar': 'Discover your perfect rental',
    'en': 'Discover your perfect rental',
    'tr': 'Discover your perfect rental'
  },
  "title2": {
    'ar': 'Discover your perfect rental',
    'en': 'Discover your perfect rental',
    'tr': 'Discover your perfect rental'
  },
  "image_url":
      "https://static.rdc.moveaws.com/images/hero/default/hp-hero-desktop-2021.jpg",
  "header_type": "sale",
  "type": "sale",
  "dateInsert": Timestamp.now()
};
Map<String, dynamic> kHeaderPageModelProject = {
  "id": '3',
  "title": {
    'ar': 'Discover your perfect rental',
    'en': 'Discover your perfect rental',
    'tr': 'Discover your perfect rental'
  },
  "title2": {
    'ar': 'Discover your perfect rental',
    'en': 'Discover your perfect rental',
    'tr': 'Discover your perfect rental'
  },
  "image_url":
      "https://static.rdc.moveaws.com/images/hero/default/hp-hero-desktop-2021.jpg",
  "header_type": "project",
  "type": "project",
  "dateInsert": Timestamp.now()
};

const kAppLanguage = [
  {"icon": 'assets/flags/GBP.png', 'lang': Lang.EN, "text": 'English'},
  {"icon": 'assets/flags/SAR.png', 'lang': Lang.AR, "text": 'العربية'},
  {"icon": 'assets/flags/TRY.png', 'lang': Lang.TR, "text": 'Turkish'}
];

const forSaleElements = [
  {
    'attribute': 'ad_id',
    'type': 'TextField',
    'hint': {'tr': 'İlan No', 'ar': 'رقم الاعلان', 'en': 'Ad Number'},
    'keyboardType': TextInputType.text,
    'width': 400.0,
    'height': 80.0,
  },
  {
    'attribute': 'title',
    'type': 'TextFieldTranslate',
    'hint': {'tr': 'Baslik', 'ar': 'العنوان', 'en': 'title'},
    'keyboardType': TextInputType.text,
    'width': 400.0,
    'height': 120.0,
  },
  {
    'width': 800.0,
    'height': 400.0,
    'attribute': 'explanation',
    'type': 'TextFieldTranslate',
    'hint': {'tr': 'Açıklama', 'ar': 'الشرح', 'en': 'Explanation'},
    'keyboardType': TextInputType.text,
  },
  {
    'attribute': 'date',
    'type': 'Date',
    'hint': {'tr': '', 'ar': '', 'en': 'Date'},
    'keyboardType': TextInputType.text,
    'width': 400.0,
    'height': 80.0,
  },
  {
    'attribute': 'price',
    'type': 'TextField',
    'hint': {'tr': 'Fiyat', 'ar': 'السعر', 'en': 'Price'},
    'keyboardType': TextInputType.number,
    'width': 400.0,
    'height': 80.0,
  },
  {
    'attribute': 'area',
    'type': 'TextField',
    'hint': {'tr': 'm² (Brüt)', 'ar': 'المساحة الاجمالية', 'en': 'area'},
    'keyboardType': TextInputType.number,
    'width': 400.0,
    'height': 80.0,
  },
  {
    'attribute': 'net_area',
    'type': 'TextField',
    'hint': {'tr': 'm² (Net)', 'ar': 'المساحةالصافية ', 'en': 'Net area'},
    'keyboardType': TextInputType.number,
    'width': 400.0,
    'height': 80.0,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'inside_site',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Site İçerisinde', 'ar': 'داخل مجمع', 'en': 'Inside site'},
    'list': ['*','yes', 'no',]
  },
  {
    'attribute': 'age_building',
    'type': 'TextField',
    'hint': {'tr': 'Bina Yaşı', 'ar': 'عمر البناء', 'en': 'Age building'},
    'keyboardType': TextInputType.number,
    'width': 400.0,
    'height': 80.0,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'balcony',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Balkon', 'ar': 'بلكون', 'en': 'Balcony'},
    'list': ['yes', 'no']
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'affordableHomes',
    'type': 'FormBuilderDropdown',
    'hint': {
      'tr': 'Uygun Fiyatlı Evler',
      'ar': 'منزل مناسب',
      'en': 'affordable Homes'
    },
    'list': ['yes', 'no']
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'luxuryHomes',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Lüks evler', 'ar': 'منزل فخم', 'en': 'luxury Homes'},
    'list': ['yes', 'no']
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'state',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Eşyalı', 'ar': 'وضع العقار', 'en': 'Furnished'},
    'list': [
      {'id': '1', 'ar': 'فارغ', 'en': 'Throat', 'tr': 'Boğaz'},
      {'id': '2', 'ar': 'مؤجر', 'en': 'Sea', 'tr': 'Deniz'},
      {'id': '3', 'ar': 'صاجب البيت', 'en': 'Nature', 'tr': 'Doğa'},
    ]
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'room',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Oda Sayısı', 'ar': 'عدد الغرف', 'en': 'rooms'},
    'list': [
      '*',
      '1+0',
      '1+1',
      '1+2',
      '1+3',
      '1+4',
      '1+5',
      '1+6',
      '2+2',
      '2+3',
      '2+4',
      '2+5',
    ]
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'floor',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Bulunduğu Kat', 'ar': 'الطابق', 'en': 'floor'},
    'list': [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38'
    ]
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'floors',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'kat sayısı', 'ar': 'عدد الطوابق', 'en': 'floor'},
    'list': [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38'
    ]
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'bathrooms',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'yatak odasi', 'ar': 'غرفة النوم', 'en': 'bath rooms'},
    'list': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
  },
  {
    'width': 400.0,
    'attribute': 'types_heating',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'ısıtma', 'ar': 'التدفئة', 'en': 'types heating'},
    'list': [
      {
        'id': '1',
        'ar': 'المركز حصة العداد',
        'en': 'Center Share Meter',
        'tr': 'Merkezi Pay Ölçer'
      },
      {
        'id': '2',
        'ar': 'الغاز الطبيعي (كومبي)',
        'en': 'Natural Gas (Combi)',
        'tr': 'Doğalgaz (Kombi)'
      },
    ]
  },
  {
    'width': 400.0,
    'attribute': 'property_case',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'durum', 'ar': 'حالة العقار', 'en': 'property case'},
    'list': ['yes', 'no']
  },
  {
    'width': 400.0,
    'attribute': 'urgent',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Acil', 'ar': 'عاجل', 'en': 'urgent'},
    'list': ['yes', 'no']
  },
  {
    'width': 400.0,
    'attribute': 'internal_features',
    'type': 'FormBuilderFilterChip',
    'hint': {
      'tr': 'iç özellikler',
      'ar': 'الميزات الداخلية',
      'en': 'Internal features'
    },
    'list': [
      {'ar': 'ADSL', 'en': 'ADSL', 'id': '1', 'tr': 'ADSL'},
      {
        'ar': 'نجارة الخشب',
        'en': 'Wood Joinery',
        'id': '2',
        'tr': 'Ahşap Doğrama'
      },
      {'id': '3', 'ar': 'المنزل الذكي', 'en': 'Smart House', 'tr': 'Akıllı Ev'},
      {
        'ar': 'إنذار (لص)',
        'en': 'Alarm (Thief)',
        'id': '4',
        'tr': 'Alarm (Hırsız)'
      },
      {
        'ar': 'إنذار (حريق)',
        'en': 'Alarm (Fire)',
        'id': '5',
        'tr': 'Alarm (Yangın)'
      },
      {
        'ar': 'مرحاض الاتوركه',
        'en': 'Alaturka Toilet',
        'id': '6',
        'tr': 'Alaturka Tuvalet'
      },
      {
        'ar': 'نجارة الألمنيوم',
        'en': 'Aluminum joinery',
        'id': '7',
        'tr': 'Alüminyum Doğrama'
      },
      {
        'ar': 'باب امريكي',
        'en': 'American Door',
        'id': '8',
        'tr': 'Amerikan Kapı'
      },
      {
        'ar': 'مطبخ أمريكي',
        'en': 'American kitchen',
        'id': '9',
        'tr': 'Amerikan Mutfak'
      },
      {
        'ar': 'المقود والفرن',
        'en': 'Built-in oven',
        'id': '10',
        'tr': 'Ankastre Fırın'
      },
      {'ar': 'مصعد', 'en': 'Elevator', 'id': '11', 'tr': 'Asansör'},
      {'ar': 'شرفة', 'en': 'Balcony', 'id': '12', 'tr': 'Balkon'},
      {'ar': 'الشواء', 'en': 'Barbecue', 'id': '13', 'tr': 'Barbekü'},
      {
        'ar': 'الأجهزة المنزلية',
        'en': 'Household appliances',
        'id': '14',
        'tr': 'Beyaz Eşya'
      },
      {'ar': 'طلاءء المنزل', 'en': 'Painted', 'id': '15', 'tr': 'Boyalı'},
      {
        'ar': 'غسالة الأواني',
        'en': 'Bulaşık Makinesi',
        'id': '16',
        'tr': 'Bulaşık Makinesi'
      },
      {'ar': 'ثلاجة', 'en': 'Refrigerator', 'id': '17', 'tr': 'Buzdolabı'},
      {
        'ar': 'ورق الجدران',
        'en': 'Wall paper',
        'id': '18',
        'tr': 'Duvar Kağıdı'
      },
      {
        'ar': 'حجرة استحمام',
        'en': 'Shower cabin',
        'id': '19',
        'tr': 'Duşakabin'
      },
      {
        'ar': 'حمام الوالدين',
        'en': 'Parents Bathroom',
        'id': '20',
        'tr': 'Ebeveyn Banyosu'
      },
      {
        'ar': 'الألياف الضوئية',
        'en': 'Fiber Internet',
        'id': '21',
        'tr': 'Fiber İnternet'
      },
      {'ar': 'فرن', 'en': 'Oven', 'id': '22', 'tr': 'Fırın'},
      {
        'ar': 'غرفة الملابس',
        'en': 'Dressing room',
        'id': '23',
        'tr': 'Giyinme Odası'
      },
      {'ar': 'خزانة', 'en': 'Closet', 'id': '24', 'tr': 'Gömme Dolap'},
      {
        'ar': 'الاتصال الداخلي عبر الفيديو',
        'en': 'Video intercom',
        'id': '25',
        'tr': 'Görüntülü Diafon'
      },
      {
        'ar': 'حمام هيلتون',
        'en': 'Hilton Bathroom',
        'id': '26',
        'tr': 'Hilton Banyo'
      },
      {
        'ar': 'نظام الاتصال الداخلي',
        'en': 'Intercom System',
        'id': '27',
        'tr': 'Intercom Sistemi'
      },
      {
        'ar': 'الزجاج العازل',
        'en': 'Insulating glass',
        'id': '28',
        'tr': 'Isıcam'
      },
      {'ar': 'جاكوزي', 'en': 'Jacuzzi', 'id': '29', 'tr': 'Jakuzi'},
      {
        'ar': 'اللوح الجصي',
        'en': 'Plasterboard',
        'id': '30',
        'tr': 'Kartonpiyer'
      },
      {'ar': 'قبو', 'en': 'Cellar', 'id': '31', 'tr': 'Kiler'},
      {
        'ar': 'مكيف الهواء',
        'en': 'Air conditioning',
        'id': '32',
        'tr': 'Klima'
      },
      {'ar': 'حوض', 'en': 'Tub', 'id': '33', 'tr': 'Küvet'},
      {
        'ar': 'صفح أرضية',
        'en': 'Laminate Floor',
        'id': '34',
        'tr': 'Laminat Zemin'
      },
      {'ar': 'مارلي', 'en': 'Marley', 'id': '35', 'tr': 'Marley'},
      {'ar': 'أثاث المنزل', 'en': 'Furniture', 'id': '36', 'tr': 'Mobilya'},
      {
        'ar': 'المطبخ (مدمج)',
        'en': 'Kitchen (Built-in)',
        'id': '37',
        'tr': 'Mutfak (Ankastre)'
      },
      {
        'ar': 'مطبخ (مصفح)',
        'en': 'Kitchen (Laminate)',
        'id': '38',
        'tr': 'Mutfak (Laminat)'
      },
      {
        'ar': 'مطبخ غاز طبيعي',
        'en': 'Kitchen Natural Gas',
        'id': '39',
        'tr': 'Mutfak Doğalgazı'
      },
      {'ar': 'نجارة PVC', 'en': 'PVC Joinery', 'id': '40', 'tr': 'PVC Doğrama'},
      {'ar': 'الستائر', 'en': 'Blinds', 'id': '41', 'tr': 'Panjur'},
      {
        'ar': 'أرضية باركيه',
        'en': 'Parquet Floor',
        'id': '42',
        'tr': 'Parke Zemin'
      },
      {
        'ar': 'ارضيات سيراميك',
        'en': 'Ceramic Floor',
        'id': '43',
        'tr': 'Seramik Zemin'
      },
      {
        'ar': 'تعيين أعلى طباخ',
        'en': 'Set Top Cooker',
        'id': '44',
        'tr': 'Set Üstü Ocak'
      },
      {
        'ar': 'إضاءة موضعية',
        'en': 'Spot Lighting',
        'id': '45',
        'tr': 'Spot Aydınlatma'
      },
      {'ar': 'مصطبة', 'en': 'Terrace', 'id': '46', 'tr': 'Teras'},
      {'ar': 'ترموسيفون', 'en': 'Thermosiphon', 'id': '47', 'tr': 'Termosifon'},
      {'ar': 'حجرة إيداع', 'en': 'Cloakroom', 'id': '48', 'tr': 'Vestiyer'},
      {'ar': 'Wi-Fi', 'en': 'Wi-Fi', 'id': '49', 'tr': 'Wi-Fi'},
      {
        'ar': 'التعرف على الوجه وبصمات الأصابع',
        'en': 'Face Recognition & Fingerprint',
        'id': '50',
        'tr': 'Yüz Tanıma & Parmak İzi'
      },
      {
        'ar': 'غسالة-تجفيف',
        'en': 'Washing Machine',
        'id': '51',
        'tr': 'Çamaşır Kurutma Makinesi'
      },
      {
        'ar': 'غسالة',
        'en': 'Washing machine',
        'id': '52',
        'tr': 'Çamaşır Makinesi'
      },
      {
        'ar': 'غرفة الغسيل',
        'en': 'Laundry room',
        'id': '53',
        'tr': 'Çamaşır Odası'
      },
      {'ar': 'باب حديد', 'en': 'Steel door', 'id': '54', 'tr': 'Çelik Kapı'},
      {'ar': 'سخان الماء', 'en': 'Water heater', 'id': '55', 'tr': 'Şofben'},
      {'ar': 'المدفأة', 'en': 'Fireplace', 'id': '56', 'tr': 'Şömine'},
    ]
  },
  {
    'width': 400.0,
    'attribute': 'external_features',
    'type': 'FormBuilderFilterChip',
    'hint': {
      'tr': 'dış özellikler',
      'ar': 'الميزات الخارجية',
      'en': 'External Features'
    },
    'list': [
      {'id': '1', 'ar': 'مصعد', 'en': 'Elevator', 'tr': 'Asansör'},
      {'id': '2', 'ar': 'غرفة بخار', 'en': 'Steam room', 'tr': 'Buhar Odası'},
      {'id': '3', 'ar': 'الحرس', 'en': 'Security', 'tr': 'Güvenlik'},
      {'id': '4', 'ar': 'حمام', 'en': 'Bath', 'tr': 'Hamam'},
      {'id': '5', 'ar': 'الداعم', 'en': 'Booster', 'tr': 'Hidrofor'},
      {
        'id': '6',
        'ar': 'العزل الحراري',
        'en': 'Thermal Insulation',
        'tr': 'Isı Yalıtım'
      },
      {'id': '7', 'ar': 'مولد كهرباء', 'en': 'Generator', 'tr': 'Jeneratör'},
      {
        'id': '8',
        'ar': 'الكيبل التلفزيوني',
        'en': 'Cable TV',
        'tr': 'Kablo TV'
      },
      {
        'id': '9',
        'ar': 'نظام الكاميرا',
        'en': 'Camera system',
        'tr': 'Kamera Sistemi'
      },
      {
        'id': '10',
        'ar': 'جراج مغلق',
        'en': 'Closed Garage',
        'tr': 'Kapalı Garaj'
      },
      {'id': '11', 'ar': 'بواب', 'en': 'Doorman', 'tr': 'Kapıcı'},
      {'id': '12', 'ar': 'حضانة', 'en': 'Nursery', 'tr': 'Kreş'},
      {
        'id': '13',
        'ar': 'مع بركة سباحة خاصة',
        'en': 'With Private Pool',
        'tr': 'Müstakil Havuzlu'
      },
      {'id': '14', 'ar': 'موقف السيارات', 'en': 'Car park', 'tr': 'Otopark'},
      {'id': '15', 'ar': 'ملعب', 'en': 'Playground', 'tr': 'Oyun Parkı'},
      {'id': '16', 'ar': 'ساونا', 'en': 'Sauna', 'tr': 'Sauna'},
      {
        'id': '17',
        'ar': 'عزل الصوت',
        'en': 'Sound insulation',
        'tr': 'Ses Yalıtımı'
      },
      {'id': '18', 'ar': 'انحياز', 'en': 'Siding', 'tr': 'Siding'},
      {
        'id': '19',
        'ar': 'منطقة رياضية',
        'en': 'Sports Area',
        'tr': 'Spor Alanı'
      },
      {'id': '20', 'ar': 'خزان الماء', 'en': 'Water tank', 'tr': 'Su Deposu'},
      {'id': '21', 'ar': 'ملعب تنس', 'en': 'Tennis court', 'tr': 'Tenis Kortu'},
      {'id': '22', 'ar': 'الأقمار الصناعية', 'en': 'Satellite', 'tr': 'Uydu'},
      {
        'id': '23',
        'ar': 'سلم النجاة',
        'en': 'Fire escape',
        'tr': 'Yangın Merdiveni'
      },
      {
        'id': '24',
        'ar': 'حوض السباحة (مفتوح)',
        'en': 'Swimming Pool (Open)',
        'tr': 'Yüzme Havuzu (Açık)'
      },
      {
        'id': '25',
        'ar': 'حوض سباحة (داخلي)',
        'en': 'Swimming Pool (Indoor)',
        'tr': 'Yüzme Havuzu (Kapalı)'
      },
    ]
  },
  {
    'width': 400.0,
    'attribute': 'neighborhood',
    'type': 'FormBuilderFilterChip',
    'hint': {'tr': 'Mahlle', 'ar': 'المرافق العامة', 'en': 'neighborhood'},
    'list': [
      {
        'id': '1',
        'ar': 'مركز التسوق',
        'en': 'The mall',
        'tr': 'Alışveriş Merkezi'
      },
      {'id': '2', 'ar': 'البلدية', 'en': 'municipality', 'tr': 'Belediye'},
      {'id': '3', 'ar': 'جامع', 'en': 'Mosque', 'tr': 'Cami'},
      {'id': '4', 'ar': '', 'en': 'Cemevi', 'tr': 'Cemevi'},
      {
        'id': '5',
        'ar': 'البحر',
        'en': 'Next to sea shore',
        'tr': 'Denize Sıfır'
      },
      {'id': '6', 'ar': 'صيدلية', 'en': 'Pharmacy', 'tr': 'Eczane'},
      {
        'id': '7',
        'ar': 'مركز تسلية',
        'en': 'Amusement center',
        'tr': 'Eğlence Merkezi'
      },
      {'id': '8', 'ar': 'المعارض', 'en': 'Fair', 'tr': 'Fuar'},
      {'id': '9', 'ar': 'المشفى', 'en': 'Hospital', 'tr': 'Hastane'},
      {
        'id': '10',
        'ar': 'كنيس أو مجمع يهودي',
        'en': 'Synagogue',
        'tr': 'Havra'
      },
      {'id': '11', 'ar': 'الكنيسة', 'en': 'The church', 'tr': 'Kilise'},
      {'id': '12', 'ar': 'المدرسة الثانوية', 'en': 'High school', 'tr': 'Lise'},
      {'id': '13', 'ar': 'الماركت', 'en': 'Market', 'tr': 'Market'},
      {'id': '14', 'ar': 'حديقة', 'en': 'Park', 'tr': 'Park'},
      {
        'id': '15',
        'ar': 'مركز الشرطة',
        'en': 'Police station',
        'tr': 'Polis Merkezi'
      },
      {
        'id': '16',
        'ar': 'العيادة الصحية',
        'en': 'The health clinic',
        'tr': 'Sağlık Ocağı'
      },
      {
        'id': '17',
        'ar': 'سوق المنطقة',
        'en': 'District Market',
        'tr': 'Semt Pazarı'
      },
      {'id': '18', 'ar': 'صالة الرياضة', 'en': 'Gym', 'tr': 'Spor Salonu'},
      {'id': '19', 'ar': 'جامعة', 'en': 'University', 'tr': 'Üniversite'},
      {
        'id': '20',
        'ar': 'مدرسة إبتدائية ',
        'en': 'Primary School-Secondary School',
        'tr': 'İlkokul-Ortaokul'
      },
      {
        'id': '21',
        'ar': 'قسم الأطفاء',
        'en': 'Fire Department',
        'tr': 'İtfaiye'
      },
      {
        'id': '22',
        'ar': 'مركز المدينة',
        'en': 'Town center',
        'tr': 'Şehir Merkezi'
      },
    ]
  },
  {
    'width': 400.0,
    'attribute': 'transportation',
    'type': 'FormBuilderFilterChip',
    'hint': {'tr': 'taşımacılık', 'ar': 'وسائل النقل', 'en': ' Transportation'},
    'list': [
      {'id': '1', 'ar': 'الطريق السريع', 'en': 'Highway', 'tr': 'Anayol'},
      {
        'id': '2',
        'ar': 'نفق أوراسيا',
        'en': 'Eurasia Tunnel',
        'tr': 'Avrasya Tüneli'
      },
      {
        'id': '3',
        'ar': 'جسور البوسفور',
        'en': 'Bosphorus Bridges',
        'tr': 'Boğaz Köprüleri'
      },
      {'id': '4', 'ar': 'شارع', 'en': 'Street', 'tr': 'Cadde'},
      {
        'id': '5',
        'ar': 'الحافلة البحرية',
        'en': 'Sea bus',
        'tr': 'Deniz Otobüsü'
      },
      {'id': '6', 'ar': 'الباصات الصغيرة', 'en': 'Filled', 'tr': 'Dolmuş'},
      {'id': '7', 'ar': 'E-5', 'en': 'E-5', 'tr': 'E-5'},
      {'id': '8', 'ar': 'مرمرة', 'en': 'Marmaray', 'tr': 'Marmaray'},
      {'id': '9', 'ar': 'المترو', 'en': 'Metro', 'tr': 'Metro'},
      {'id': '10', 'ar': 'المتروباص', 'en': 'Metrobus', 'tr': 'Metrobüs'},
      {'id': '11', 'ar': 'ميني باص', 'en': 'Minibus', 'tr': 'Minibüs'},
      {'id': '12', 'ar': 'موقف الباص', 'en': 'Bus stop', 'tr': 'Otobüs Durağı'},
      {'id': '13', 'ar': 'الساحل', 'en': 'Beach', 'tr': 'Sahil'},
      {'id': '14', 'ar': 'TEM', 'en': 'TEM', 'tr': 'TEM'},
      {'id': '15', 'ar': 'عربة قطار', 'en': 'Cable car', 'tr': 'Teleferik'},
      {'id': '16', 'ar': 'ترامواي', 'en': 'Tram', 'tr': 'Tramvay'},
      {
        'id': '17',
        'ar': 'محطة قطار',
        'en': 'Railway station',
        'tr': 'Tren İstasyonu'
      },
      {'id': '18', 'ar': 'ترولي باص', 'en': 'Trolley bus', 'tr': 'Troleybüs'},
      {'id': '19', 'ar': 'رصيف بحري', 'en': 'Scaffolding', 'tr': 'İskele'},
    ]
  },
  {
    'width': 400.0,
    'attribute': 'view',
    'type': 'FormBuilderFilterChip',
    'hint': {'tr': 'manzara', 'ar': 'الاطلالات', 'en': 'View'},
    'list': [
      {'id': '1', 'ar': 'جسر', 'en': 'Throat', 'tr': 'Boğaz'},
      {'id': '2', 'ar': 'البحر', 'en': 'Sea', 'tr': 'Deniz'},
      {'id': '3', 'ar': 'الطبيعة', 'en': 'Nature', 'tr': 'Doğa'},
      {'id': '4', 'ar': 'بحيرة', 'en': 'Lake', 'tr': 'Göl'},
      {'id': '5', 'ar': 'المسبح', 'en': 'Pool', 'tr': 'Havuz'},
      {
        'id': '6',
        'ar': 'الحديقة والمنطقة الخضراء',
        'en': 'Park & Green Area',
        'tr': 'Park & Yeşil Alan'
      },
      {'id': '7', 'ar': 'المدينة', 'en': 'City', 'tr': 'Şehir'},
    ]
  },
];
const kRentElements = [
  {
    'attribute': 'title',
    'type': 'TextFieldTranslate',
    'hint': {'tr': 'Baslik', 'ar': 'العنوان', 'en': 'title'},
    'keyboardType': TextInputType.text,
    'width': 400.0,
    'height': 120.0,
  },
  {
    'width': 400.0,
    'height': 300.0,
    'attribute': 'explanation',
    'type': 'TextFieldTranslate',
    'hint': {'tr': 'Açıklama', 'ar': 'الشرح', 'en': 'Explanation'},
    'keyboardType': TextInputType.text,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'ad_id',
    'type': 'TextField',
    'hint': {'tr': 'İlan No', 'ar': 'رقم الاعلان', 'en': 'Ad Number'},
    'keyboardType': TextInputType.text,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'date',
    'type': 'Date',
    'hint': {'tr': '', 'ar': '', 'en': 'Date'},
    'keyboardType': TextInputType.text,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'rent',
    'type': 'TextField',
    'hint': {'tr': 'kira', 'ar': 'الايجار', 'en': 'Rent'},
    'keyboardType': TextInputType.number,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'area',
    'type': 'TextField',
    'hint': {'tr': 'm² (Brüt)', 'ar': 'المساحة الاجمالية', 'en': 'area'},
    'keyboardType': TextInputType.number,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'net_area',
    'type': 'TextField',
    'hint': {'tr': 'm² (Net)', 'ar': 'المساحةالصافية ', 'en': 'Net area'},
    'keyboardType': TextInputType.number,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'age_building',
    'type': 'TextField',
    'hint': {'tr': 'Bina Yaşı', 'ar': 'عمر البناء', 'en': 'Age building'},
    'keyboardType': TextInputType.number,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'fee',
    'type': 'TextField',
    'hint': {'tr': 'Aidat', 'ar': 'العائدات', 'en': 'Fee'},
    'keyboardType': TextInputType.number,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'deposit',
    'type': 'TextField',
    'hint': {'tr': 'Depozito', 'ar': 'التأمين', 'en': 'Deposit'},
    'keyboardType': TextInputType.number,
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'inside_site',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Site İçerisinde', 'ar': 'داخل مجمع', 'en': 'Inside site'},
    'list': ['yes', 'no']
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'balcony',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Balkon', 'ar': 'بلكون', 'en': 'Balcony'},
    'list': ['yes', 'no']
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'state',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Eşyalı', 'ar': 'وضع العقار', 'en': 'Furnished'},
    'list': [
      {'id': '1', 'ar': 'فارغ', 'en': 'Throat', 'tr': 'Boğaz'},
      {'id': '2', 'ar': 'مؤجر', 'en': 'Sea', 'tr': 'Deniz'},
      {'id': '3', 'ar': 'صاجب البيت', 'en': 'Nature', 'tr': 'Doğa'},
    ]
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'room',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Oda Sayısı', 'ar': 'عدد الغرف', 'en': 'rooms'},
    'list': [
      "*",
      '1+0',
      '1+1',
      '1+2',
      '1+3',
      '1+4',
      '1+5',
      '1+6',
      '2+2',
      '2+3',
      '2+4',
      '2+5',
    ]
  },
  {
    'width': 400.0,
    'height': 80.0,
    'attribute': 'floor',
    'type': 'FormBuilderDropdown',
    'hint': {'tr': 'Bulunduğu Kat', 'ar': 'الطابق', 'en': 'floor'},
    'list': [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38'
    ]
  },
];

const kUserElement = [
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'uid',
    'type': 'TextField',
    'hint': {'tr': 'id', 'ar': 'معرف', 'en': 'Id'},
    'keyboardType': TextInputType.text,
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'name',
    'type': 'TextField',
    'hint': {'tr': 'ad Soyad', 'ar': 'الاسم و الكنية', 'en': 'Name Surname'},
    'keyboardType': TextInputType.text,
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'email',
    'type': 'TextField',
    'hint': {'tr': 'E-posta', 'ar': 'الايميل', 'en': ' Email'},
    'keyboardType': TextInputType.text,
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'password',
    'type': 'TextField',
    'hint': {'tr': 'Parola', 'ar': 'كلمة السر', 'en': 'Password'},
    'keyboardType': TextInputType.text,
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'roles_sale',
    'type': 'FormBuilderFilterChip',
    'hint': {
      'tr': 'Satış Departmanı',
      'ar': 'قسم المبيع',
      'en': 'Sales department'
    },
    'list': ['deleting', 'editing', 'adding', 'watching']
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'roles_rent',
    'type': 'FormBuilderFilterChip',
    'hint': {
      'tr': 'Kiralama departmanı',
      'ar': 'قسم الايجار',
      'en': 'Rent department'
    },
    'list': ['deleting', 'editing', 'adding', 'watching']
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'roles_contract',
    'type': 'FormBuilderFilterChip',
    'hint': {
      'tr': 'Sözleşmeler Bölümü',
      'ar': 'قسم العقود',
      'en': 'Contracts Section'
    },
    'list': ['deleting', 'editing', 'adding', 'watching']
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'roles_user',
    'type': 'FormBuilderFilterChip',
    'hint': {
      'tr': 'Kullanıcılar bölümü',
      'ar': 'قسم المستخدمين',
      'en': 'Users section'
    },
    'list': ['deleting', 'editing', 'adding', 'watching']
  },
  {
    'width': 500.0,
    'height': 80.0,
    'attribute': 'isAdmin',
    'type': 'FormBuilderCheckbox',
    'hint': {
      'tr': 'Kullanıcı admin mi?',
      'ar': 'المستخدم هو المشرف؟',
      'en': 'User is admin ?'
    },
  }
];

const kPropertyType = [
  {'id': '1', 'ar': 'شقق', 'en': 'Apartments', 'tr': 'Daireler'},
  {
    'id': '2',
    'ar': 'شقق فندقية',
    'en': 'Hotel Appartments',
    'tr': 'Otel Daireleri'
  },
  {'id': '3', 'ar': 'Villas', 'en': 'Apartments', 'tr': 'villalar'},
  {'id': '4', 'ar': 'هوم اوفس', 'en': 'Home office', 'tr': 'Home office'}
];
const kProjectState = [
  {
    'id': '1',
    'ar': 'قيد الإنشاء',
    'en': 'under construction',
    'tr': 'Yapım aşamasındaki'
  },
  {
    'id': '2',
    'ar': 'جاهز للسكن',
    'en': 'Ready for housing',
    'tr': 'Konut projelerine hazır'
  },
  {
    'id': '3',
    'ar': 'مشروع استثماري',
    'en': 'Investment project',
    'tr': 'Yatırım projeleri'
  }
];

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
