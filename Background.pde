class Background{
  private float centerX = 0.0f;
  private float centerY = 0.0f;
  private float centerZ = 0.0f;
  private BackgroundCamera bgCamera;
  private List<Planet> planets;
  
  private PShape skyBoxModel;
  private PImage skyBoxTexture;
  private float skyBoxSize = 16000f;

  private PShape starModel;
  private PImage starTexture;

  public Background(List<Planet> planets){
    this.planets = planets;
    
    skyBoxModel = loadShape(SKYBOX_MODEL_PATH);
    skyBoxTexture = loadImage(SKYBOX_TEXTURE_PATH);
    skyBoxModel.setTexture(skyBoxTexture);
    skyBoxModel.scale(skyBoxSize);
    
    starModel = loadShape(PLANET_MODEL_PATH);
    starTexture = loadImage(STAR_TEXTURE_PATH);
    starModel.setTexture(starTexture);
    starModel.scale(STAR_SIZE);
    
    bgCamera = new BackgroundCamera(0, 0, 1300, 0, 0, 0, 0, 1, 0);
  }
  
  public void drawBG(){
    //background(0);
    noLights();
    
    pushMatrix();
    translate(-skyBoxSize / 2, -skyBoxSize / 2, -skyBoxSize / 2);
    shape(skyBoxModel);
    popMatrix();
    
    //pushMatrix();
    //rotateX(-PI/2);
    ////rotateY(millis() / 2000);
    //shape(starModel);
    //popMatrix();

    //for(Planet planet: planets){
    //  planet.drawPlanet();
    //}
    
    ////bgCamera.moveRel(0, 0, -3);
    
    ////camera( bgCamera.getX(), bgCamera.getY(), bgCamera.getZ(),
    //        //bgCamera.getCX(), bgCamera.getCY(), bgCamera.getCZ(),
    //        //bgCamera.getUX(), bgCamera.getUY(), bgCamera.getUZ()
    ////);  

  }
  
  public void moveToPlanet(int number){
    
  }
}
