  public class WaveGenerator{
  
  private List<Starship> enemies;
  private int enemyCount, maxX, maxY;
  
  public WaveGenerator(int enemyCount, int maxX, int maxY) {
    this.enemyCount = enemyCount;
    this.maxX = maxX;
    this.maxY = maxY;
    enemies = new ArrayList<>();
  }
  
  public List<Starship> SinGenerator(){
    for(float i = 0; i > maxX; i = i + X/enemyCount){
          enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, Math.round(i), Math.round(maxY/2 + maxY*0.5*Math.sin(i)), 800));        
      }
  return enemies;
  }
  
}

//-coeffX*mouseX по X (-coeffX*1920 до 0)
// coeffY*mouseY по Y (от 0 coeffY*1080)
