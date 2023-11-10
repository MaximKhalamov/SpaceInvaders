class ActionField{
  private MainStarship mainStarship;
  private List<Starship> enemies;
  private List<Bullet> bullets;
  
  public ActionField(){
    
  }
  
  public void gameOver(){
    println("Game over!");
    println("Try again");
  }
  
  public void clear(){
    //mainStarship = null;
    enemies.clear();
  }
  
  public void create(int numberOfEnemies){
    mainStarship = new MainStarship(PLAYER_HEALTH, PLAYER_SHIELD);
    
  }
  
  public void calculateActions(){
    ////Enemy collision check
    //Iterator<Starship> enemyIterator = enemies.iterator();
    //while(enemyIterator.hasNext()){
    //  Iterator<Bullet> bulletIterator = bullets.iterator();
    //  while(bulletIterator.hasNext()){
    //    Bullet bullet = bulletIterator.next();
    //    Starship enemy = enemyIterator.next();
    //    if(bullet.isTimeOver()){
    //      bulletIterator.remove();
    //    }else if(bullet.checkCollision(enemy)){
    //      bulletIterator.remove();
    //      if(enemy.setDamage( bullet.getDamage() )){
    //        enemyIterator.remove();
    //      };
          
    //      break;      
    //    }    
    //  }
    //  //enemy.move();                                      // HERE I NEED TO MOVE ENEMY'S STARSHIP
    //}
    
    ////Player collision check
    //Iterator<Bullet> bulletIterator = bullets.iterator();
    //while(bulletIterator.hasNext()){
    //  Bullet bullet = bulletIterator.next();
    //  if(bullet.checkCollision(mainStarship)){
    //    bulletIterator.remove();
    //    if(mainStarship.setDamage( bullet.getDamage() )){
    //      this.gameOver();
    //    }    
    //  }
    //}
    //mainStarship.move(direction);
  }
}
