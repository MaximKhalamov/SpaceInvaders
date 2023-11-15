class EnemyStarship extends Starship{
  public EnemyStarship(int health, int shield){
    super(health, shield);
    println("Enemy Starship");
  }
  
  @Override
  public void shot(){
  }
}
