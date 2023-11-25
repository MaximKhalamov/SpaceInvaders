class Bullet extends GameObject{
  private int damage;
  private int lifeTime; // current living time
  private int maxLifeTime; // after this time the bullet disappears
  private color bulletColor;
  
  public Bullet(float x, float y, float z, float vx, float vy, float vz, float r, int maxLifeTime, int damage, color bulletColor){
    super();
    this.setCollisionR(r);
    setPosX(x); setPosY(y); setPosZ(z);
    setVelX(vx); setVelY(vy); setVelZ(vz);
    this.maxLifeTime = maxLifeTime;
    this.damage = damage;
    this.bulletColor = bulletColor;
  }
  
  @Override
  public void frameMove(){
    super.frameMove();
    if(lifeTime >= maxLifeTime){
      //println("Delete");
    }
    lifeTime++;
  }
  
  public int getDamage(){
    return damage;
  }
  
  public boolean isTimeOver(){
    return lifeTime >= maxLifeTime;
  }
  
  public void display(float camX, float camY, float camZ, float camDirX, float camDirY, float camDirZ){
    if( isObjectOnScreen(getPosX(), getPosY(), getPosZ(), camX, camY, camZ, camDirX, camDirY, camDirZ) ){
      return;
    }
    pushMatrix();
    noStroke();
    translate(getPosX(), getPosY(), getPosZ());
    fill(bulletColor);
    box(4, 4, 60);
    hint(DISABLE_DEPTH_TEST);
    fill(255);
    box(3, 3, 45);
    hint(ENABLE_DEPTH_TEST);
    
    popMatrix();
  }
}
