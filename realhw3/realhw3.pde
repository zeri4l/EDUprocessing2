/*
1. 키보드의 w, a, s, d 키를 이용하여 캐릭터를 이동할 수 있게함.
2. 마우스의 클릭을 통해 캐릭터의 위치를 변화할 수 있게함.
3. 마우스 휠을 사용하여 캐릭터의 크기를 조정할 수 있게함.
4. 약 16.6ms 마다 배경화면의 색에 변화를 줌. 
4-1.먼저 배경의 rgb값을 #000000으로 설정
4-2. 16.6ms마다 b, g, r순서로 0부터 255까지 채운다. 
5. 키보드의 r, g, b키를 누르면 캐릭터의 얼굴색이 각각 빨간색, 녹색, 파란색으로 변하게 함
*/

float x,y,d;
int frames = 0;
int c;
int j,k,l;
void setup(){
  size(300,600);
  x = y = 100;    d = 100;
  c = 5;
  j=k=l=0;
  frameRate(60);
}
void draw(){
    frames++;
    if(l<255){ /* 배경 그라데이션*/
        l++;
    }
    else if (l==255 && k<255) {
        k++;
    }
    else if (k==255 && j<255) {
        j++;
    }
    else if (j==255){
      j=k=l=0;
    }
  background(j,k,l);
  penguin(x,y,d,c);
}
void mouseClicked(){
  x = mouseX;    y = mouseY;
}
void mouseWheel(MouseEvent ee){
  float e = ee.getCount();
  if(e>0) d *= 1.1;
  else if(e<0) d *= 0.9;
}
void keyPressed(){
  if(key == 'a') x -= 5;
  else if(key == 'd') x += 5;
  else if(key == 'w') y -= 5;
  else if(key == 's') y += 5;
  else if(key == 'r') c = 1;
  else if(key == 'g') c = 0;
  else if(key == 'b') c = 2;
  else if (key == ' ') {
        int p=frames;
        if(frames < p){ /* 배경 그라데이션*/
        x++;
    }
    else if (l==255 && k<255) {
        k++;
    }
    }
  
  
}

void penguin(float x, float y, float d, float c){
  
   // 펭귄 몸통
  stroke(0);
  strokeWeight(d*0.06);
  fill(255); // white
  ellipse(x, y, d, d * 1.5); // 몸통
  strokeWeight(1);
   
  // 펭귄 머리
 if (c==1) fill(255,0,0); // 검은색
 else if (c==0) fill(0,255,0);
 else if (c==2) fill(255,0,0);
 else fill(0);
  ellipse(x, y - d * 0.5, d * 0.75, d * 0.75); // 머리
  
  // 눈
  stroke(255);
  strokeWeight(d*0.0275);
  fill(0); // blk
  ellipse(x - d * 0.15, y - d * 0.6, d * 0.1, d * 0.1); // 왼쪽 눈
  ellipse(x + d * 0.15, y - d * 0.6, d * 0.1, d * 0.1); // 오른쪽 눈
  strokeWeight(1);
  
  // 부리
  fill(255, 165, 0); // 주황색
  stroke(0);
  beginShape();
  vertex(x - d * 0.1, y - d * 0.4);
  vertex(x, y - d * 0.35);
  vertex(x + d * 0.1, y - d * 0.4); 
  vertex(x, y - d * 0.45); 
  vertex(x - d * 0.1, y - d * 0.4);
  vertex(x + d * 0.1, y - d * 0.4); 
  endShape(CLOSE);
  
  // 왼쪽 팔 (사선)
  fill(0); // 검은색
  beginShape();
  vertex(x - d * 0.4, y - d * 0.2); // 팔 시작점
  vertex(x - d * 0.8, y + d * 0.3); // 팔 끝점
  vertex(x - d * 0.55, y - d * 0.2); // 팔 끝점
  endShape(CLOSE);
  
  // 오른쪽 팔 (사선)
  fill(0); // 검은색
  beginShape();
  vertex(x + d * 0.4, y - d * 0.2); // 팔 시작점
  vertex(x + d * 0.8, y + d * 0.3); // 팔 끝점
  vertex(x + d * 0.55, y - d * 0.2); // 팔 끝점
  endShape(CLOSE);
  
  // 발
  fill(0); // 검은색
  ellipse(x - d * 0.2, y + d * 0.8, d * 0.4, d * 0.2); // 왼쪽 발
  ellipse(x + d * 0.2, y + d * 0.8, d * 0.4, d * 0.2); // 오른쪽 발
  
  
  

}

