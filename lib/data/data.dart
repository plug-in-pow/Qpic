class SliderModel {
  String imagePath;
  String title;
  String description;

  SliderModel({this.imagePath, this.title, this.description});

  void setImageAssetPath(String getImagePath) {
    imagePath = getImagePath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setdescription(String getDescription) {
    description = getDescription;
  }

  String getImagePath() {
    return imagePath;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  // 1st slide
  sliderModel.setImageAssetPath('assets/undraw_live_photo_qhmw (1).png');
  sliderModel.setTitle('Upload or Capture Photo');
  sliderModel.setdescription('Easily upload photos from an Local Storage or' +
      'Capture a new Image for performing different actions !!');
  slides.add(sliderModel);

  // 2st slide
  sliderModel = new SliderModel();
  sliderModel.setImageAssetPath('assets/undraw_online_learning_ao11.png');
  sliderModel.setTitle('AI Intelligence');
  sliderModel.setdescription('Our High end AI technology will then help you ' +
      'to perform various actions right from predicting' +
      ' the right Captions to editing photos.');
  slides.add(sliderModel);

  // 3st slide
  sliderModel = new SliderModel();
  sliderModel.setImageAssetPath('assets/undraw_security_o890.png');
  sliderModel.setTitle('Privacy Control');
  sliderModel.setdescription('No need to worry about the privacy as we ' +
      'are performing the algorithms right into the system' +
      ', so no need to upload the data to any server. This also protects' +
      ' the data from the attackers.');
  slides.add(sliderModel);

  return slides;
}
