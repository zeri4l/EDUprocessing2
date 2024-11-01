/* 캐릭터를 조종하여 장애물을 피하는 게임을 만들고자 함 */
/* 캐릭터를 wasd로 조종할 수 있게 함 */
/* 장애물이 랜덤 위치에서 나타나고 속도도 랜덤으로 설정함 (최대 3)*/
/* 장애물이 벽에 닿으면 튕기도록 함 */
/* 캐릭터는 랜덤 스폰이고 속도는 10으로 설정 */
/* 캐릭터의 위치는 size(1000, 600); 의 사각형을 넘지 못하게 함 */
/* 장애물에 닿을 시 (dist 25 이내) 화면 색이 변화하고 game over 문구를 띄움 */


float []x, y, gg, vx, vy;
int n = 10;

void setup() {
    size(1000, 600);

    x = new float[n];
    y = new float[n];
    gg = new float[n];
    vx = new float[n];
    vy = new float[n];

    for (int i = 0; i < n; i++) {
        x[i] = random(width);
        y[i] = random(height);
        gg[i] = random(255);
        vx[i] = random(3);
        vy[i] = random(3);
    }
    vx[4] = vy[4] = 0; // 4번 smile의 랜덤 변화 속도를 0으로 설정
}

void draw() {
    background(255, 255, 0);
    
    // 게임 오버 
    for (int k = 0; k < n; k++) {
        if (k != 4 && dist(x[4], y[4], x[k], y[k]) < 25) { // 충돌 감지
            gameOver();
            return; // 게임 오버 상태일 때 더 이상 그리지 않음
        }
    }

    for (int i = 0; i < n; i++) {
        x[i] += vx[i];
        y[i] += vy[i];

        if (x[i] > width || x[i] < 0) vx[i] = -vx[i];
        if (y[i] > height || y[i] < 0) vy[i] = -vy[i];

        // i가 4인 경우 빨간색, 나머지 경우 흰색
        if (i == 4) {
            smile(x[i], y[i], color(255, 0, 0)); // 빨간색
        } else {
            smile(x[i], y[i], color(255)); // 흰색
        }
    }
}

void keyPressed() {
    if (key == 'a') x[4] = constrain(x[4] - 10, 0, width); // 범위 설정
    else if (key == 'd') x[4] = constrain(x[4] + 10, 0, width);
    else if (key == 'w') 
    if (height > y[4] && 0 < y[4]) {
        y[4] -= 10; }
    else if (key == 's') 
    if (height > y[4] && 0 < y[4]) {
        y[4] += 10;
    }
}

void mousePressed() {
    for (int i = 0; i < n; i++) {
        if (dist(x[i], y[i], mouseX, mouseY) < 25) {
            vx[i] = 0;
            vy[i] = 0;
            gg[i] = 255;
        }
    }
}

void smile(float a, float b, color c) {
    fill(c); 
    circle(a, b, 50);
    circle(a - 10, b - 10, 10);
    circle(a + 10, b - 10, 10);
}

void gameOver() {
    background(255, 0, 0);
    textSize(40);
    textAlign(CENTER, CENTER); // 텍스트 정렬
    text("Gameover!!", width / 2, height / 2);
}
