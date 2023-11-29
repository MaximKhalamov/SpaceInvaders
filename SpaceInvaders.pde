import java.io.File;
import java.util.Random;
import java.util.List;
import java.util.Iterator;
import ddf.minim.*;
import org.gamecontrolplus.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;


// --------------------------------------- CUSTOMIZABLE ---------------------------------------
int NUMBER_OF_PLANETS =               3;     // Also number of levels
float MULTIPLIER_ENEMIES =            1.0f;  // Multiplier for the numbers of enemies
float MULTIPLIER_FIRE_RATE_ENEMY =    1.0f;
float MULTIPLIER_FIRE_RATE_PLAYER =   1.0f;
float MULTIPLIER_SPEED_ENEMY =        0.0f;
float MULTIPLIER_SCREEN_TRANSISTION = 1.0f;
float FPS = 60.0f;

int PLAYER_HEALTH = 50;
int PLAYER_SHIELD = 20;

int ENEMY_LIGHT_HEALTH = 20;
int ENEMY_LIGHT_SHIELD = 10;

float SENSITIVITY_X = 30f;
float SENSITIVITY_Y = 30f;

boolean IS_CINEMATOGRAPHIC_CAMERA = true;
int NUMBER_OF_WAVES = 2;

float LOD1_DISTANCE = 100.0f;
float LOD2_DISTANCE = 400.0f;
float LOD3_DISTANCE = 5000.0f;

color PLAYER_BULLET_COLOR = color(0, 255, 0);
color ENEMY_BULLET_COLOR = color(255, 0, 0);

String DEVICE_NAME = "Xbox Wireless Controller";
String RELATIVE_PATH = "/home/max/sketchbook/SpaceInvaders/";

Device DEVICE = Device.MOUSE;

// --------------------------------------- END CUSTOMIZABLE ---------------------------------------

// --------------------------------------- BETTER DO NOT TOUCH ---------------------------------------
float PLANET_SIZE = 10.0f;
float STAR_SIZE = 100.0f;

int HEIGHT = 1080;
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

PShape HEALTH_DAMAGE_MODEL;
PShape SHIELD_DAMAGE_MODEL;

AudioController audioController;

ControlIO control;

enum Device{
  KEYBOARD,
  GAMEPAD,
  MOUSE
}

enum State{
  BACKGROUND,
  ACTIONFIELD,
  MENU
}

enum Signal{
  CONTINUE,
  SWITCH,
}

byte[] pressedKeys = new byte[256];
// --------------------------------------- END BETTER DO NOT TOUCH ---------------------------------------

// --------------------------------------- FILE PATHS ---------------------------------------

String SKYBOX_TEXTURE_PATH = "assets/background/skybox.png";
String SKYBOX_MODEL_PATH = "assets/background/skybox.obj";

String HEALTH_DAMAGE_TEXTURE_PATH = "assets/effects/damageTexture.png";
String SHIELD_DAMAGE_TEXTURE_PATH = "assets/effects/shieldTexture.png";

String STAR_TEXTURE_PATH = "assets/starSystem/starWhite.jpg";
String PLANET_TEXTURE_PATHS = "assets/starSystem/planets/";
String PLANET_MODEL_PATH = "assets/starSystem/sphere3.obj";

//String PLAYER_TEXTURE_PATH = "assets/starship/FighterFemboy.png";
String PLAYER_TEXTURE_PATH = "assets/starship/Fighter2.png";
String PLAYER_MODEL_PATH = "assets/starship/FIghter2.obj";

String ENEMY_TEXTURE_LOD0_PATH = "assets/starship/Fighter1_1.png";
String ENEMY_TEXTURE_LOD1_PATH = "assets/starship/Fighter1_1.png";
String ENEMY_TEXTURE_LOD2_PATH = "assets/starship/Fighter1_1.png";
String ENEMY_TEXTURE_LOD3_PATH = "assets/starship/Fighter1_1_lowdetail.png";

String ENEMY_MODEL_LOD3_PATH = "assets/starship/qfsrgec1aua5.obj";
String ENEMY_MODEL_LOD1_PATH = "assets/starship/01_2.obj";
String ENEMY_MODEL_LOD2_PATH = "assets/starship/01_3.obj";
String ENEMY_MODEL_LOD0_PATH = "assets/starship/FIghter1_1.obj";

String VICTORY_SCREEN = "assets/effects/victoryScreen.png";
String GAMEOVER_SCREEN = "assets/effects/gameoverScreen.png";
String CLEARED_SCREEN = "assets/effects/clearedScreen.png";
String PREPARE_SCREEN = "assets/effects/prepareScreen.png";
String RED_SCREEN = "assets/effects/redScreen.png";

String CROSSHAIR_IMG_PATH = "assets/starship/crosshair.png";

String SOUND_FLYING_LOOP_PATH = "assets/sounds/JetBoost_Loop.mp3";
String SOUND_FLYING_START_PATH = "assets/sounds/JetBoost_Start.mp3";
String SOUND_SHOT_PATH = "assets/sounds/shot.mp3";
String SOUND_DAMAGE_PATH = "assets/sounds/damage.mp3";
String SOUND_EXPLOSION_PATH = "assets/sounds/damage.mp3";
String MUSIC_BACKGROUND_PATH = "assets/sounds/galaxyx27s-edge-154425.mp3";

// --------------------------------------- END FILE PATHS ---------------------------------------

class Main{
  private ActionField actionField;
  private Background background;
  private List<Planet> planets;
  
  private State currentState = State.ACTIONFIELD;
  
  private int currentLevel;

  private int playerShield;
  private int playerHealth;

  public Main(Minim minim){    
    loadModels();

    audioController = new AudioController( minim );

    playerHealth = PLAYER_HEALTH;
    playerShield = PLAYER_SHIELD;

    planets = new ArrayList<Planet>();
    for(int i = 0; i < NUMBER_OF_PLANETS; i++){
      int enemyNumber = (int)(MULTIPLIER_ENEMIES * (i + 1) * 10);

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
    ENEMY_STARSHIP_LOD3_MODEL = modelBuilder(ENEMY_MODEL_LOD3_PATH, ENEMY_TEXTURE_LOD3_PATH, ENEMY_MODEL_SCALE);

    HEALTH_DAMAGE_MODEL = modelBuilder(ENEMY_MODEL_LOD3_PATH, HEALTH_DAMAGE_TEXTURE_PATH, ENEMY_MODEL_SCALE * 1.3);
    SHIELD_DAMAGE_MODEL = modelBuilder(ENEMY_MODEL_LOD3_PATH, SHIELD_DAMAGE_TEXTURE_PATH, ENEMY_MODEL_SCALE * 1.3);

    PLAYER_STARSHIP_MODEL = modelBuilder(PLAYER_MODEL_PATH, PLAYER_TEXTURE_PATH, PLAYER_MODEL_SCALE); 
  }

  private PShape modelBuilder(String modelPath, String texturePath, float scaleCoeff){
    PShape model = loadShape(modelPath);
    model.scale(scaleCoeff);
    model.setTexture(loadImage(texturePath));
    return model;
  }

  public Signal drawBackground(){
    return background.drawBG(currentLevel);
  }

  public Signal drawActionField(){
    return this.actionField.calculateActions(currentLevel);
  }
  
  public void changeState(State state){
    this.currentState = state;
  }
  
  public State getState(){
    return currentState;
  }
  
  public void setNextLevel(){
    currentLevel++;
  }
}

Main main;

void setup(){
  readConfig();
  Minim minim = new Minim(this);
  fullScreen(P3D);
  control = ControlIO.getInstance(this);
  main = new Main(minim);
  //main.changeState(State.BACKGROUND);
  noCursor();
  perspective(FOV, float(width)/float(height), 1, 400000);
  audioController.playLoopSounds();
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
      if(main.drawActionField() == Signal.SWITCH){
        main.changeState(State.BACKGROUND);
        main.setNextLevel();
      }
      break;
    case BACKGROUND:
      if(main.drawBackground() == Signal.SWITCH){
        main.changeState(State.ACTIONFIELD);
      }    
      break;
    case MENU:
      break;
  }  
}

void keyPressed() {
  pressedKeys[keyCode] = 1;
}

void keyReleased() {
  pressedKeys[keyCode] = 0;
}

void readConfig() {
  Properties prop = new Properties();
  File configFile = new File(sketchPath("config.properties"));
  
  try (BufferedReader reader = new BufferedReader(new FileReader(configFile))) {
    prop.load(reader);
  } catch (IOException ex) {
    ex.printStackTrace();
  }

  NUMBER_OF_PLANETS = Integer.parseInt(prop.getProperty("NUMBER_OF_PLANETS"));
  MULTIPLIER_ENEMIES = Float.parseFloat(prop.getProperty("MULTIPLIER_ENEMIES"));
  MULTIPLIER_FIRE_RATE_ENEMY = Float.parseFloat(prop.getProperty("MULTIPLIER_FIRE_RATE_ENEMY"));
  MULTIPLIER_FIRE_RATE_PLAYER = Float.parseFloat(prop.getProperty("MULTIPLIER_FIRE_RATE_PLAYER"));
  MULTIPLIER_SPEED_ENEMY = Float.parseFloat(prop.getProperty("MULTIPLIER_SPEED_ENEMY"));
  MULTIPLIER_SCREEN_TRANSISTION = Float.parseFloat(prop.getProperty("MULTIPLIER_SCREEN_TRANSISTION"));
  FPS = Float.parseFloat(prop.getProperty("FPS"));

  PLAYER_HEALTH = Integer.parseInt(prop.getProperty("PLAYER_HEALTH"));
  PLAYER_SHIELD = Integer.parseInt(prop.getProperty("PLAYER_SHIELD"));

  ENEMY_LIGHT_HEALTH = Integer.parseInt(prop.getProperty("ENEMY_LIGHT_HEALTH"));
  ENEMY_LIGHT_SHIELD = Integer.parseInt(prop.getProperty("ENEMY_LIGHT_SHIELD"));

  SENSITIVITY_X = Float.parseFloat(prop.getProperty("SENSITIVITY_X"));
  SENSITIVITY_Y = Float.parseFloat(prop.getProperty("SENSITIVITY_Y"));

  IS_CINEMATOGRAPHIC_CAMERA = Boolean.parseBoolean(prop.getProperty("IS_CINEMATOGRAPHIC_CAMERA"));
  NUMBER_OF_WAVES = Integer.parseInt(prop.getProperty("NUMBER_OF_WAVES"));

  LOD1_DISTANCE = Float.parseFloat(prop.getProperty("LOD1_DISTANCE"));
  LOD2_DISTANCE = Float.parseFloat(prop.getProperty("LOD2_DISTANCE"));
  LOD3_DISTANCE = Float.parseFloat(prop.getProperty("LOD3_DISTANCE"));

  PLAYER_BULLET_COLOR = color(
    Integer.parseInt(prop.getProperty("PLAYER_BULLET_COLOR_R")), 
    Integer.parseInt(prop.getProperty("PLAYER_BULLET_COLOR_G")),
    Integer.parseInt(prop.getProperty("PLAYER_BULLET_COLOR_B")));
  
  ENEMY_BULLET_COLOR = color(
    Integer.parseInt(prop.getProperty("ENEMY_BULLET_COLOR_R")),
    Integer.parseInt(prop.getProperty("ENEMY_BULLET_COLOR_G")),
    Integer.parseInt(prop.getProperty("ENEMY_BULLET_COLOR_B")));
    
  RELATIVE_PATH = prop.getProperty("RELATIVE_PATH");

  DEVICE_NAME = prop.getProperty("DEVICE_NAME");
  String devName = prop.getProperty("USING_DEVICE");
  if(devName.equals("MOUSE"))
    DEVICE = Device.MOUSE;
  if(devName.equals("KEYBOARD"))
    DEVICE = Device.KEYBOARD;
      if(devName.equals("GAMEPAD"))
    DEVICE = Device.GAMEPAD;
}

void stop(){
  audioController.stopPlayers();
  println("Thanks for playing ^_^");
}
