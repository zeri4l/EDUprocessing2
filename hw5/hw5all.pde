// Declare objects and variables
penguin pg;
character minsu;
Pacman pacman;

void setup() {
  size(700, 700);
  
  // Initialize each character and their specific attributes
  pg = new penguin();
  minsu = new character(200, 250, 1.0);
  pacman = new Pacman(width / 2, height / 2, 30);
}

void draw() {
  background(120, 255, 0); // Set a background color for better visibility
  
  // 1. Display and move the Penguin
  pg.move();
  pg.show();
  
  // 2. Display and move Minsu character
  minsu.display();
  
  // 3. Display and move Pacman
  pacman.move();
  pacman.display();
}

void keyPressed() {
  // Control Minsu's movement
  minsu.move(key);
}

// Penguin class
class penguin {
  float x, y, d, vx, vy;

  penguin() {
    x = 100;
    y = 150;
    d = 100;
    vx = 2;
    vy = 3;
  }

  void show() {
    stroke(0);
    strokeWeight(d * 0.06);
    fill(255);
    ellipse(x, y, d, d * 1.5);
    strokeWeight(1);

    fill(0);
    ellipse(x, y - d * 0.5, d * 0.75, d * 0.75);

    stroke(255);
    strokeWeight(d * 0.0275);
    fill(0);
    ellipse(x - d * 0.15, y - d * 0.6, d * 0.1, d * 0.1);
    ellipse(x + d * 0.15, y - d * 0.6, d * 0.1, d * 0.1);
    strokeWeight(1);

    fill(255, 165, 0);
    stroke(0);
    beginShape();
    vertex(x - d * 0.1, y - d * 0.4);
    vertex(x, y - d * 0.35);
    vertex(x + d * 0.1, y - d * 0.4); 
    vertex(x, y - d * 0.45); 
    endShape(CLOSE);

    fill(0);
    beginShape();
    vertex(x - d * 0.4, y - d * 0.2);
    vertex(x - d * 0.8, y + d * 0.3);
    vertex(x - d * 0.55, y - d * 0.2);
    endShape(CLOSE);

    beginShape();
    vertex(x + d * 0.4, y - d * 0.2);
    vertex(x + d * 0.8, y + d * 0.3);
    vertex(x + d * 0.55, y - d * 0.2);
    endShape(CLOSE);

    ellipse(x - d * 0.2, y + d * 0.8, d * 0.4, d * 0.2);
    ellipse(x + d * 0.2, y + d * 0.8, d * 0.4, d * 0.2);
  }

  void move() {
    x += vx;
    y += vy;
    if (x > width || x < 0) vx = -vx;
    if (y > height || y < 0) vy = -vy;
  }
}

// Minsu class
class character {
  float x, y, size;

  character(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  void display() {
    float m = size;
    stroke(0);
    fill(250, 224, 212);
    ellipse(x, y, 100 * m, 200 * m);
    fill(255);
    circle(x - 50 * m, y - 10 * m, 40 * m);
    circle(x + 50 * m, y - 10 * m, 40 * m);
    fill(250, 224, 212);
    rect(x - 10 * m, y - 30 * m, 20 * m, 80 * m);
    fill(0);
    circle(x - 55 * m, y - 10 * m, 25 * m);
    circle(x + 55 * m, y - 10 * m, 25 * m);
    fill(255, 0, 0);
    arc(x - 10 * m, y + 80 * m, 40 * m, 20 * m, 0, PI);
    noStroke();
    fill(153, 103, 0);
    ellipse(x, y - 70 * m, 220 * m, 50 * m);
    circle(x, y - 100 * m, 100 * m);
  }

  void move(char direction) {
    if (direction == 'a') x -= 5;
    else if (direction == 'd') x += 5;
    else if (direction == 'w') y -= 5;
    else if (direction == 's') y += 5;
  }
}

// Pacman class
class Pacman {
  float x, y, xSpeed, ySpeed, radius;
  color pacmanColor;

  Pacman(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.xSpeed = random(-3, 3);
    this.ySpeed = random(-3, 3);
    this.pacmanColor = color(255, 255, 0);
  }

  void move() {
    x += xSpeed;
    y += ySpeed;
    if (x - radius < 0 || x + radius > width) {
      xSpeed *= -1;
      changeColor();
    }
    if (y - radius < 0 || y + radius > height) {
      ySpeed *= -1;
      changeColor();
    }
  }

  void display() {
    float angle = frameCount % 20 < 10 ? QUARTER_PI / 2 : QUARTER_PI;
    fill(pacmanColor);
    arc(x, y, radius * 2, radius * 2, angle, TWO_PI - angle, PIE);
  }

  void changeColor() {
    pacmanColor = color(random(255), random(255), random(255));
  }
}
