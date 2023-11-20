import java.util.List;
import java.util.Iterator;

// --------------------------------------- CUSTOMIZABLE ---------------------------------------
int NUMBER_OF_PLANETS =         4;     // Also number of levels
float MULTIPLIER_ENEMIES =      1.0f;  // Multiplier for the numbers of enemies
float MULTIPLIER_FIRE_RATE =    1.0f;
float MULTIPLIER_SPEED_ENEMY =  1.0f;
float MULTIPLIER_SPEED_PLAYER = 1.0f;
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

float HORIZONTAL_SPEED = 10.0f;
// --------------------------------------- END CUSTOMIZABLE ---------------------------------------

// --------------------------------------- BETTER DO NOT TOUCH ---------------------------------------
float PLANET_SIZE = 10.0f;
float STAR_SIZE = 50.0f;

int HEIGTH = 1080;
int WIDTH = 1920;

//float coeffX = 3;
//float coeffY = 3;

float coeffX = 1;
float coeffY = 1;

float FOV = PI / 2;

float AXIS_SCALE = 20.0f;

PShape PLAYER_STARSHIP_MODEL;

PShape ENEMY_STARSHIP_LOD0_MODEL;
PShape ENEMY_STARSHIP_LOD1_MODEL;
PShape ENEMY_STARSHIP_LOD2_MODEL;
PShape ENEMY_STARSHIP_LOD3_MODEL;

PShape PLAYER_BULLET_MODEL;
PShape ENEMY_BULLET_MODEL;

enum State{
  BACKGROUND,
  ACTIONFIELD,
  TRANSITION,
  MENU
}
// --------------------------------------- END BETTER DO NOT TOUCH ---------------------------------------

// --------------------------------------- FILE PATHS ---------------------------------------

String SKYBOX_TEXTURE_PATH = "assets/background/skybox.png";
String SKYBOX_MODEL_PATH = "assets/background/skybox.obj";

String STAR_TEXTURE_PATH = "assets/starSystem/star2.jpg";
String PLANET_TEXTURE_PATH = "assets/starSystem/earth.jpg";
String PLANET_MODEL_PATH = "assets/starSystem/sphere.obj";

String PLAYER_TEXTURE_PATH = "assets/starship/Fighter2.png";
String PLAYER_MODEL_PATH = "assets/starship/FIghter2.obj";

String ENEMY_TEXTURE_LOD0_PATH = "assets/starship/Fighter1_1.png";
String ENEMY_TEXTURE_LOD1_PATH = "assets/starship/Fighter1_1.png";
String ENEMY_TEXTURE_LOD2_PATH = "assets/starship/Fighter1_1.png";
String ENEMY_TEXTURE_LOD3_PATH = "assets/starship/new/TEXT01.png";

//String ENEMY_MODEL_LOD0_PATH = "assets/starship/FIghter1_1.obj";
String ENEMY_MODEL_LOD3_PATH = "assets/starship/new/01_1.obj";
String ENEMY_MODEL_LOD1_PATH = "assets/starship/FIghter1_1.obj";
String ENEMY_MODEL_LOD2_PATH = "assets/starship/FIghter1_1.obj";
String ENEMY_MODEL_LOD0_PATH = "assets/starship/qfsrgec1aua5.obj";

//String ENEMY_TEXTURE_PATH = "assets/background/skybox.png";
//String ENEMY_MODEL_PATH = "assets/cube.obj";

String ENEMY_BULLET_TEXTURE_PATH = "assets/starship/enemy_bullet_texture.png";
String ENEMY_BULLET_MODEL_PATH = "assets/starship/sphere.obj";

String PLAYER_BULLET_TEXTURE_PATH = "assets/starship/player_bullet_texture.png";
String PLAYER_BULLET_MODEL_PATH = "assets/starship/sphere.obj";

String CROSSHAIR_IMG_PATH = "assets/starship/crosshair.png";

// --------------------------------------- END FILE PATHS ---------------------------------------

class Main{
  private ActionField actionField;
  private Background background;
  private List<Planet> planets;
  
  private State currentState = State.MENU;
  
  private int currentLevel;

  private int playerShield;
  private int playerHealth;

  public Main(){    
    loadModels();
    
    playerHealth = PLAYER_HEALTH;
    playerShield = PLAYER_SHIELD;
    
    planets = new ArrayList<Planet>();
    for(int i = 0; i < NUMBER_OF_PLANETS; i++){
      int enemyNumber = (int)(MULTIPLIER_ENEMIES * (i + 1) * 10);
      println("Enemy number: " + enemyNumber);
      
      // The last planet always contain boss
      planets.add( new Planet(enemyNumber, i - 1 == NUMBER_OF_PLANETS, PLANET_SIZE ) );
    }
    currentLevel = 0;
  
    actionField = new ActionField(planets);
    background = new Background(planets);
  }
  
  public void loadModels(){
    ENEMY_STARSHIP_LOD0_MODEL = modelBuilder(ENEMY_MODEL_LOD0_PATH, ENEMY_TEXTURE_LOD0_PATH, ENEMY_MODEL_SCALE);
    ENEMY_STARSHIP_LOD1_MODEL = modelBuilder(ENEMY_MODEL_LOD1_PATH, ENEMY_TEXTURE_LOD1_PATH, ENEMY_MODEL_SCALE);
    ENEMY_STARSHIP_LOD2_MODEL = modelBuilder(ENEMY_MODEL_LOD2_PATH, ENEMY_TEXTURE_LOD2_PATH, ENEMY_MODEL_SCALE);
    ENEMY_STARSHIP_LOD3_MODEL = modelBuilder(ENEMY_MODEL_LOD3_PATH, ENEMY_TEXTURE_LOD3_PATH, ENEMY_MODEL_SCALE);
    
    PLAYER_STARSHIP_MODEL = modelBuilder(PLAYER_MODEL_PATH, PLAYER_TEXTURE_PATH, PLAYER_MODEL_SCALE);
    PLAYER_BULLET_MODEL = modelBuilder(PLAYER_BULLET_MODEL_PATH, PLAYER_BULLET_TEXTURE_PATH, PLAYER_BULLET_RADIUS);
    ENEMY_BULLET_MODEL = modelBuilder(ENEMY_BULLET_MODEL_PATH, ENEMY_BULLET_TEXTURE_PATH, ENEMY_BULLET_RADIUS);    
  }
  
  private PShape modelBuilder(String modelPath, String texturePath, float scaleCoeff){
    PShape model = loadShape(modelPath);
    model.scale(scaleCoeff);
    model.setTexture(loadImage(texturePath));
    return model;
  }
  
  public void drawBackground(){
    background.drawBG();
  }
  
  public void drawActionField(){
    this.actionField.calculateActions();
  }
  
  public void changeState(State state){
    this.currentState = state;
  }
  
  public State getState(){
    return currentState;
  }
   
}

Main main;

void setup(){
  fullScreen(P3D);
  main = new Main();
  main.changeState(State.ACTIONFIELD);
  noCursor();
  Thread gameThread = new Thread(new Runnable(){
    @Override
    
    // Here is the game actions
    public void run(){
      try{
        while(true){
          Thread.sleep( (long)(1000 / FPS) );
          redraw();
          }
        }catch(InterruptedException e){
          e.printStackTrace();
        }
      }
  });
  
  gameThread.start();
  noLoop();
}



void draw(){
  background(0);
  switch(main.getState()){
    case ACTIONFIELD: 
      main.drawActionField();
      break;
    case BACKGROUND:
      main.drawBackground();    
      break;
    case TRANSITION:
      break;
    case MENU:
      break;
  }  
}
