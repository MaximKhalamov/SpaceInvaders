class Background{
  private float centerX = 0.0f;
  private float centerY = 0.0f;
  private float centerZ = 0.0f;
  private BackgroundCamera bgCamera;
  private List<Planet> planets;
  
  private PShape skyBoxModel;
  private PImage skyBoxTexture;
  private float skyBoxSize = 5000.0f;

  private PShape starModel;
  private PImage starTexture;

  public Background(List<Planet> planets){
    skyBoxModel = loadShape(SKYBOX_MODEL_PATH);
    skyBoxTexture = loadImage(SKYBOX_TEXTURE_PATH);
    skyBoxModel.setTexture(skyBoxTexture);

    skyBoxModel.scale(skyBoxSize);
    //starModel = loadShape(SKYBOX_MODEL_PATH);
    //starTexture = loadImage(SKYBOX_TEXTURE_PATH);
    //starModel.setTexture(starTexture);
    
    bgCamera = new BackgroundCamera();
  }
  
  public void drawBG(){
    background(5);
    pushMatrix();
    translate(-skyBoxSize / 2, -skyBoxSize / 2, -skyBoxSize / 2);
    shape(skyBoxModel);
    
    //for(Planet planet: planets){
    //  planet.drawPlanet();
    //}
      camera(0.1, 0, 0, 0, 0, 0, 0, 0, 1);

    //camera( bgCamera.getX(), bgCamera.getY(), bgCamera.getZ(),
    //        bgCamera.getCX(), bgCamera.getCY(), bgCamera.getCZ(),
    //        bgCamera.getUX(), bgCamera.getUY(), bgCamera.getUZ()
    //);  
      popMatrix();

  }
}
