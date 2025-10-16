class Bubble {
  float x, y;
  float size;
  float speed;
  float drift;

  Bubble(float x, float y) {
    this.x = x;
    this.y = y;
    size = random(5, 20);    // bubble size
    speed = random(0.5, 2);  // rising speed
    drift = random(-0.3, 0.3); // sideways drift
  }

  void update() {
    y -= speed;     // rise up
    x += drift;     // small drift
  }

  void display() {
    noFill();
    stroke(200, 230, 255, 180);  // light blue-transparent
    strokeWeight(2);
    ellipse(x, y, size, size);
  }

  boolean isOffScreen() {
    return y + size < 0;  // disappears after reaching top
  }
}
