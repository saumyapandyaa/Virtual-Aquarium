class Seaweed {
  // Anchor position on the aquarium floor
  float baseX, baseY;
  // Height and bending personality of this strand
  float height;
  float swaySpeed;
  float swayAmount;
  // Phase offset lets each plant sway on its own rhythm
  float phase;
  int segments;

  Seaweed(float x, float y) {
    baseX = x;
    baseY = y;
    // Randomize appearance so the forest feels organic
    height = random(80, 150);
    swaySpeed = random(0.01, 0.05);
    swayAmount = random(10, 50);
    phase = random(TWO_PI);
    segments = int(random(6, 10));
  }

  void display() {
    stroke(0, 100 + random(-10,10), 10);  // dark green
    strokeWeight(3.5);
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
