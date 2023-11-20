class StarDrawer{
  private int starNumber = 1500;

  float[] starX = new float[starNumber];
  float[] starY = new float[starNumber];
  float[] starZ = new float[starNumber];
  float[] starPZ = new float[starNumber];

  float speed = 40;

  public StarDrawer(){
    for (int i = 0; i < starNumber; i++) {
      starX[i] = random(-width, width);
      starY[i] = random(-height, height);
      starZ[i] = random(width);
      starPZ[i] = starZ[i];
    }
  }
  
  void update(){
    for(int i = 0; i < starNumber; i++){
      starZ[i] = starZ[i] - speed;
      if(starZ[i] < 1){
        starZ[i] = random(width);
        starX[i] = random(-width, width);
        starY[i] = random(-height, height);
        starPZ[i] = starZ[i];
      }
    }
  }
  
  void show(){
    fill(255);
    stroke(255);
  
    for(int i = 0; i < starNumber; i++){
      float sx = map(starX[i] / starZ[i], 0, 1, 0, width);
      float sy = map(starY[i] / starZ[i], 0, 1, 0, height);
  
      float r = map(starZ[i], 0, width, 4, 0);
      //ellipse(sx, sy, r, r);
  
      float px = map(starX[i] / starPZ[i], 0, 1, 0, width);
      float py = map(starY[i] / starPZ[i], 0, 1, 0, height);
      
      starPZ[i] = starZ[i];
      
      strokeWeight(r);
      line(px, py, 0, sx, sy, 0);
    }
  }
}

class ActionField{
  private MainStarship mainStarship;
  private List<Starship> enemies;
  private List<Bullet> bullets;
  private List<Planet> planets;

  private int timing = 50;

  private boolean isLevelStarted = true;
  private boolean isLevelFailed = false;

  private int currentLevel = 0;

  private PShape skyBoxModel;
  private PImage skyBoxTexture;
  private float skyBoxSize = 17000f;
  private float playerCoords = 0;
  
  private PImage crosshair = loadImage(CROSSHAIR_IMG_PATH);
  float camInitX = 0, camInitY = -30, camInitZ = -60;
  float easing = 0.05;

  private StarDrawer sd;

  private BackgroundCamera cam = new BackgroundCamera(camInitX, camInitY, camInitZ,
                                                      camInitX, camInitY, camInitZ + 0.1,
                                                      0, 1, 0);

  public ActionField(List<Planet> planets){
    bullets = new ArrayList<>();
    skyBoxModel = loadShape(SKYBOX_MODEL_PATH);
    skyBoxTexture = loadImage(SKYBOX_TEXTURE_PATH);
    skyBoxModel.setTexture(skyBoxTexture);
    skyBoxModel.scale(skyBoxSize);

    mainStarship = new MainStarship(PLAYER_HEALTH, PLAYER_SHIELD);
  }

  public void gameOver(){
    println("Game over!");
    println("Try again");
  }

  private void displayAxis(float x, float y, float z){
    pushMatrix();

      //X  - red
      stroke(192,0,0);
      line(x, y, z, x + AXIS_SCALE * 1000, y, z);
      text("X", x + AXIS_SCALE * 1000, y, z);

      //Y - green
      stroke(0,192,0);
      line(x, y, z, x, y + AXIS_SCALE * 1000, z);
      text("Y", x, y + AXIS_SCALE * 1000, z);

      //Z - blue
      stroke(0,0,192);
      line(x, y, z, x, y, z + AXIS_SCALE * 1000);
      text("Z", x, y, z + AXIS_SCALE * 1000);
    popMatrix();  
  }

  public void drawStarfield(){
  
  }

  public void calculateActions(){
    if(isLevelStarted){
      //place all enemy ships here
      //int enemyNumber = planets.get(currentLevel).getEnemyNumber();
      
      // HERE WE NEED TO PLACE GENERATION FUNCTION
      //enemies = generateEnemies(enemyNumber);
      
      //TEMPORERY CODE
      enemies = new ArrayList<>();
      enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, -40, 40, 500));
      enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, -140, 140, 500));
      enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, -240, 240, 500));
      enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, -340, 340, 500));
      enemies.add(new EnemyStarship(ENEMY_LIGHT_HEALTH, ENEMY_LIGHT_SHIELD, -440, 440, 500));
      
      sd = new StarDrawer();
      
    for(Starship ss : enemies){
      ss.setVelZ(-1.0);
    }
      
      isLevelStarted = false;
    }

    if(enemies.isEmpty()){
      // VICTORY!
      println("VICTORY");
    }

    if(isLevelFailed){
      // FAIL!
      println("FAIL");
    }

    ////Enemy collision check
    Iterator<Starship> enemyIterator = enemies.iterator();
    while(enemyIterator.hasNext()){
      if(!bullets.isEmpty()){
        //println("Check");
        Starship enemy = enemyIterator.next();
        Iterator<Bullet> bulletIterator = bullets.iterator();
          while(bulletIterator.hasNext()){
            Bullet bullet = bulletIterator.next();
            if(bullet.isTimeOver()){
              bulletIterator.remove();
              continue;
            }else if(bullet.checkCollision(enemy)){
              bulletIterator.remove();
              if(enemy.setDamage( bullet.getDamage() )){
                enemyIterator.remove();
              }; 
              break;      
            }
        }    
      } else {
        break;
      }
    }
    //  //enemy.move();                                      // HERE I NEED TO MOVE ENEMY'S STARSHIP
    //}
    
    ////Player collision check
    if(!bullets.isEmpty()){
      Iterator<Bullet> bulletIterator = bullets.iterator();
      while(bulletIterator.hasNext()){
        Bullet bullet = bulletIterator.next();
        if(bullet.checkCollision(mainStarship)){
          bulletIterator.remove();
          if(mainStarship.setDamage( bullet.getDamage() )){
            this.gameOver();
          }    
        }
      }
    }

    //for(Starship ss : enemies){
    //  ss.frameMove();
    //}

    for(Bullet bullet : bullets){
      bullet.frameMove();
      bullet.display();
    }
    
    noLights();

    int count = 0;
    //if(random(0, 100) < 2)
    for(Starship ss: enemies){
      if(ss.display(cam.getX(), cam.getY(), cam.getZ(), 0, 0, 1)){
        count++;
      }            
    }

    pushMatrix();
      translate(-skyBoxSize / 2, -skyBoxSize / 2, -skyBoxSize / 2);
      shape(skyBoxModel);
    popMatrix();

    float tx = cam.getX();
    float ty = cam.getY();

    cam.setX(lerp(cam.getX(), -coeffX*mouseX, easing));
    cam.setY(lerp(cam.getY(), coeffY*mouseY, easing));
    mainStarship.setPosX(cam.getX() - camInitX);
    mainStarship.setPosY(cam.getY() - camInitY);
    mainStarship.setPosZ(cam.getZ() - camInitZ);
    mainStarship.display(cam.getX(), cam.getY(), cam.getZ(), 0, 0, 1);

    //displayAxis(cam.getX() - camInitX, cam.getY() - camInitY, cam.getZ() - camInitZ);
    
    timing--;
    if(mousePressed && (mouseButton == LEFT)){
      if( timing < 0 ){
          bullets.add(mainStarship.shot());
        timing = 20;    
      }
    }

    pushMatrix();
    //translate(cam.getX(), cam.getY(), -cam.getZ());
    translate(tx, ty, -cam.getZ());
    sd.update();
    sd.show();
    popMatrix();

    pushMatrix();
    translate(cam.getX() - camInitX - 100, cam.getY() - camInitY - 100, cam.getZ() - camInitZ + 600); 
    scale(2);
    hint(DISABLE_DEPTH_TEST);
    image(crosshair, 0, 0);
    hint(ENABLE_DEPTH_TEST);
    popMatrix();

    perspective(FOV, float(width)/float(height), 1, 200000);
    camera(cam.getX(), cam.getY(), cam.getZ(), cam.getX(), cam.getY(), cam.getZ() + 0.1, 0, 1, 0);
  }
}
