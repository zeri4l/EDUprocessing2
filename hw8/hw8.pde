// 펭귄 관련 클래스들
penguin[] pg;
PacMan[] pacMen;
Mine[] mines;

float xx = 200, yy = 250, s = 1.0; 
boolean game = true; 
int n = 35; 

void setup() {
  size(1200, 1200);
  
  // 펭귄 초기화
  pg = new penguin[3];
  pg[0] = new redpenguin(2, 3);
  pg[1] = new bluepenguin(3, 2);
  pg[2] = new penguin(4, 5);
  
  // PacMan 초기화
  pacMen = new PacMan[6];
  for (int i = 0; i < 5; i++) {
    pacMen[i] = new PacMan();
  }
  pacMen[5] = new SpecialPacMan(width / 2, height / 2, 150);
  
  // 광산 초기화
  mines = new Mine[n];
  for (int i = 0; i < n; i++) {
    float x, y, vx, vy;
    do {
      x = random(width);
      y = random(height);
    } while (dist(x, y, xx, yy) < 100); 
    
    vx = random(1, 3);
    vy = random(1, 3);
    if (random(1) < 0.2) {
      mines[i] = new SpecialMine(x, y, vx, vy);
    } else {
      mines[i] = new Mine(x, y, vx, vy);
    }
  }
}

void draw() {
  if (game) {
    background(120, 255, 0);
    
    // 키 입력 처리
    if (keyPressed) {
      if (key == 'a' || key == 'A') xx -= 5;
      if (key == 'd' || key == 'D') xx += 5;
      if (key == 'w' || key == 'W') yy -= 5;
      if (key == 's' || key == 'S') yy += 5;
    }
    
    // 펭귄 그리기
    for (int i = 0; i < 3; i++) {
      pg[i].move();
      pg[i].show();
      pg[i].showFish();
      for (int j = i + 1; j < 3; j++) {
        pg[i].collide(pg[j]);
      }
    }

    // PacMan 그리기
    for (int i = 0; i < pacMen.length; i++) {
      pacMen[i].act();
      pacMen[i].drawPacMan();
      for (int j = i + 1; j < pacMen.length; j++) {
        pacMen[i].collide(pacMen[j]);
      }
    }

    // 광산 그리기 및 충돌 체크
    for (Mine mine : mines) {
      mine.update();
      mine.display();
      if (mine.checkCollision(xx, yy, 75 * s)) {
        gameOver();
        return; 
      }
    }
    
    drawMinsu(xx, yy, s);
  }
}

void gameOver() {
  background(255); 
  textSize(30);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Game Over", width / 2, height / 2);
  game = false;
}

void drawMinsu(float xx, float yy, float m) {
  stroke(0);
  fill(250, 224, 212);
  ellipse(xx, yy, 100 * m, 200 * m); // 얼굴
  fill(255);
  circle(xx - 50 * m, yy - 10 * m, 40 * m); // 왼쪽 눈
  circle(xx + 50 * m, yy - 10 * m, 40 * m); // 오른쪽 눈
  fill(250, 224, 212);
  rect(xx - 10 * m, yy - 30 * m, 20 * m, 80 * m); // 코
  fill(0);
  circle(xx - 55 * m, yy - 10 * m, 25 * m); // 왼쪽 동공
  circle(xx + 55 * m, yy - 10 * m, 25 * m); // 오른쪽 동공
  fill(255, 0, 0);
  arc(xx - 10 * m, yy + 80 * m, 40 * m, 20 * m, 0, PI); // 입
  noStroke();
  fill(153, 103, 0);
  ellipse(xx, yy - 70 * m, 220 * m, 50 * m); // 모자
  circle(xx, yy - 100 * m, 100 * m); // 모자
}
// 펭귄 클래스
class penguin {
  float x, y, d, vx, vy;
  fish myFish;

  penguin(float ax, float ay) {
    x = random(700);
    y = random(700);
    d = 50;
    vx = ax;
    vy = ay;
    myFish = new fish(x, y - d * 0.75);
  }
  
  void collide(penguin b) {
    float dd = dist(x, y, b.x, b.y);
    if (dd < (d + b.d) / 1.5) {
      float tempVx = vx;
      vx = b.vx;
      b.vx = tempVx;
      float tempVy = vy;
      vy = b.vy;
      b.vy = tempVy;
    }
  } 
  
  void show() {
    stroke(0);
    strokeWeight(d * 0.06);
    fill(255);
    ellipse(x, y, d, d * 1.5);
    strokeWeight(1);
    
    fill(0);
    ellipse(x, y - d * 0.5, d * 0.75, d * 0.75);
    
    fill(0);
    strokeWeight(d * 0.0275);
    ellipse(x - d * 0.15, y - d * 0.6, d * 0.1, d * 0.1);
    ellipse(x + d * 0.15, y - d * 0.6, d * 0.1, d * 0.1);
    
    fill(255, 165, 0);
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
    
    fill(0);
    ellipse(x - d * 0.2, y + d * 0.8, d * 0.4, d * 0.2);
    ellipse(x + d * 0.2, y + d * 0.8, d * 0.4, d * 0.2);
  }
  
  void move() {
    x += vx;
    y += vy;

    if (x > width || x < 0) {
      vx = -vx;
    } 
    if (y > height || y < 0) {
      vy = -vy;
    }
    
    myFish.updatePosition(x, y - d * 0.2);
  }

  void showFish() {
    myFish.show();
  }

  class fish {
    float x, y, size;

    fish(float x, float y) {
      this.x = x;
      this.y = y;
      this.size = 30;
    }

    void show() {
      fill(255, 200, 0);
      ellipse(x, y, size, size * 0.5);
      fill(0, 150, 255);
      triangle(x - size / 2, y, 
               x - size, y - size * 0.2, 
               x - size, y + size * 0.2);
    }
        void updatePosition(float newX, float newY) {
      this.x = newX;
      this.y = newY; // 생선 위치 업데이트
    }
  }
}

// 붉은 펭귄 클래스
class redpenguin extends penguin {
  redpenguin(float ax, float ay) {
    super(ax, ay);
  }
  
  void show() {
    super.show(); // 기본 펭귄 모양 그리기
    fill(255, 0, 0); // 붉은색
    ellipse(x, y + 9, d * 0.7, d * 0.8); // 붉은색 배
  }
}

// 푸른 펭귄 클래스
class bluepenguin extends penguin {
  bluepenguin(float ax, float ay) {
    super(ax, ay);
  }
  
  void show() {
    super.show(); // 기본 펭귄 모양 그리기
    fill(0, 0, 255); // 푸른색
    ellipse(x, y + 9, d * 0.7, d * 0.8); // 푸른색 배
  }
}

// PacMan 클래스
class PacMan {
  float x, y, d, vx, vy;

  // 기본 생성자
  PacMan() {
    x = random(0, width);
    y = random(0, height);
    d = random(100, 200);
    vx = random(-3, 3);
    vy = random(-2, 2);
  }

  // 매개변수 생성자
  PacMan(float p, float q, float r) {
    x = p;
    y = q;
    d = r;
    vx = random(-3, 3);
    vy = random(-2, 2);
  }

  // 충돌 처리
  void collide(PacMan b) {
    float dd = dist(x, y, b.x, b.y);
    if (dd < (d + b.d) / 4) {
      vx = vy = 0;
      b.vx = b.vy = 0;
    }
  }

  // 움직임 처리
  void act() {
    x += vx;
    y += vy;
    if (x > width) x = 0;
    if (x < 0) x = width;
    if (y > height) y = 0;
    if (y < 0) y = height;
  }

  // Pac-Man 그리기
  void drawPacMan() {
    fill(255, 255, 0); // 노란색으로 설정
    arc(x, y, d, d, radians(45), radians(315)); // Pac-Man의 몸체
    Eye eye = new Eye(); // Class-in-Class 사용
    eye.drawEye(x, y, d); // 눈 그리기
  }

  // Class-in-Class 구조: Pac-Man의 Eye
  class Eye {
    void drawEye(float cx, float cy, float size) {
      fill(0); // 검은색
      ellipse(cx + size / 5, cy - size / 5, size / 10, size / 10); // 눈의 위치와 크기
    }
  }
}

// SpecialPacMan 클래스: PacMan 클래스 상속
class SpecialPacMan extends PacMan {
  SpecialPacMan(float p, float q, float r) {
    super(p, q, r); // 부모 클래스 생성자 호출
  }

  // 색상 변경 및 더 큰 Pac-Man으로 그리기
  @Override
  void drawPacMan() {
    fill(255, 0, 0); // 빨간색
    arc(x, y, d * 1.2, d * 1.2, radians(30), radians(330)); // 더 큰 Pac-Man
    Eye eye = new Eye();
    eye.drawEye(x, y, d * 1.2); // 눈도 크기에 맞게 조정
  }
}

// 광산 클래스들
class Mine {
  float x, y, vx, vy;

  Mine(float x, float y, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
  }

  void update() {
    x += vx;
    y += vy;
    if (x > width || x < 0) vx = -vx;
    if (y > height || y < 0) vy = -vy;
  }

  void display() {
    fill(255);
    stroke(0);
    circle(x, y, 50);
  }

  boolean checkCollision(float mx, float my, float radius) {
    float distance = dist(x, y, mx, my);
    return distance < 50 / 2 + radius; 
  }
}

class SpecialMine extends Mine {
  SpecialMine(float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
  }

  @Override
  void display() {
    fill(255, 0, 0);
    stroke(0);
    circle(x, y, 70);
  }

  @Override
  boolean checkCollision(float mx, float my, float radius) {
    float distance = dist(x, y, mx, my);
    return distance < 70 / 2 + radius; 
  }
}
