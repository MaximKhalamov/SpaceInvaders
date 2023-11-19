abstract class GameObject{
  private float x, y, z;
  private float vx, vy, vz; // velocity to the x, y directions
  private float radius; // radius of the object is just for collision

  public void setPosX(float value){
    x = value;
  }

  public void setPosY(float value){
    y = value;
  }

  public void setPosZ(float value){
    z = value;
  }

  public void setVelX(float value){
    vx = value;
  }

  public void setVelY(float value){
    vy = value;
  }

  public void setVelZ(float value){
    vz = value;
  }

  public void setCollisionR(float value){
    radius = value;
  }

  public float getPosX(){
    return x;
  }

  public float getPosY(){
    return y;
  }

  public float getPosZ(){
    return z;
  }

  public float getVelX(){
    return vx;
  }

  public float getVelY(){
    return vy;
  }

  public float getVelZ(){
    return vz;
  }

  public float getCollisionR(){
    return radius;
  }
  
  public boolean checkCollision(GameObject go){
    float lx = go.x - this.x;
    float ly = go.y - this.y;
    float lz = go.z - this.z;
    boolean isRegistered = sqrt( lx * lx + ly * ly + lz * lz ) < (this.radius + go.radius);
    if(isRegistered){
      println("REGISTERED COLLISION!");
    }
    return isRegistered; 
  }

  public void frameMove(){
    x += vx;
    y += vy;
    z += vz;
  }
    
}
