float getNorm(float x, float y, float z) {
  //return (float)Math.sqrt(x * x + y * y + z * z);
  return (float)Math.sqrt(x * x + y * y + z * z);
}

float getDotMult(float x1, float y1, float z1, float x2, float y2, float z2){
    return x1 * x2 + y1 * y2 + z1 * z2;
}

boolean isObjectOnScreen(float posX, float posY, float posZ, float camX, float camY, float camZ, float camDirX, float camDirY, float camDirZ){
  return cos( getDotMult( posX - camX, posY - camY, posZ - camZ, camDirX, camDirY, camDirZ) / 
                    //( getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 2 * (WIDTH / HEIGTH)  ) ) ){
                    //( getNorm(getPosX() - camX, getPosY() - camY, getPosZ() - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 3 * ( (float)WIDTH / HEIGTH)  )  ) ){
                    ( getNorm(posX - camX, posY - camY, posZ - camZ) * getNorm(camDirX, camDirY, camDirZ) ) ) > cos( FOV / ( 2 * ((float)WIDTH / HEIGTH)  )  );
}
