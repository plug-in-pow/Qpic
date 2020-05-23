class GridModel {
  String imagePath;

  GridModel({this.imagePath});

  void setImageAssetPath(String getImagePath) {
    imagePath = getImagePath;
  }

  String getImagePath() {
    return imagePath;
  }
}

List<GridModel> getGrids() {
  List<GridModel> grids = new List<GridModel>();
  GridModel gridModel = new GridModel();

  gridModel.setImageAssetPath('assets/Ai_caption.png');
  grids.add(gridModel);

  gridModel = new GridModel();
  gridModel.setImageAssetPath('assets/searchCaption.png');
  grids.add(gridModel);

  gridModel = new GridModel();
  gridModel.setImageAssetPath('assets/filter.png');
  grids.add(gridModel);

  gridModel = new GridModel();
  gridModel.setImageAssetPath('assets/fusion.png');
  grids.add(gridModel);

  gridModel = new GridModel();
  gridModel.setImageAssetPath('assets/bgEdit.png');
  grids.add(gridModel);

  gridModel = new GridModel();
  gridModel.setImageAssetPath('assets/ascii.png');
  grids.add(gridModel);

  return grids;
}
