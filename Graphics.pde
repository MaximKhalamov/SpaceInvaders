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
      fill(255, 255, 255, 63);
      line(px, py, 0, sx, sy, 0);
      noFill();
    }
  }
}


class ExplosionEffect{
  private float x;
  private float y;
  private float z;
  private int timing = 10;
  
  public ExplosionEffect(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public boolean display(){
    if(timing > 0){
      pushMatrix();
      translate(x, y, z);
      fill(255, 127 + 5 * timing, 10 * timing, 98);
      sphere(50f / sqrt(timing));
      popMatrix();
      timing--;
      return true;
    }else{
      return false;
    }
  } 
}

int TIMING_SCAN_MODE = 2;
int TIMING_LOCATING = 20;
int TIMING_RECEIVING = 23;
int TIMING_INCOMING = 5;
int TIMING_BETWEEN_FUNCS = 4;
int TIMING_ENTERNING = 8;
int TIMITG_SECOND = 30;

class PreparingInfo{
  private int timing = 0;  
  private List<String> functions;
  
  public PreparingInfo(){
    functions = new ArrayList<>();
  }
  
  public void display(float x, float y, float z){
    pushMatrix();
    translate(x, y, z);
    rotateY(PI);
    textSize(240);
    textAlign(CENTER, CENTER);  
    hint(DISABLE_DEPTH_TEST);
    text("word", 100, 100);
    fill(0, 408, 612, 816);
    text("word", 100, 180, -120);  // Specify a z-axis value
    text("word", 48, 240);
    hint(ENABLE_DEPTH_TEST);
    
    popMatrix();
    timing++;
  }
}
