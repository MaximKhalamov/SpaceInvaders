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
