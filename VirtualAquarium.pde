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
      color(random(100,255), random(50,255), random(75,255))));
  }
}

void draw() {
  // ----- Background (Day/Night) -----
  if (isDay) {
    background(100, 180, 255); // Light blue for day
  } else {
    background(15, 20, 70);    // Dark navy for night
  }

  // Optional gradient water effect (looks better)
  drawWaterGradient();

  // ----- SEAWEED (draw first, background layer) -----
  for (Seaweed seaweed : seaweeds) {
    seaweed.display();
  }

  // ----- BUBBLES -----
  // Randomly spawn bubbles
  if (random(1) < 0.05) {
    bubbles.add(new Bubble(random(width), height));
  }

  for (int i = bubbles.size()-1; i >= 0; i--) {
    Bubble bubble = bubbles.get(i);
    bubble.update();
    bubble.display();
    if (bubble.isOffScreen()) bubbles.remove(i);
  }

  // ----- FISH -----
  for (Fish fish : fishes) {
    fish.update(foods);
    fish.display();
  }

  // ----- FOOD -----
  for (int i = foods.size()-1; i >= 0; i--) {
    Food food = foods.get(i);
    food.update();
    food.display();
    if (food.isEaten || food.posY > height) {
      foods.remove(i);
    }
  }

  // ----- HUD / Instructions -----
  fill(255);
  textSize(14);
  textAlign(LEFT);
  text("Click to drop food • Move mouse to scare fish • Press Space to toggle Day/Night", 15, height - 15);
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
  // Toggle between day and night with spacebar
  if (key == ' ' || key == ' ') {
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
      c1 = color(100, 180, 255); // bright blue top
      c2 = color(20, 60, 130);   // deep ocean blue
    } else {
      c1 = color(15, 20, 70);    // dark indigo night
      c2 = color(5, 10, 30);     // very dark blue bottom
    }




    stroke(lerpColor(c1, c2, inter));
    line(0, y, width, y);
  }
}
