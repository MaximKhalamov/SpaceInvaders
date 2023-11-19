float PLAYER_MODEL_SCALE = 0.4f;
float PLAYER_COLLISION_R = AXIS_SCALE / 2;

float PLAYER_BULLET_SPEED_X = 0;
float PLAYER_BULLET_SPEED_Y = 0;
float PLAYER_BULLET_SPEED_Z = 20.0f;
float PLAYER_BULLET_RADIUS = 5.0f;
int PLAYER_BULLET_LIFE_TIME = 300;

class MainStarship extends Starship{
  //private int recharge = 50;

  public MainStarship(int health, int shield){
    super(health, shield);
    println("Main Starship");
    
    this.setModel(PLAYER_STARSHIP_MODEL, PLAYER_STARSHIP_MODEL, PLAYER_STARSHIP_MODEL, PLAYER_STARSHIP_MODEL);
    this.setCollisionR(PLAYER_COLLISION_R);
  }
  
  @Override
  public Bullet shot(){
        return new Bullet(this.getPosX(), this.getPosY(), this.getPosZ() + AXIS_SCALE,
                      PLAYER_BULLET_SPEED_X, PLAYER_BULLET_SPEED_Y, PLAYER_BULLET_SPEED_Z,
                      PLAYER_BULLET_RADIUS, PLAYER_BULLET_LIFE_TIME);
  }
}
