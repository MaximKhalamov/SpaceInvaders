abstract class Starship{
  private int health;
  private int shield;
  private float x, y;
  
  public Starship(int health, int shield){
    println("Starship!");
    this.health = health;
    this.shield = shield;
  }
  
  public float getPosX(){
    return x;
  }

  public float getPosY(){
    return y;
  }
  
  public void getDamage(int damage){
    if(shield < damage && shield != 0){
      shield = 0;
    } else if(shield == 0){
      if(health < damage){
        println("DEAD");
      } else{
        health -= damage;
      }
    }
  }
  
  public int getShield(){
    return shield;
  }
  
  public int getHealth(){
    return health;
  }
  
  abstract public void shot();
}
