class Food {
  float posX, posY;
  float speed = 1.5;
  boolean isEaten = false;

  Food(float x, float y) {
    this.posX = x;
    this.posY = y;
  }

  void update() {
    posY += speed; // food sinks slowly
  }

  void display() {
    fill(255, 220, 250);
    noStroke();
    ellipse(posX, posY, 8, 8);
  }
}
