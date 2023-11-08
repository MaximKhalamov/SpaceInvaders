abstract class GameObject{
  private float x, y;
  private float vx, vy; // velocity to the x, y directions
  private float radius; // radius of the object is just for collision

  public void setPosX(float value){
    x = value;
  }

  public void setPosY(float value){
    y = value;
  }

  public void setVelX(float value){
    vx = value;
  }

  public void setVelY(float value){
    vy = value;
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

  public float getVelX(){
    return vx;
  }

  public float getVelY(){
    return vy;
  }

  public float getCollisionR(){
    return radius;
  }
  
  public boolean checkCollision(GameObject gameObject){
    return dist(this.getPosX(), this.getPosY(), gameObject.getPosX(), gameObject.getPosY()) < radius;
  }
}
