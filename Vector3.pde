// DO NOT ALLOCATE MEMORY USING NEW TOO MUCH.

public class Vector3 {
  public float x, y, z;

  public Vector3(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  public float length() {
    return (float)Math.sqrt(x * x + y * y + z * z);
  }

  public void normalize() {
    float l = length();
    x /= l; y /= l; z /= l;
  }

  public Vector3 add(Vector3 other) {
    x += other.x; y += other.y; z += other.z;
    return this;
  }

  public Vector3 sub(Vector3 other) {
    x -= other.x; y -= other.y; z -= other.z;
    return this;
  }

  public Vector3 mult(float scalar) {
    x *= scalar; y *= scalar; z *= scalar;
    return this;
  }

  public float dot(Vector3 other) {
    return x * other.x + y * other.y + z * other.z;
  }

  public Vector3 cross(Vector3 o) {
    x = y * o.z - z * o.y;
    y = z * o.x - x * o.z;
    z = x * o.y - y * o.x;
    return this;
  }
}
