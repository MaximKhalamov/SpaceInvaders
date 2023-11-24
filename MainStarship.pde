float PLAYER_MODEL_SCALE = 0.4f;
float PLAYER_COLLISION_R = 2 * AXIS_SCALE / 2;

float PLAYER_BULLET_SPEED_X = 0;
float PLAYER_BULLET_SPEED_Y = 0;
float PLAYER_BULLET_SPEED_Z = 30.0f;
float PLAYER_BULLET_RADIUS = 5.0f;
int PLAYER_BULLET_LIFE_TIME = 300;
int PLAYER_DAMAGE = 20;

class MainStarship extends Starship{
  //private int recharge = 50;

  public MainStarship(int health, int shield){
    super(health, shield);
    
    this.setModel(PLAYER_STARSHIP_MODEL, PLAYER_STARSHIP_MODEL, PLAYER_STARSHIP_MODEL, PLAYER_STARSHIP_MODEL);
    this.setCollisionR(PLAYER_COLLISION_R);
  }
  
  @Override
  public Bullet shot(){
        return new Bullet(this.getPosX(), this.getPosY(), this.getPosZ() + 2.1 * AXIS_SCALE,
                      PLAYER_BULLET_SPEED_X, PLAYER_BULLET_SPEED_Y, PLAYER_BULLET_SPEED_Z,
                      PLAYER_BULLET_RADIUS, PLAYER_BULLET_LIFE_TIME, PLAYER_DAMAGE, PLAYER_BULLET_COLOR);
  }
}
