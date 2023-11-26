class Background{
  private BackgroundCamera bgCamera;
  private List<Planet> planets;
  
  private PShape skyBoxModel;
  private PImage skyBoxTexture;
  private float skyBoxSize = 160000f;

  private PShape starModel;
  private PImage starTexture;

  private float paramT = 0;
  
  private float middlePointBezierX;
  private float middlePointBezierY;
  
  public Background(List<Planet> planets){
    this.planets = planets;
    
    skyBoxModel = loadShape(SKYBOX_MODEL_PATH);
    skyBoxTexture = loadImage(SKYBOX_TEXTURE_PATH);
    skyBoxModel.setTexture(skyBoxTexture);
    skyBoxModel.setAmbient(0xfffffff);
    skyBoxModel.scale(skyBoxSize);
    
    starModel = loadShape(PLANET_MODEL_PATH);
    starTexture = loadImage(STAR_TEXTURE_PATH);
    starModel.setAmbient(0xff7f7f00);
    //starModel.setFill(color(255, 255, 63, 255));
    starModel.setTexture(starTexture);
    starModel.scale(STAR_SIZE);
    
    bgCamera = new BackgroundCamera(0, 0, 1300, 0, 0, 0, 0, 1, 0);
    
    setBezierPoints(planets.get(0), planets.get(1));
  }
  
  private float hermit(float x) { return 3 * x * x - 2 * x * x * x; }
  
  private float getQuarter(float p1, float p2){
    return (p2 - p1) / 3;
  }
  
  private void setBezierPoints(Planet planetFrom, Planet planetTo){
    float xFrom = planetFrom.getX();  
    float yFrom = planetFrom.getY();  
    float xTo = planetTo.getX();  
    float yTo = planetTo.getY();
    
    //float l = random(0.0, 1.0);
    float l = 0.5;
    float distX = (1 - l) * xFrom + l * xTo;
    float distY = (1 - l) * yFrom + l * yTo;
    
    float hx =   (yFrom - yTo) * 1;
    float hy = - (xFrom - xTo) * 1;
    
    middlePointBezierX = hx + distX;
    middlePointBezierY = hy + distY;
  }
  
  private float getBezier2nd(float p1, float p2, float p3, float t){
    return (1 - t) * (1 - t) * p1 
           + 2 * t * (1 - t) * p2
                     + t * t * p3;
  }

  private float getBezier2ndDeriv(float p1, float p2, float p3, float t){
    return     - 2 * (1 - t) * p1
           + 2 * (1 - 2 * t) * p2 
                     + 2 * t * p3;
  }
  
  private float getRotation(float x, float y){
    return acos(x / sqrt(x * x + y * y)) * Math.signum(y);
  }
  
  private void move(Planet planetFrom, Planet planetTo){
    paramT += 0.005;
    if(IS_CINEMATOGRAPHIC_CAMERA){
      float startPosX = planetFrom.getX() + getQuarter(planetFrom.getX(), planetTo.getX());
      float startPosY = planetFrom.getY() + getQuarter(planetFrom.getY(), planetTo.getY());

      float vec1x = planetFrom.getX() - planetTo.getX();
      float vec1y = planetFrom.getY() - planetTo.getY();
      
      float xCam = startPosX - Math.signum(planetFrom.getX() * vec1y - planetFrom.getY() * vec1x) * getQuarter(planetFrom.getY(), planetTo.getY());
      float yCam = startPosY + Math.signum(planetFrom.getX() * vec1y - planetFrom.getY() * vec1x) * getQuarter(planetFrom.getX(), planetTo.getX());
      //float xCam = startPosX - INIT_RADIUS / 2;
      //float yCam = startPosY + INIT_RADIUS / 2;
      
      pushMatrix();
      translate(map(paramT, 0f, 1f, planetFrom.getX(), planetTo.getX()), map(paramT, 0f, 1f, planetFrom.getY(), planetTo.getY()), 16);
      rotateX(PI/2);      
      rotateY(PI + getRotation( planetTo.getX() - planetFrom.getX(), planetTo.getY() - planetFrom.getY() ) );
      scale(0.3);
      shape(PLAYER_STARSHIP_MODEL);
      popMatrix();
            
      camera(xCam, yCam, 8,
            map(paramT, 0f, 1f, planetFrom.getX(), planetTo.getX()), map(paramT, 0f, 1f, planetFrom.getY(), planetTo.getY()), 16,
            0, 0, -1);

      //camera(0, 0, 300,
      //      0, 0, 0,
      //      0, 1, 0);

    } else {
      float xCam = getBezier2nd(planetFrom.getX(), middlePointBezierX, planetTo.getX(), hermit(paramT));
      float yCam = getBezier2nd(planetFrom.getY(), middlePointBezierY, planetTo.getY(), hermit(paramT));
      
      float xCamDeriv = getBezier2ndDeriv(planetFrom.getX(), middlePointBezierX, planetTo.getX(), hermit(paramT));
      float yCamDeriv = getBezier2ndDeriv(planetFrom.getY(), middlePointBezierY, planetTo.getY(), hermit(paramT));
      
      pushMatrix();
      translate(xCam, yCam, PLANET_SIZE + 1);
      rotateX(PI/2);
      rotateY(3*PI /2 + atan(yCamDeriv / xCamDeriv));
      translate(0, 0, 1000);
      popMatrix();

      camera( xCam, yCam, PLANET_SIZE + 1,
              xCam + xCamDeriv, yCam + yCamDeriv, PLANET_SIZE + 1,
               0, 0, -1);
    }
  }
  
  public Signal drawBG(int planetMoveTo){
    noLights();
    //lightSpecular(255, 255, 255);
    pushMatrix();
    translate(-skyBoxSize / 2, -skyBoxSize / 2, -skyBoxSize / 2);
    shape(skyBoxModel);
    popMatrix();

    lights();
    pointLight(255,255,255,0,0,0);
    pushMatrix();
    rotateX(-PI/2);
    shape(starModel);
    popMatrix();

    for(Planet planet: planets){
      planet.drawPlanet();
    }

    move( planets.get( planetMoveTo - 1 ), planets.get( planetMoveTo ) );

    if(paramT >= 1.0f){
      paramT = 0.0f;
      return Signal.SWITCH;
    }
    return Signal.CONTINUE;
  }
}
