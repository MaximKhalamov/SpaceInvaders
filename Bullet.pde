class Bullet{
  private float x, y;
  private float vx, vy; // velocity to the x, y directions
  private float radius; // radius is just for collision
  private int lifeTime; // current living time
  private int maxLifeTime; // after this time the bullet disappears
  
  public Bullet(){
    radius = sqrt(x * x + y * y);
  }
  
  public boolean checkCollision(Starship starship){
    return dist(starship.getPosX(), starship.getPosY(), x, y) < radius;
  }
  
  public void fly(){
    if(lifeTime == maxLifeTime){
      println("Delete");
    }
    lifeTime++;
  }
}
