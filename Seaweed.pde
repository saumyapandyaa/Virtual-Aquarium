class Seaweed {
  float baseX, baseY;
  float height;
  float swaySpeed;
  float swayAmount;
  float phase;
  int segments;

  Seaweed(float x, float y) {
    baseX = x;
    baseY = y;
    height = random(80, 150);
    swaySpeed = random(0.01, 0.03);
    swayAmount = random(10, 25);
    phase = random(TWO_PI);
    segments = int(random(6, 10));
  }

  void display() {
    stroke(0, 100 + random(-10,10), 0);  // dark green
    strokeWeight(4);
    noFill();

    beginShape();
    for (int i = 0; i <= segments; i++) {
      float t = i / float(segments);
      float sway = sin(phase + t * PI) * swayAmount * t;
      float x = baseX + sway;
      float y = baseY - t * height;
      vertex(x, y);
    }
    endShape();

    // update phase for gentle waving
    phase += swaySpeed;
  }
}
