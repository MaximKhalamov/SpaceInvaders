class AudioController{
  boolean isLooped = false;
  
  boolean started;
  
  private AudioPlayer startSound;
  private AudioPlayer loopSound;
  private AudioPlayer music;
  private AudioSample explosionSound;
  private AudioSample damageSound;
  private AudioSample shotSound;

  public AudioController(Minim minim){
    startSound = minim.loadFile(SOUND_FLYING_START_PATH);
    loopSound = minim.loadFile(SOUND_FLYING_LOOP_PATH);
    music = minim.loadFile(MUSIC_BACKGROUND_PATH);
    explosionSound = minim.loadSample(SOUND_EXPLOSION_PATH);
    damageSound = minim.loadSample(SOUND_DAMAGE_PATH);
    shotSound = minim.loadSample(SOUND_SHOT_PATH);
  }
  
  public void stopPlayers(){
    startSound.close();
    loopSound.close();
    music.close();
    explosionSound.close();
    damageSound.close();
    shotSound.close();    
  }
  
  public void playOnceExplosion(){
    explosionSound.trigger();
  }
  
  public void playOnceDamage(){
    damageSound.trigger();  
  }
  
  public void playOnceShot(){
    shotSound.trigger();
  }
  
  public void playLoopSounds(){
    if(!started){
      music.loop();
      startSound.play();
      started = true;
    } else if(!isLooped && !startSound.isPlaying()){
      isLooped = true;
      loopSound.loop();
    }
  }
  
  public void stopLoopSounds(boolean isStopMusic){
    loopSound.close();
    startSound.close();
    if(isStopMusic)
      music.close();
  }
}
