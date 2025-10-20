class Food {
  // Location of the pellet inside the tank
  float posX, posY;
  // Gentle sink speed that gives fish time to react
  float speed = 1.5;
  boolean isEaten = false;

  Food(float x, float y) {
    this.posX = x;
    this.posY = y;
    // Pellets always start exactly where the user clicks
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
