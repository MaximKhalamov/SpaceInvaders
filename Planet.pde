float currentRadius = 200.0f;

class Planet{  
  private float x, y;
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
    currentRadius *= 1.5f;
  
    //model = loadShape(PLANET_MODEL_PATH);
    
    //TODO: load random planet UV-texture with random color
    
    //model.scale(planetSize);
}
  
  public void drawPlanet(){
    pushMatrix();
    translate(x, y);
    shape(model);
    popMatrix();
  }
  
  public int getEnemyNumber(){
    return enemyNumber;
  }  
}
