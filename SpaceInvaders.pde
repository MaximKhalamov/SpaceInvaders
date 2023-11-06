import java.util.List;


// --------------------------------------- CUSTOMIZABLE ---------------------------------------
int NUMBER_OF_PLANETS =        4;     // Also number of levels
float MULTIPLIER_ENEMIES =     1.0f;  // Multiplier for the numbers of enemies
float MULTIPLIER_FIRE_RATE =   1.0f;
float MULTIPLIER_SPEED_ENEMY = 1.0f;
float MULTIPLIER_SPEED_PLAYER =  1.0f;
float FPS = 60.0f;

int PLAYER_HEALTH = 50;
int PLAYER_SHIELD = 0;

int ENEMY_LIGHT_HEALTH = 10;
int ENEMY_LIGHT_SHIELD = 0;

int ENEMY_MEDIUM_HEALTH = 30;
int ENEMY_MEDIUM_SHIELD = 10;

int ENEMY_HEAVY_HEALTH = 50;
int ENEMY_HEAVY_SHIELD = 30;

int ENEMY_BOSS_HEALTH = 100;
int ENEMY_BOSS_SHIELD = 60;
// --------------------------------------- END CUSTOMIZABLE ---------------------------------------

// --------------------------------------- FILE PATHS ---------------------------------------

String SKYBOX_TEXTURE_PATH = "assets/background/skybox.png";
String SKYBOX_MODEL_PATH = "assets/background/skybox.obj";

String PLAYER_TEXTURE_PATH = "assets/starship/.png";
String PLAYER_MODEL_PATH = "assets/starship/.obj";

String ENEMY_TEXTURE_PATH = "assets/starship/.png";
String ENEMY_MODEL_PATH = "assets/starship/.obj";

// --------------------------------------- END FILE PATHS ---------------------------------------

class Main{
  private ActionField actionField;
  private Background background;
  private BackgroundCamera bgCamera;
  private List<Planet> planets;

  private int playerShield;
  private int playerHealth;

  public Main(){
    background = new Background();
    
    playerHealth = PLAYER_HEALTH;
    playerShield = PLAYER_SHIELD;
    
    planets = new ArrayList<Planet>();
    for(int i = 0; i < NUMBER_OF_PLANETS; i++){
      int enemyNumber = (int)(MULTIPLIER_ENEMIES * (i + 1) * 10);
      println("Enemy number: " + enemyNumber);
      
      // The last planet always contain boss
      planets.add( new Planet(enemyNumber, i - 1 == NUMBER_OF_PLANETS ) );
    }
  }
  
  void drawBackground(){
  
  }

  void drawActionField(){
  
  }
}

Main main;

void setup(){
  size(800, 800, P3D);
  main = new Main();
  
  Thread gameThread = new Thread(new Runnable(){
    @Override
    
    // Here is the game actions
    public void run(){
      try{
        while(true){
          Thread.sleep( (long)(1000 / FPS) );
          
          }
        }catch(InterruptedException e){

        }
      }
  });
  
  gameThread.start();
  noLoop();
}



void draw(){
  if(keyPressed){
    if(key == 'a' || key == 'A'){
      print("a");
    }
    if(key == 'd' || key == 'D'){
      print("d");
    }
  }
  
  main.drawBackground();
  
  main.drawActionField();
  
  background(0);
}
