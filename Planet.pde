float currentRadius = 200.0f;

class Planet{  
  private float x, y, r;
  private int enemyNumber;
  private boolean hasBoss;
  private PShape model;
  private PImage texture;
  private float planetSize;
  
  public Planet(int enemyNumber, boolean hasBoss, float planetSize){
    float randomAngle = random(-PI, PI);
    x = currentRadius * cos(randomAngle);
    y = currentRadius * sin(randomAngle);

    this.hasBoss = hasBoss;
    this.enemyNumber = enemyNumber;
    this.planetSize = planetSize;
    r = currentRadius;
    currentRadius *= 1.5f;
  
    
    model = loadShape(PLANET_MODEL_PATH);
    texture = loadImage(PLANET_TEXTURE_PATH);
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
  
  public float getX(){
    return x;
  }

  public float getY(){
    return y;
  }
  
  public void drawPlanet(){
    //    float randomAngle = random(-PI, PI);
    //x = r * cos(randomAngle);
    //y = r * sin(randomAngle);
    
    pushMatrix();
    translate(x, y);
    shape(model);
    popMatrix();
  }
  
  public int getEnemyNumber(){
    return enemyNumber;
  }  
}
