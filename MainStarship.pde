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
  
  public boolean display(float camX, float camY, float camZ, float camDirX, float camDirY, float camDirZ, float rotation){
   if( cos( getDotMult( getPosX() - camX, getPosY() - camY, getPosZ() - camZ, camDirX, camDirY, camDirZ) / 
                    //( getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 2 * (WIDTH / HEIGTH)  ) ) ){
                    //( getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 3 * ( (float)WIDTH / HEIGTH)  )  ) ){
                    ( getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 2 * ((float)WIDTH / HEIGTH)  )  ) ){
      return false;
    }
    float distance = getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ);
    pushMatrix();
    translate(getPosX(), getPosY(), getPosZ());
    rotateZ(PI);
    rotateY(PI/2);
    rotateX(rotation);
    if( distance < 100 ){
      shape(modelLOD0);    
    } else if ( distance >= 100 && distance < 300 ){
      shape(modelLOD1);
    } else if ( distance >= 300 && distance < 1000 ){
      shape(modelLOD2);
    } else {
      shape(modelLOD3);
    }
    popMatrix();
    return true;
  }
}
