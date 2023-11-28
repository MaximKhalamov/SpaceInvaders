float INIT_RADIUS = 300f;
float currentRadius = INIT_RADIUS;

class Planet{  
  private float x, y, r;
  private int enemyNumber;
  private boolean hasBoss;
  private PShape model;
  private PImage texture;
  private float planetSize;
  private float prevAngle = 0;
  
  public Planet(int enemyNumber, boolean hasBoss, float planetSize){
    float randomAngle = random(- PI / 3 + prevAngle, PI / 3 + prevAngle);
    prevAngle = randomAngle;
    x = currentRadius * cos(randomAngle);
    y = currentRadius * sin(randomAngle);

    this.hasBoss = hasBoss;
    this.enemyNumber = enemyNumber;
    this.planetSize = planetSize;
    r = currentRadius;
    currentRadius *= 1.5f;
  
    
    model = loadShape(PLANET_MODEL_PATH);
        
    texture = loadImage(getRandomTexture());
    if(model == null){
      println("Model not found");
    }

    if(texture == null){
      println("Texture not found");
    }
    model.setTexture(texture);
    //TODO: load random planet UV-texture with random color
    
    model.scale(planetSize);
  }
  
  private String getRandomTexture(){
    File directory = new File(RELATIVE_PATH + PLANET_TEXTURE_PATHS);
    //File directory = new File(PLANET_TEXTURE_PATHS);
    
    if (!directory.isDirectory()) {
      System.out.println(directory.getAbsolutePath());
      System.err.println("Specified path is not a directory.");
      return null;
    }

    File[] files = directory.listFiles();

    if (files == null || files.length == 0) {
        System.err.println("No files found in the directory.");
        return null;
    }

    Random random = new Random();
    int randomIndex = random.nextInt(files.length);

    return files[randomIndex].getAbsolutePath();
  }
  
  public float getX(){
    return x;
  }

  public float getY(){
    return y;
  }

  public void drawPlanet(){    
    pushMatrix();
    translate(x, y);
    rotateX(PI/2);
    //sphere(planetSize);
    shape(model);
    popMatrix();
  }
  
  public int getEnemyNumber(){
    return enemyNumber;
  }  
}
