public class Vector2 {
  public double x, y;

  public Vector2(double x, double y) {
    this.x = x;
    this.y = y;
  }

  public double length() {
    return Math.sqrt(x * x + y * y);
  }

  public double normalize() {
    return x / length();
  }

  public Vector2 add(Vector3 other) {
    return new Vector2(x + other.x, y + other.y);
  }

  public Vector2 subtract(Vector3 other) {
    return new Vector2(x - other.x, y - other.y);
  }

  public Vector2 multiply(Vector3 other) {
    return new Vector2(x * other.x, y * other.y);
  }

  public Vector2 divide(Vector3 other) {
    return new Vector2(x / other.x, y / other.y);
  }
}
