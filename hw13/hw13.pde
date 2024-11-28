int numPins = 10; // 볼링핀 개수
BowlingBall ball;
BowlingPin[] pins = new BowlingPin[numPins];
float laneWidth = 200; // 레인 너비
float laneLength = 800; // 레인 길이
boolean isBirdEyeView = true; // 기본 카메라 시점 여부

void setup() {
  size(800, 600, P3D);
  ball = new BowlingBall();
  
  // 볼링핀 위치 설정 (역삼각형 대형)
  pins[0] = new BowlingPin(0, 0, 100); // 1st row (1 pin)
  pins[1] = new BowlingPin(-20, 0, 130); // 2nd row (2 pins)
  pins[2] = new BowlingPin(20, 0, 130);
  pins[3] = new BowlingPin(-40, 0, 160); // 3rd row (3 pins)
  pins[4] = new BowlingPin(0, 0, 160);
  pins[5] = new BowlingPin(40, 0, 160);
  pins[6] = new BowlingPin(-60, 0, 190); // 4th row (4 pins)
  pins[7] = new BowlingPin(-20, 0, 190);
  pins[8] = new BowlingPin(20, 0, 190);
  pins[9] = new BowlingPin(60, 0, 190);
}


void draw() {
  background(200);
  lights();
  
    // 카메라 설정
  if (isBirdEyeView) {
    // 조감도(볼링공이 굴러가는 반대 방향)
    translate(width / 2, height / 2, 200);
    rotateX(-PI / 6);
  } else {
    // 볼링공 시점
    float camX = ball.x;
    float camY = ball.y + 10; // 볼링공 바로 위에서 약간 떨어진 위치
    float camZ = ball.z - 20; // 볼링공 앞쪽에서 바라보도록

    // 카메라 위치 설정
    camera(camX, camY, camZ, camX, ball.y, ball.z, 0, 1, 0);
  }
  
  // 레인 그리기 (베이지색)
  fill(210, 180, 140); // 베이지색
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
}

void keyPressed() {
  if (key == 'a') {
    ball.move(-5);
  } else if (key == 'd') {
    ball.move(5);
  } else if (key == ' ') { // 스페이스바를 눌렀을 때
    ball.roll(); // 볼링공 굴리기
  } else if (key == 'v') { // 'v' 키를 눌렀을 때
    isBirdEyeView = !isBirdEyeView; // 조감도와 볼링공 시점 전환
  }
}

class BowlingBall {
  float x, y, z;
  boolean isRolling = false; // 볼링공이 굴러가는 상태

  BowlingBall() {
    x = 0;
    y = -20; // 볼링공 위치를 레인 위로 조정
    z = 0;
  }
  
  void move(float dx) {
    x += dx;
  }
  
  void roll() {
    isRolling = true; // 굴러가는 상태로 변경
  }
  
  void update() {
    if (isRolling) {
      z += 5; // 볼링공 굴러가는 속도
      // 너무 멀리 나가면 굴림 중지
      if (z > laneLength) {
        isRolling = false;
        z = 0; // 다시 시작 위치로
      }
    }
  }
  
  void display() {
    pushMatrix();
    translate(x, y, z);
    fill(255, 0, 0);
    sphere(10); // 볼링공 크기
    popMatrix();
  }
  
  boolean hit(BowlingPin pin) {
    float d = dist(x, z, pin.x, pin.z);
    return d < 15; // 충돌 감지 거리
  }
}

class BowlingPin {
  float x, y, z;
  boolean isHit = false; // 핀 맞았는지 여부

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
      // 역삼각형 그리기
      beginShape(TRIANGLES);
      vertex(0, -20, 0); // 꼭대기
      vertex(-10, 0, 10); // 왼쪽 아래
      vertex(10, 0, 10); // 오른쪽 아래
      
      vertex(0, -20, 0); // 꼭대기
      vertex(10, 0, 10); // 오른쪽 아래
      vertex(10, 0, -10); // 오른쪽 아래 뒷면
      
      vertex(0, -20, 0); // 꼭대기
      vertex(10, 0, -10); // 오른쪽 아래 뒷면
      vertex(-10, 0, -10); // 왼쪽 아래 뒷면

      vertex(0, -20, 0); // 꼭대기
      vertex(-10, 0, -10); // 왼쪽 아래 뒷면
      vertex(-10, 0, 10); // 왼쪽 아래
      
      endShape();
      popMatrix();
    }
  }
  
  void hit() {
    isHit = true; // 핀이 맞았을 때 처리
  }
}
