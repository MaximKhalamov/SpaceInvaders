class Control{
  ControlDevice device;

  ControlSlider sliderLeftX;
  ControlSlider sliderLeftY;
  ControlButton buttonX;
  
  float globalPositionX = 0.0f;
  float globalPositionY = 0.0f;
  
  public Control(){
    device = control.getDevice(DEVICE_NAME);
    
    sliderLeftX = device.getSlider("x");
    sliderLeftY = device.getSlider("y");
    buttonX = device.getButton("X");
  }
  
  public float getX(){
    globalPositionX += SENSITIVITY_X * sliderLeftX.getValue();
    if(globalPositionX < 0)
      globalPositionX = 0;
    if(globalPositionX > WIDTH)
      globalPositionX = WIDTH;
    return globalPositionX;  
  }
  
  public float getY(){
    globalPositionY += SENSITIVITY_Y * sliderLeftY.getValue();
    if(globalPositionY < 0)
      globalPositionY = 0.0f;
    if(globalPositionY > HEIGHT)
      globalPositionY = HEIGHT;
    return globalPositionY;    
  }
  
  public boolean isPressed(){
    return buttonX.pressed();
  }
}

class ControlKeyboard{  
  float globalPositionX = 0.0f;
  float globalPositionY = 0.0f;
  
  public ControlKeyboard(){}
  
  public float getX(){
    if(pressedKeys['a'] == 1 || pressedKeys['A'] == 1)
      globalPositionX -= SENSITIVITY_X;
    if(pressedKeys['d'] == 1 || pressedKeys['D'] == 1)
      globalPositionX += SENSITIVITY_X;
    
    if(globalPositionX < 0)
      globalPositionX = 0;
    if(globalPositionX > WIDTH)
      globalPositionX = WIDTH;
    
    return globalPositionX;  
  }
  
  public float getY(){
    if(pressedKeys['W'] == 1 || pressedKeys['w'] == 1)
      globalPositionY -= SENSITIVITY_Y;
    if(pressedKeys['S'] == 1 || pressedKeys['s'] == 1)
      globalPositionY += SENSITIVITY_Y;
    
    if(globalPositionY < 0)
      globalPositionY = 0;
    if(globalPositionY > HEIGHT)
      globalPositionY = HEIGHT;
    
    return globalPositionY;
  }
  
  public boolean isPressed(){
    return pressedKeys[' '] == 1;
  }
}
