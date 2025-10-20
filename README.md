# Virtual Aquarium Simulation
An interactive Processing sketch that simulates a lively aquarium ecosystem with schooling fish, swaying plants, rising bubbles, and responsive feeding behavior. The project demonstrates animation systems, basic AI steering, and user-driven environmental changes.

---

## Highlights
- 15+ autonomous fish with animated tails, energy bars, and hunger-driven steering
- Click-to-drop food pellets that sink, disperse bubbles, and can be eaten to restore energy
- Mouse proximity acts like a predator, steering nearby fish away
- Procedural seaweed strands and bubble particles add ambient motion
- Day/night toggle that shifts the underwater gradient and overall ambience

---

## Getting Started
1. Install the Processing IDE (https://processing.org/download).
2. Download or clone this repository and keep all `.pde` files in the same folder.
3. Open `VirtualAquarium.pde` in Processing.
4. Press the **Run** ▶ button to launch the aquarium.
5. If the sketch fails to start, confirm the Processing version is 4.x and that Java mode is active.

**Quick Reset:** If the scene becomes cluttered with food, stop the sketch (`Ctrl/Cmd + .`) and run it again.

---

## Controls & Interactions
- Mouse click: Drop food pellets (fish chase and eat them) and spawn extra bubbles
- Mouse movement: Scares fish within 100 pixels, causing evasive steering
- `Space`: Toggle between daytime and nighttime lighting

Suggested demos for presentations:
1. Drop several food pellets near a school of fish to showcase crowd behavior.
2. Move the cursor quickly through the aquarium to demonstrate predator avoidance.
3. Toggle day/night mid-demo to highlight the gradient transition.

---

## Project Structure
- `VirtualAquarium.pde`: Entry point, world setup, draw loop, gradient background, and HUD text
- `Fish.pde`: Fish class with movement, steering toward food, mouse avoidance, energy tracking, and health bar rendering
- `Food.pde`: Sinking food pellets that can be consumed by fish
- `Bubble.pde`: Lightweight particle system for rising bubbles with horizontal drift
- `Seaweed.pde`: Procedurally generated seaweed strands that sway over time

Keep all files together; Processing treats each `.pde` file as part of the same sketch. Splitting files makes it easier to showcase object-oriented design in the PDF report.

---

## How It Works
- **Environment loop:** `draw()` refreshes the background gradient, updates seaweed, spawns bubbles, and orchestrates all entities.
- **Fish AI:** Each fish tracks energy, steers toward the nearest food within range, flees the cursor when threatened, and caps its velocity to maintain smooth motion.
- **Energy system:** Energy slowly decays; eating food restores it and changes the color of the on-screen health bar.
- **Particles & plants:** Bubbles drift upward and vanish off-screen, while seaweed strands use sin-based offsets for natural swaying.

Key parameters (tweak in code for experimentation):
- Fish count: `setup()` → change the loop that instantiates fish
- Energy decay: `Fish.update()` → adjust `energy_level -= 0.02`
- Bubble spawn rate: `draw()` → tweak the `random(1) < 0.05` threshold

---

## Example Output
Add a screenshot or animated GIF (e.g., `day-mode.png` and `night-mode.png`) showing:
- Fish chasing food during the day
- Night mode gradient with glowing fish outlines
- HUD instructions at the bottom of the screen

If including the media in a PDF, reference the same filenames so the README and report match.

