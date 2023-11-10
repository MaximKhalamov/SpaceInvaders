class ActionField{
  private MainStarship mainStarship;
  private List<Starship> enemies;
  private List<Bullet> bullets;
  
  // TEMP CODE
  private PShape playerModel = loadShape(PLANET_MODEL_PATH);
  private PImage crosshair = loadImage(CROSSHAIR_IMG_PATH);
  
  
  float camInitX = -210, camInitY = 0, camInitZ = 80;
  float easing = 0.05;

  private BackgroundCamera cam = new BackgroundCamera(camInitX, camInitY, camInitZ,
                                                      camInitX + 0.1, camInitY, camInitZ, 
                                                      0, 0, -1);

  
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
    
    cam.setY(lerp(cam.getY(), coeffX*mouseX, easing));
    cam.setZ(lerp(cam.getZ(), -coeffY*mouseY, easing));
    
    pushMatrix();
    translate(cam.getX() - camInitX, cam.getY() - camInitY, cam.getZ() - camInitZ); 
    fill(255);
    rotateX(-PI/2);
    rotateZ(PI);
    shape(playerModel);
    popMatrix();
    
    pushMatrix();
    translate(cam.getX() - camInitX + 400, cam.getY() - camInitY - 50, cam.getZ() - camInitZ + 100); 
    rotateY(PI/2);
    hint(DISABLE_DEPTH_TEST);
    image(crosshair, 0, 0);
    //text("X", 400, 50, 0 );
    //text("X", 400, 25, 0 );
    //text("X", 400, - 50, 0 );
    //text("X", 400, - 25, 0 );
    //text("XXXXX", 400, 0, 0);
    hint(ENABLE_DEPTH_TEST);
    popMatrix();
  
    camera(cam.getX(), cam.getY(), cam.getZ(), cam.getX() + 0.1, cam.getY(), cam.getZ(), 0, 0, -1);
  }
}
