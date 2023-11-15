public class SinGenerator implements PosGenerator {
  
  private double maxX, maxY;
  
  public SinGenerator(double maxX, double maxY) {
  this.maxX = maxX;
  this.maxY = maxY;
  }
  @Override
  public Vector2 apply(double t) {
    double x = Math.sin(t + 0.5);
    double y = Math.cos(t + 0.5);

    return new Vector2(x, y);
  }
}
