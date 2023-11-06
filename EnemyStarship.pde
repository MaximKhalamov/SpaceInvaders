class EnemyStarship extends Starship{
  public EnemyStarship(int health, int shield){
    super(health, shield);
    println("Main Starship");
  }
  
  @Override
  public void shot(){
  }
}
