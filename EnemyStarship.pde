float ENEMY_MODEL_SCALE = 0.5f;
float ENEMY_COLLISION_R = AXIS_SCALE / 2;

float ENEMY_BULLET_SPEED_X = 0;
float ENEMY_BULLET_SPEED_Y = 0;
float ENEMY_BULLET_SPEED_Z = - 20.0f;
float ENEMY_BULLET_RADIUS = 5.0f;
int ENEMY_BULLET_LIFE_TIME = 3000;



class EnemyStarship extends Starship{  
  public EnemyStarship(int health, int shield){
    super(health, shield);
    println("Enemy Starship");

    this.setModel(ENEMY_STARSHIP_MODEL, ENEMY_STARSHIP_MODEL, ENEMY_STARSHIP_MODEL, ENEMY_STARSHIP_MODEL);
    this.setCollisionR(ENEMY_COLLISION_R);
  }

  public EnemyStarship(int health, int shield, float posX, float posY, float posZ){
    super(health, shield);
    println("Enemy Starship");

    this.setModel(ENEMY_STARSHIP_MODEL, ENEMY_STARSHIP_MODEL, ENEMY_STARSHIP_MODEL, ENEMY_STARSHIP_MODEL);
    this.setCollisionR(ENEMY_COLLISION_R);
  
    this.setPosX(posX);
    this.setPosY(posY);
    this.setPosZ(posZ);
  }
  
  @Override
  public Bullet shot(){

    return new Bullet(this.getPosX(), this.getPosY(), this.getPosZ() - AXIS_SCALE,
                      ENEMY_BULLET_SPEED_X, ENEMY_BULLET_SPEED_Y, ENEMY_BULLET_SPEED_Z,
                      ENEMY_BULLET_RADIUS, ENEMY_BULLET_LIFE_TIME);
  }
}
