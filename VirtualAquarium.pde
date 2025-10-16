// Virtual Aquarium Simulation
// Shivam Patel - SOFE 4590 Project
// Demonstrates real-time animation, interactivity, and object behavior

// --------------------------------------------
// VIRTUAL AQUARIUM with Fish Behavior
// Shivam Patel – Interactive Graphics Project
// Features: real-time animation, user input,
// 15+ fish, food chasing, predator avoidance,
// hunger/energy system, bubbles, seaweed, and day/night toggle.
// --------------------------------------------

ArrayList<Fish> fishes;
ArrayList<Food> foods;
ArrayList<Bubble> bubbles;
ArrayList<Seaweed> seaweeds;

boolean isDay = true;

void setup() {
  size(800, 600);
  smooth();
  fishes = new ArrayList<Fish>();
  foods = new ArrayList<Food>();
  bubbles = new ArrayList<Bubble>();
  seaweeds = new ArrayList<Seaweed>();

  // Create seaweed strands along the bottom
  for (int i = 0; i < 15; i++) {
    seaweeds.add(new Seaweed(i * 55 + random(-20, 20), height));
  }

  // Create 15 fish with random colors and positions
  for (int i = 0; i < 15; i++) {
    fishes.add(new Fish(random(width), random(height - 100),
      color(random(50,255), random(50,255), random(50,255))));
  }
}

void draw() {
  // ----- Background (Day/Night) -----
  if (isDay) {
    background(135, 206, 250); // Light blue for day
  } else {
    background(10, 10, 50);    // Dark navy for night
  }

  // Optional gradient water effect (looks better)
  drawWaterGradient();

  // ----- SEAWEED (draw first, background layer) -----
  for (Seaweed s : seaweeds) {
    s.display();
  }

  // ----- BUBBLES -----
  // Randomly spawn bubbles
  if (random(1) < 0.05) {
    bubbles.add(new Bubble(random(width), height));
  }

  for (int i = bubbles.size()-1; i >= 0; i--) {
    Bubble b = bubbles.get(i);
    b.update();
    b.display();
    if (b.isOffScreen()) bubbles.remove(i);
  }

  // ----- FISH -----
  for (Fish f : fishes) {
    f.update(foods);
    f.display();
  }

  // ----- FOOD -----
  for (int i = foods.size()-1; i >= 0; i--) {
    Food fd = foods.get(i);
    fd.update();
    fd.display();
    if (fd.isEaten || fd.y > height) {
      foods.remove(i);
    }
  }

  // ----- HUD / Instructions -----
  fill(255);
  textSize(14);
  textAlign(LEFT);
  text("Click to drop food • Move mouse to scare fish • Press 'D' to toggle Day/Night", 10, height - 10);
}

void mousePressed() {
  // Drop food particle at mouse location
  foods.add(new Food(mouseX, mouseY));

  // Optional: make small bubble burst on click
  for (int i = 0; i < 5; i++) {
    bubbles.add(new Bubble(mouseX + random(-10,10), mouseY + random(10,20)));
  }
}

void keyPressed() {
  // Toggle between day and night
  if (key == 'd' || key == 'D') {
    isDay = !isDay;
  }
}

// ----- OPTIONAL GRADIENT WATER BACKGROUND -----
void drawWaterGradient() {
  noFill();
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    int c1, c2;
    if (isDay) {
      c1 = color(135, 206, 250); // top light blue
      c2 = color(0, 100, 180);   // deeper blue bottom
    } else {
      c1 = color(10, 10, 50);
      c2 = color(0, 0, 25);
    }
    stroke(lerpColor(c1, c2, inter));
    line(0, y, width, y);
  }
}
