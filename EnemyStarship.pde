float ENEMY_MODEL_SCALE = 0.8f;
float ENEMY_COLLISION_R = 4 * AXIS_SCALE / 2;

float ENEMY_BULLET_SPEED_X = 0;
float ENEMY_BULLET_SPEED_Y = 0;
float ENEMY_BULLET_SPEED_Z = - 50.0f;
float ENEMY_BULLET_RADIUS = 5.0f;
int ENEMY_BULLET_LIFE_TIME = 300;
int ENEMY_DAMAGE = 10;


class EnemyStarship extends Starship{  
  private int healthTiming = 0;
  private int shieldTiming = 0;
  
  public EnemyStarship(int health, int shield){
    super(health, shield);

    this.setModel(ENEMY_STARSHIP_LOD0_MODEL, ENEMY_STARSHIP_LOD1_MODEL, ENEMY_STARSHIP_LOD2_MODEL, ENEMY_STARSHIP_LOD3_MODEL);
    this.setCollisionR(ENEMY_COLLISION_R);
  }

  public EnemyStarship(int health, int shield, float posX, float posY, float posZ){
    super(health, shield);
    
    this.setModel(ENEMY_STARSHIP_LOD0_MODEL, ENEMY_STARSHIP_LOD1_MODEL, ENEMY_STARSHIP_LOD2_MODEL, ENEMY_STARSHIP_LOD3_MODEL);
    this.setCollisionR(ENEMY_COLLISION_R);
  
    this.setPosX(posX);
    this.setPosY(posY);
    this.setPosZ(posZ);
  }
  
  @Override
  public boolean setDamage(int damage){
    if(getShield() < damage && getShield() > 0){
      setShield(0);
      shieldTiming = 5;
    } else if(getShield() == 0){
      if(getHealth() <= damage){
        return true;
      } else{
        setHealth(getHealth() - damage);
        healthTiming = 5;
      }
    } else{
      setShield(getShield() - damage);
      shieldTiming = 5;
    }
    return false;
  }
  
  @Override
  public Bullet shot(){

    return new Bullet(this.getPosX(), this.getPosY(), this.getPosZ() - ENEMY_COLLISION_R - 10,
                      ENEMY_BULLET_SPEED_X, ENEMY_BULLET_SPEED_Y, ENEMY_BULLET_SPEED_Z,
                      ENEMY_BULLET_RADIUS, ENEMY_BULLET_LIFE_TIME, ENEMY_DAMAGE, ENEMY_BULLET_COLOR);
  }
  
  @Override
  public boolean display(float camX, float camY, float camZ, float camDirX, float camDirY, float camDirZ){
    if(!super.display(camX, camY, camZ, camDirX, camDirY, camDirZ) ) return false;
    pushMatrix();
    translate(getPosX(), getPosY(), getPosZ());
    rotateZ(PI);
    rotateY(PI/2);
    if( healthTiming > 0 ){
      hint(DISABLE_DEPTH_TEST);
      shape(HEALTH_DAMAGE_MODEL);  
      hint(ENABLE_DEPTH_TEST);
      healthTiming--;
    }
    if( shieldTiming > 0 ){
      hint(DISABLE_DEPTH_TEST);
      shape(SHIELD_DAMAGE_MODEL);
      hint(ENABLE_DEPTH_TEST);
      shieldTiming--;
    }
    popMatrix();
    return true;
  }
  
}
