int numPins = 10; // 볼링핀 개수
BowlingBall ball;
BowlingPin[] pins = new BowlingPin[numPins];
float laneWidth = 200; // 레인 너비
float laneLength = 800; // 레인 길이
boolean isBirdEyeView = true; // 기본 카메라 시점 여부
float xx = 200, yy = 250, zz = 0, s = 1.0; // 미네 위치
boolean game = true, fpsView = false;
int n = 10;
Mine[] mines;
PVector pacmanPos, ghostPos;
float pacmanAngle = 0, ghostAngle = 0;

void setup() {
  size(800, 600, P3D);
  ball = new BowlingBall();
  
  // 볼링핀 위치 설정 (역삼각형 대형)
  pins[0] = new BowlingPin(0, 0, 100);
  pins[1] = new BowlingPin(-20, 0, 130);
  pins[2] = new BowlingPin(20, 0, 130);
  pins[3] = new BowlingPin(-40, 0, 160);
  pins[4] = new BowlingPin(0, 0, 160);
  pins[5] = new BowlingPin(40, 0, 160);
  pins[6] = new BowlingPin(-60, 0, 190);
  pins[7] = new BowlingPin(-20, 0, 190);
  pins[8] = new BowlingPin(20, 0, 190);
  pins[9] = new BowlingPin(60, 0, 190);
  
  mines = new Mine[n];
  for (int i = 0; i < n; i++) {
    float x = random(width);
    float y = random(height);
    float z = random(-500, 500);
    float vx = random(1, 3);
    float vy = random(1, 3);
    float vz = random(1, 3);
    mines[i] = new Mine(x, y, z, vx, vy, vz);
  }

  pacmanPos = new PVector(-200, 0, 0);
  ghostPos = new PVector(200, 0, 0);
}

void draw() {
  if (game) {
    background(200);
    lights();

    // 카메라 설정
    if (isBirdEyeView) {
    // 조감도: 볼링공의 뒤쪽에서 바라보도록 설정
    float camX = ball.x;
    float camY = ball.y - 50; // 볼링공 위쪽에서
    float camZ = ball.z - 100; // 볼링공 뒤쪽에서

    // 카메라 위치 설정
    camera(camX, camY, camZ, camX, ball.y, ball.z, 0, 1, 0);
  } else {
       camera(width/2.0, -400, 400, width/2.0, height/2.0, 0, 0, 0, -1);

  }
    
    // 레인 그리기 (베이지색)
    fill(210, 180, 140);
    box(laneWidth, 10, laneLength);
    
    // 볼링핀 그리기
    for (BowlingPin pin : pins) {
      pin.display();
    }
    
    // 볼링공 그리기
    ball.update();
    ball.display();
    
    // 충돌 검사
    for (BowlingPin pin : pins) {
      if (ball.hit(pin)) {
        pin.hit();
      }
    }
    
    //  그리기
    for (Mine mine : mines) {
      mine.update();
      mine.display();
      if (mine.checkCollision(xx, yy, zz, 50 * s)) {

        return;
      }
    }
    
    // 팩맨과 유령 그리기
    drawPacmanAndGhost();
    drawMinsu(xx, yy, zz, s);
  }
}
void drawMinsu(float xx, float yy, float zz, float m) {
  pushMatrix();
  translate(xx, yy, zz);

  fill(250, 224, 212);
  sphere(50 * m);

  fill(0, 0, 255);
  translate(0, 100 * m, 0);
  box(80 * m, 150 * m, 50 * m);

  fill(0, 255, 0);
  pushMatrix();
  translate(-60 * m, 50 * m, 0);
  box(30 * m, 100 * m, 30 * m);
  popMatrix();

  pushMatrix();
  translate(60 * m, 50 * m, 0);
  box(30 * m, 100 * m, 30 * m);
  popMatrix();

  fill(255, 0, 0);
  translate(0, 100 * m, 0);
  pushMatrix();
  translate(-30 * m, 50 * m, 0);
  box(30 * m, 100 * m, 30 * m);
  popMatrix();

  pushMatrix();
  translate(30 * m, 50 * m, 0);
  box(30 * m, 100 * m, 30 * m);
  popMatrix();

  popMatrix();
}

void keyPressed() {
  if (key == '6') {
    ball.move(-5);
  } else if (key == '4') {
    ball.move(5);
  } else if (key == ' ') {
    ball.roll();
  } else if (key == 'v') {
    isBirdEyeView = !isBirdEyeView;
  } else if (key == 'a' || key == 'A') xx -= 5;
  else if (key == 'd' || key == 'D') xx += 5;
  else if (key == 'w' || key == 'W') yy -= 5;
  else if (key == 's' || key == 'S') yy += 5;
  else if (key == 'q' || key == 'Q') zz -= 5;
  else if (key == 'e' || key == 'E') zz += 5;
  else if (key == 'f' || key == 'F') fpsView = !fpsView;
  else if (key == 'c') {
    isBirdEyeView = !isBirdEyeView; // 카메라 전환
  }
}

void drawPacmanAndGhost() {
  // 바닥
  pushMatrix();
  translate(width / 2, height / 2, 0);
  rotateX(HALF_PI);
  fill(100, 100, 100);
  noStroke();

  popMatrix();

  // 팩맨 그리기
  pushMatrix();
  translate(width / 2 + pacmanPos.x, height / 2 + pacmanPos.y, pacmanPos.z);
  rotateZ(pacmanAngle);
  fill(255, 255, 0);
  noStroke();
  arc(0, 0, 50, 50, QUARTER_PI, TWO_PI - QUARTER_PI, PIE);
  popMatrix();
  
  // 유령 그리기
  pushMatrix();
  translate(width / 2 + ghostPos.x, height / 2 + ghostPos.y, ghostPos.z);
  rotateZ(ghostAngle);
  fill(255, 0, 0);
  noStroke();
  sphere(30);
  popMatrix();
  
  // 이동 로직
  pacmanPos.x += cos(pacmanAngle) * 2;
  pacmanPos.y += sin(pacmanAngle) * 2;
  
  ghostPos.x += cos(ghostAngle) * 1.5;
  ghostPos.y += sin(ghostAngle) * 1.5;

  // 방향 조정
  if (frameCount % 100 == 0) {
    pacmanAngle += random(-QUARTER_PI, QUARTER_PI);
    ghostAngle += random(-QUARTER_PI, QUARTER_PI);
  }
}



class BowlingBall {
  float x, y, z;
  boolean isRolling = false;

  BowlingBall() {
    x = -3;
    y = -20;
    z = -50;
  }
  
  void move(float dx) {
    x += dx;
  }
  
  void roll() {
    isRolling = true;
  }
  
  void update() {
    if (isRolling) {
      z += 5;
      if (z > laneLength) {
        isRolling = false;
        z = 0;
      }
    }
  }
  
  void display() {
    pushMatrix();
    translate(x, y, z);
    fill(255, 0, 0);
    sphere(10);
    popMatrix();
  }
  
  boolean hit(BowlingPin pin) {
    float d = dist(x, z, pin.x, pin.z);
    return d < 15;
  }
}

class BowlingPin {
  float x, y, z;
  boolean isHit = false;

  BowlingPin(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void display() {
    if (!isHit) {
      pushMatrix();
      translate(x, y, z);
      fill(255);
      beginShape(TRIANGLES);
      vertex(0, -20, 0);
      vertex(-10, 0, 10);
      vertex(10, 0, 10);
      vertex(0, -20, 0);
      vertex(10, 0, 10);
      vertex(10, 0, -10);
      vertex(0, -20, 0);
      vertex(10, 0, -10);
      vertex(-10, 0, -10);
      vertex(0, -20, 0);
      vertex(-10, 0, -10);
      vertex(-10, 0, 10);
      endShape();
      popMatrix();
    }
  }
  
  void hit() {
    isHit = true;
  }
}

class Mine {
  float x, y, z, vx, vy, vz;

  Mine(float x, float y, float z, float vx, float vy, float vz) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.vx = vx;
    this.vy = vy;
    this.vz = vz;
  }

  void update() {
    x += vx;
    y += vy;
    z += vz;

    if (x > width || x < 0) vx = -vx;
    if (y > height || y < 0) vy = -vy;
    if (z > 500 || z < -500) vz = -vz;
  }

  void display() {
    pushMatrix();
    translate(x, y, z);
    fill(255, 0, 0);
    sphere(30);
    popMatrix();
  }

  boolean checkCollision(float mx, float my, float mz, float radius) {
    float distance = dist(x, y, z, mx, my, mz);
    return distance < 30 + radius;
  }
}
