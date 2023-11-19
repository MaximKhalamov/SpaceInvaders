abstract class Starship extends GameObject{
  private int health;
  private int shield;
  
  private PShape modelUULDM; // Ultra ultra low detail mod
  private PShape modelULDM;  // Ultra LDM
  private PShape modelLDM;
  private PShape model;
    
  public Starship(int health, int shield){
    this.health = health;
    this.shield = shield;
  }
  
  public boolean setDamage(int damage){
    if(shield < damage && shield != 0){
      shield = 0;
    } else if(shield == 0){
      if(health < damage){
        return true;
      } else{
        health -= damage;
      }
    }
    return false;
  }
  
  public int getShield(){
    return shield;
  }
  
  public int getHealth(){
    return health;
  }
  
  //public void setModel(PShape model){
  //  this.model = model;
  //}

  public void setModel(PShape model, PShape modelLDM, PShape modelULDM, PShape modelUULDM){
    this.model = model;
    this.modelLDM = modelLDM;
    this.modelULDM = modelULDM;
    this.modelUULDM = modelUULDM;
  }
  
  // cam    - is a camera vector. Where camera is
  // camDir - direction of camera view
  public boolean display(float camX, float camY, float camZ, float camDirX, float camDirY, float camDirZ){
    // DON'T RENDER OBECTS OUT OF SIGHT
    if( cos( getDotMult( getPosX() - camX, getPosY() - camY, getPosZ() - camZ, camDirX, camDirY, camDirZ) / 
                    //( getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 2 * (WIDTH / HEIGTH)  ) ) ){
                    ( getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 2 * ((float)WIDTH / HEIGTH)  )  ) ){
      return false;
    }
    pushMatrix();
    translate(getPosX(), getPosY(), getPosZ());
    rotateZ(PI);
    rotateY(PI/2);
    shape(model);
    popMatrix();
    return true;
  }
  
  abstract public Bullet shot();
}
