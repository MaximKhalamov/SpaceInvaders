class ActionField{
  private MainStarship mainStarship;
  private List<Starship> enemies;
  
  public ActionField(){
    
  }
  
  public void clear(){
    mainStarship = null;
    enemies.clear();
  }
  
  public void create(int numberOfEnemies){
    mainStarship = new MainStarship(PLAYER_HEALTH, PLAYER_SHIELD);
  }
}
