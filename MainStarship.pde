class MainStarship extends Starship{
  public MainStarship(int health, int shield){
    super(health, shield);
    println("Main Starship");
  }
  
  @Override
  public void shot(){
  }
}
