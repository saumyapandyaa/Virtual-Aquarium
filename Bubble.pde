class Bubble {
  // Starting coordinates for the bubble
  float x, y;
  // Randomized size keeps the particle field varied
  float size;
  // Upward speed that determines how quickly the bubble escapes
  float speed;
  // Gentle side-to-side wobble
  float drift;

  Bubble(float x, float y) {
    this.x = x;
    this.y = y;
    // Give every bubble its own personality
    size = random(6, 20);    // bubble size
    speed = random(0.75, 2);  // rising speed
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
