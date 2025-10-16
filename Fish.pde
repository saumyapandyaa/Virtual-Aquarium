class Fish {
  float x, y;
  float speedX, speedY;
  int c;
  float size = 30;
  float tailAngle = 0;
  float tailSpeed;
  float energy = 100;   // energy level (0–100)
  boolean isEating = false;

  Fish(float x, float y, int c) {
    this.x = x;
    this.y = y;
    this.c = c;
    speedX = random(-2, 2);
    speedY = random(-2, 2);
    tailSpeed = random(0.1, 0.3);
  }

  void update(ArrayList<Food> foods) {
    // Slowly reduce energy over time
    energy -= 0.02;
    energy = constrain(energy, 0, 100);

    // Tail animation
    tailAngle += tailSpeed;

    // Movement speed depends on energy
    float energyFactor = map(energy, 0, 100, 0.5, 1.5);

    x += speedX * energyFactor;
    y += speedY * energyFactor;

    // Bounce off walls
    if (x < 0 || x > width) speedX *= -1;
    if (y < 0 || y > height) speedY *= -1;

    // Avoid mouse (predator effect)
    float distToMouse = dist(x, y, mouseX, mouseY);
    if (distToMouse < 100) {
      float angle = atan2(y - mouseY, x - mouseX);
      speedX += cos(angle) * 0.5;
      speedY += sin(angle) * 0.5;
    }

    // Chase nearest food
    Food nearest = null;
    float nearestDist = 9999;
    for (Food f : foods) {
      float d = dist(x, y, f.x, f.y);
      if (d < nearestDist) {
        nearestDist = d;
        nearest = f;
      }
    }

    if (nearest != null && nearestDist < 200) {
      float angle = atan2(nearest.y - y, nearest.x - x);
      speedX += cos(angle) * 0.1;
      speedY += sin(angle) * 0.1;
    }

    // Check if fish eats food (collision)
    if (nearest != null && nearestDist < 20) {
      nearest.isEaten = true;
      energy += 25;  // regain energy
      energy = constrain(energy, 0, 100);
      isEating = true;
    } else {
      isEating = false;
    }

    // Limit speed
    speedX = constrain(speedX, -3, 3);
    speedY = constrain(speedY, -3, 3);
  }

  void display() {
    pushMatrix();
    translate(x, y);

    // Rotate fish in direction of motion
    float angle = atan2(speedY, speedX);
    rotate(angle);

    // Draw fish body
    fill(c);
    noStroke();
    ellipse(0, 0, size, size / 2);

    // Tail wiggle
    float tailOffset = sin(tailAngle) * 6;
    triangle(-size / 2, 0, -size / 2 - 10, -5 + tailOffset, -size / 2 - 10, 5 + tailOffset);

    // Eye
    fill(0);
    ellipse(size / 4, -size / 8, 4, 4);

    popMatrix();

    // Draw hunger/energy bar above fish
    drawEnergyBar();
  }

  void drawEnergyBar() {
    float barWidth = 30;
    float barHeight = 4;
    float energyRatio = energy / 100.0;

    float barX = x - barWidth / 2;
    float barY = y - size / 1.2;

    // Background (gray)
    fill(80);
    rect(barX, barY, barWidth, barHeight);

    // Foreground (green → red based on energy)
    if (energy > 50) fill(0, 255, 0);
    else if (energy > 25) fill(255, 165, 0);
    else fill(255, 0, 0);

    rect(barX, barY, barWidth * energyRatio, barHeight);
  }
}
