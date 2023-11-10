public class BackgroundCamera{
  private float x, y, z;
  private float centerX, centerY, centerZ;
  private float upX, upY, upZ;
  
  public void moveAbs(float x, float y, float z){ // camera movement to (x, y, z) from old coords
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public void moveRel(float x, float y, float z){  // camera movement to (xold + x, yold + y, zold + z) from (xold, yold, zold)
    this.x += x;
    this.y += y;
    this.z += z;
  }
  public void rotateCam(){}
  
  //public BackgroundCamera(){
  //  x = 0.0f; y = 0.0f; z = 60.0f;                 // the initial position of the camera
  //  centerX = 0.0f; centerY = 0.0f; centerZ = 0.0f; // looking at the star
  //  upX = 1.0f; upY = 0.0f; upZ = 0.0f;             // up vector of the camera
  //}
  
  public BackgroundCamera(float ax, float ay, float az, float acenterX, float acenterY, float acenterZ, float aupX, float aupY, float aupZ){
    x = ax; y = ay; z = az;
    centerX = acenterX; centerY = acenterY; centerZ = acenterZ;
    upX = aupX; upY = aupY; upZ = aupZ;
  }
  
  public float getX(){ return x; }
  public float getY(){ return y; }
  public float getZ(){ return z; }
  
  public float getCX(){ return centerX; }
  public float getCY(){ return centerY; }
  public float getCZ(){ return centerZ; }
  
  public float getUX(){ return upX; }
  public float getUY(){ return upY; }
  public float getUZ(){ return upZ; }

  public void setX(float a){ x = a; }
  public void setY(float a){ y = a; }
  public void setZ(float a){ z = a; }
  
  public void setCX(float a){ centerX = a; }
  public void setCY(float a){ centerY = a; }
  public void setCZ(float a){ centerZ = a; }
  
  public void setUX(float a){ upX = a; }
  public void setUY(float a){ upY = a; }
  public void setUZ(float a){ upZ = a; }
}
