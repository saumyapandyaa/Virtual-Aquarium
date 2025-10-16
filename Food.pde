class Food {
  float x, y;
  float speed = 1.5;
  boolean isEaten = false;

  Food(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    y += speed; // food sinks slowly
  }

  void display() {
    fill(255, 204, 0);
    noStroke();
    ellipse(x, y, 8, 8);
  }
}
