float currentRadius = 200.0f;

class Planet{  
  private float x, y;
  private int enemyNumber;
  private boolean hasBoss;
  
  public Planet(int enemyNumber, boolean hasBoss){
    float randomAngle = random(-PI, PI);
    x = currentRadius * cos(randomAngle);
    y = currentRadius * sin(randomAngle);

    this.hasBoss = hasBoss;
    this.enemyNumber = enemyNumber;
    
    currentRadius *= 1.5f;
  }
  
  public int getEnemyNumber(){
    return enemyNumber;
  }
}
