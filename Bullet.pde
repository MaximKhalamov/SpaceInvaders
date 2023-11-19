class Bullet extends GameObject{
  private int damage;
  private int lifeTime; // current living time
  private int maxLifeTime; // after this time the bullet disappears
  
  public Bullet(float x, float y, float z, float vx, float vy, float vz, float r, int maxLifeTime){
    super();
    this.setCollisionR(r);
    setPosX(x); setPosY(y); setPosZ(z);
    setVelX(vx); setVelY(vy); setVelZ(vz);
    this.maxLifeTime = maxLifeTime;
  }
  
  @Override
  public void frameMove(){
    super.frameMove();
    if(lifeTime >= maxLifeTime){
      println("Delete");
    }
    lifeTime++;
  }
  
  public int getDamage(){
    return damage;
  }
  
  public boolean isTimeOver(){
    return lifeTime >= maxLifeTime;
  }
}
