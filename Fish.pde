class Fish {
  // Floating position of the fish within the tank
  float posX, posY;
  // Current movement velocity, helps determine which way to face
  float speedX, speedY;
  // Body color so each fish feels distinct
  int colour;
  float size = 30;
  // Tail swing values used for the wiggling animation
  float tailAngle = 0;
  float tailSpeed;
  // Simple life bar so we can visualize how hungry the fish is
  float energy_level = 100;   // energy level (0–100)
  boolean isEating = false;

  Fish(float posX, float posY, int colour) {
    this.posX = posX;
    this.posY = posY;
    this.colour = colour;
    // Randomize starting direction so the school spreads out
    speedX = random(-3, 3);
    speedY = random(-3, 3);
    tailSpeed = random(0.2, 0.5);
  }

  void update(ArrayList<Food> foods) {
    // Slowly reduce energy over time
    energy_level -= 0.02;
    energy_level = constrain(energy_level, 0, 100);

    // Tail animation
    tailAngle += tailSpeed;

    // Movement speed depends on energy
    float energyFactor = map(energy_level, 0, 100, 0.5, 1.5);

    posX += speedX * energyFactor;
    posY += speedY * energyFactor;

    // Bounce off walls
    if (posX < 0 || posX > width) speedX *= -1;
    if (posY < 0 || posY > height) speedY *= -1;

    // Avoid mouse (predator effect)
    float distToMouse = dist(posX, posY, mouseX, mouseY);
    if (distToMouse < 100) {
      float angle = atan2(posY - mouseY, posX - mouseX);
      speedX += cos(angle) * 0.5;
      speedY += sin(angle) * 0.5;
    }

    // Chase nearest food
    Food nearest = null;
    float nearestDist = 9999;
    for (Food f : foods) {
      float d = dist(posX, posY, f.posX, f.posY);
      if (d < nearestDist) {
        nearestDist = d;
        nearest = f;
      }
    }

    if (nearest != null && nearestDist < 200) {
      float angle = atan2(nearest.posY - posY, nearest.posX - posX);
      speedX += cos(angle) * 0.1;
      speedY += sin(angle) * 0.1;
    }

    // Check if fish eats food (collision)
    if (nearest != null && nearestDist < 20) {
      nearest.isEaten = true;
      energy_level += 25;  // regain energy
      energy_level = constrain(energy_level, 0, 90);
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
    translate(posX, posY);

    // Rotate fish in direction of motion
    float angle = atan2(speedY, speedX);
    rotate(angle);

    // Draw fish body
    fill(colour);
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
    float energyRatio = energy_level / 100.0;

    float barX = posX - barWidth / 2;
    float barY = posY - size / 1.2;

    // Background (gray)
    fill(80);
    rect(barX, barY, barWidth, barHeight);

    // Foreground (green → red based on energy)
    if (energy_level > 50) fill(0, 255, 0);
    else if (energy_level > 25) fill(255, 165, 0);
    else fill(255, 0, 0);

    rect(barX, barY, barWidth * energyRatio, barHeight);
  }
}
