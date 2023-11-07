public class BackgroundCamera{
  private float x, y, z;
  private float centerX, centerY, centerZ;
  private float upX, upY, upZ;
  
  public void moveCam(float x, float y, float z){}
  public void rotateCam(){}
  
  public BackgroundCamera(){
    x = 0.0f; y = 0.0f; z = 60.0f;                 // the initial position of the camera
    centerX = 0.0f; centerY = 0.0f; centerZ = 0.0f; // looking at the star
    upX = 1.0f; upY = 0.0f; upZ = 0.0f;             // up vector of the camera
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public float getZ(){
    return z;
  }
  
  public float getCX(){
    return centerX;
  }
  
  public float getCY(){
    return centerY;
  }
  
  public float getCZ(){
    return centerZ;
  }
  
  public float getUX(){
    return upX;
  }
  
  public float getUY(){
    return upY;
  }
  
  public float getUZ(){
    return upZ;
  }
}
