public class Vector3 {
  public double x, y, z;

  public Vector3(Vector2 vector2) {
    this(vector2, 0);
  }

  public Vector3(Vector2 vector2, double z) {
    this(vector2.x, vector2.y, z);
  };

  public Vector3(double x, double y, double z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  public double length() {
    return Math.sqrt(x * x + y * y + z * z);
  }

  public double normalize() {
    return x / length();
  }

  public Vector3 add(Vector3 other) {
    return new Vector3(x + other.x, y + other.y, z + other.z);
  }

  public Vector3 subtract(Vector3 other) {
    return new Vector3(x - other.x, y - other.y, z - other.z);
  }

  public Vector3 multiply(Vector3 other) {
    return new Vector3(x * other.x, y * other.y, z * other.z);
  }

  public Vector3 divide(Vector3 other) {
    return new Vector3(x / other.x, y / other.y, z / other.z);
  }
}
