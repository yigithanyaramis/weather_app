// Image sabitlerini tanımlayan singleton sınıfımız
class ImageConstants {
  static final ImageConstants _instance = ImageConstants._init();
  
  static ImageConstants get instance => _instance;

  ImageConstants._init();

  // PNG formatı
  String toPng(String name) => 'assets/images/$name.png';

  // Getterlerimiz
  String get logo => toPng('logo');
}
