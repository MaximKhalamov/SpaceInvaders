abstract class Starship extends GameObject{
  private int health;
  private int shield;
  
  protected PShape modelLOD3;
  protected PShape modelLOD2;
  protected PShape modelLOD1;
  protected PShape modelLOD0;
    
  public Starship(int health, int shield){
    this.health = health;
    this.shield = shield;
  }
  
  public boolean setDamage(int damage){
    if(shield < damage && shield > 0){
      shield = 0;
    } else if(shield == 0){
      if(health <= damage){
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

  public void setModel(PShape modelLOD0, PShape modelLOD1, PShape modelLOD2, PShape modelLOD3){
    this.modelLOD0 = modelLOD0;
    this.modelLOD1 = modelLOD1;
    this.modelLOD2 = modelLOD2;
    this.modelLOD3 = modelLOD3;
  }
  
  // cam    - is a camera vector. Where camera is
  // camDir - direction of camera view
  public boolean display(float camX, float camY, float camZ, float camDirX, float camDirY, float camDirZ){
    // DON'T RENDER OBECTS OUT OF SIGHT
    if( isObjectOnScreen(getPosX(), getPosY(), getPosZ(), camX, camY, camZ, camDirX, camDirY, camDirZ) ){
      return false;
    }
    float distance = getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ);
    pushMatrix();
    translate(getPosX(), getPosY(), getPosZ());
    rotateZ(PI);
    rotateY(PI/2);
    if( distance < LOD1_DISTANCE ){
      shape(modelLOD0);    
    } else if ( distance >= LOD1_DISTANCE && distance < LOD2_DISTANCE ){
      shape(modelLOD1);
    } else if ( distance >= LOD2_DISTANCE && distance < LOD3_DISTANCE ){
      shape(modelLOD2);
    } else {
      shape(modelLOD3);
    }
    popMatrix();
    return true;
  }
  
  abstract public Bullet shot();
}
