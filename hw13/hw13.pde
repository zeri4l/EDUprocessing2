int numPins = 10; // 볼링핀 개수
BowlingBall ball;
BowlingPin[] pins = new BowlingPin[numPins];
float laneWidth = 200; // 레인 너비
float laneLength = 800; // 레인 길이
boolean isBirdEyeView = true; // 기본 카메라 시점 여부

void setup() {
  size(800, 600, P3D);
  ball = new BowlingBall();
  
  // 볼링핀 위치 설정
  for (int i = 0; i < numPins; i++) {
    float x = (i % 4) * 20 - 30;
    float z = (i / 4) * 30 + 100;
    pins[i] = new BowlingPin(x, 0, z);
  }
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
    translate(ball.x, ball.y, ball.z); // 볼링공 바로 뒤에서 바라보도록 조정
    //rotateX(PI / 6); // 약간 아래를 바라보게
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
      box(5, 20, 5); // 볼링핀 크기
      popMatrix();
    }
  }
  
  void hit() {
    isHit = true; // 핀이 맞았을 때 처리
  }
}
