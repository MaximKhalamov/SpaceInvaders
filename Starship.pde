abstract class Starship extends GameObject{
  private int health;
  private int shield;
  
  private float boundX;
  
  public Starship(int health, int shield){
    println("Starship!");
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
  
  public void fixBounds(){
    if(getPosX() < LBOUND){
      setPosX(LBOUND);
    }
    if(getPosX() > RBOUND){
      setPosX(RBOUND);
    }
  }
  
  abstract public void shot();
}
