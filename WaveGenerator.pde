  public class WaveGenerator{
  
  private int OFFSET_X = -10;
  private int OFFSET_Y = 10;
  private float maxX, maxY;
  private int enemyCount; 
  
  public WaveGenerator(int maxX, int maxY) {
    this.maxX = (float) maxX;
    this.maxY = (float) maxY;
  }
  
  public List<Starship> Generator(int enemyCount){
      return Generator(int(random(1, 4)), enemyCount);
  }
  
  public List<Starship> Generator(int type, int enemyCount){
    List<Starship> enemies = new ArrayList<>();
    switch (type) {
      //sin
      //case 1: 
      //for(float i = OFFSET_X; i > (maxX + OFFSET_X); i = i + (maxX + OFFSET_X)/enemyCount){
      //  enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD,(float) i, (float) (Math.sin(i)*((maxY-OFFSET_Y)/maxY)*maxY/2 + maxY/2), 800));        
      //}
      //break;

      //ellipse
      case 1: 
      for(float i = 0; i < 2*Math.PI; i = (float) (i + 2*Math.PI/enemyCount)){
        enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, (float) Math.cos(i)*((maxX-OFFSET_X)/maxX)*maxX/2 + maxX/2, (float) (Math.sin(i)*((maxY-OFFSET_Y)/maxY)*maxY/2) + maxY/2, 800));        
      }
      break;
      
      //astroid
      case 2: 
      for(float i = 0; i < 2*Math.PI; i = (float) (i + 2*Math.PI/enemyCount)){
        enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, (float) ((Math.pow(Math.sin(i),3))*((maxX-OFFSET_X)/maxX)*maxX/2 + maxX/2), (float) (Math.pow(Math.cos(i),3))*((maxY-OFFSET_Y)/maxY)*maxY/2 + maxY/2, 800));
      }
      break;
      
      //hypocycloid
      case 3: 
      for(float i = 0; i < 2*Math.PI; i = (float) (i + 2*Math.PI/enemyCount)){
        enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, (float) ((Math.cos(i)+Math.cos(i*5)/5)*0.8*((maxX-OFFSET_X)/maxX)*maxX/2 + maxX/2), (float) (Math.sin(i)+Math.sin(i*5)/5)*0.8*((maxY-OFFSET_Y)/maxY)*maxY/2 + maxY/2, 800));
      }
      break;
 
      //lissajous curve
      case 4: 
      for(float i = 0; i < 2*Math.PI; i = (float) (i + 2*Math.PI/enemyCount)){
        enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, (float) ((Math.sin(3*i + Math.PI/2))*((maxX-OFFSET_X)/maxX)*maxX/2 + maxX/2), (float) (Math.sin(2*i))*((maxY-OFFSET_Y)/maxY)*maxY/2 + maxY/2, 800));
      }
      break;
    }

  return enemies;
  }
  
}
