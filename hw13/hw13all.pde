PVector pacmanPos, ghostPos;
float pacmanAngle = 0, ghostAngle = 0;
boolean birdView = true;

void setup() {
  size(800, 800, P3D);
  pacmanPos = new PVector(-200, 0, 0);
  ghostPos = new PVector(200, 0, 0);
}

void draw() {
  background(50);
  
  // 카메라 설정
  if (birdView) {
    camera(width/2.0, -400, 400, width/2.0, height/2.0, 0, 0, 0, -1);
  } else {
    PVector fpsPos = PVector.add(pacmanPos, new PVector(0, -50, 50));
    camera(fpsPos.x, fpsPos.y, fpsPos.z, ghostPos.x, ghostPos.y, ghostPos.z, 0, 1, 0);
  }
  
  // 조명 설정
  lights();
  
  // 바닥
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(HALF_PI);
  fill(100, 100, 100);
  noStroke();
 
  popMatrix();

  // 팩맨 그리기
  pushMatrix();
  translate(width/2 + pacmanPos.x, height/2 + pacmanPos.y, pacmanPos.z);
  rotateZ(pacmanAngle);
  fill(255, 255, 0);
  noStroke();
  arc(0, 0, 50, 50, QUARTER_PI, TWO_PI - QUARTER_PI, PIE);
  popMatrix();
  
  // 유령 그리기
  pushMatrix();
  translate(width/2 + ghostPos.x, height/2 + ghostPos.y, ghostPos.z);
  rotateZ(ghostAngle);
  fill(255, 0, 0);
  noStroke();
  sphere(30); // 유령 몸체
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

void keyPressed() {
  if (key == 'v') {
    birdView = !birdView; // 카메라 전환
  }
}
