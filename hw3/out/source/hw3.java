/* autogenerated by Processing revision 1293 on 2024-09-25 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class hw3 extends PApplet {

float x1, y1, d1;
public void setup() {
  /* size commented out by preprocessor */;
  
  x1=100;
  y1=450;
  d1=200;
  }

public void draw(){
    background(255);
    
    penguin(x1, y1, d1);
    if (x1<width && x1>0) x1+=2; 
    else {
        x1=0; 
    } 
    
    

}



public void penguin(float x, float y, float d){
  background(255); // 흰색 배경
   // 펭귄 몸통
  stroke(0);
  strokeWeight(d*0.06f);
  fill(255); // white
  ellipse(x, y, d, d * 1.5f); // 몸통
  strokeWeight(1);
   
  // 펭귄 머리
  fill(0); // 검은색
  ellipse(x, y - d * 0.5f, d * 0.75f, d * 0.75f); // 머리
  
  // 눈
  stroke(255);
  strokeWeight(d*0.0275f);
  fill(0); // blk
  ellipse(x - d * 0.15f, y - d * 0.6f, d * 0.1f, d * 0.1f); // 왼쪽 눈
  ellipse(x + d * 0.15f, y - d * 0.6f, d * 0.1f, d * 0.1f); // 오른쪽 눈
  strokeWeight(1);
  
  // 부리
  fill(255, 165, 0); // 주황색
  stroke(0);
  beginShape();
  vertex(x - d * 0.1f, y - d * 0.4f);
  vertex(x, y - d * 0.35f);
  vertex(x + d * 0.1f, y - d * 0.4f); 
  vertex(x, y - d * 0.45f); 
  vertex(x - d * 0.1f, y - d * 0.4f);
  vertex(x + d * 0.1f, y - d * 0.4f); 
  endShape(CLOSE);
  
  // 왼쪽 팔 (사선)
  fill(0); // 검은색
  beginShape();
  vertex(x - d * 0.4f, y - d * 0.2f); // 팔 시작점
  vertex(x - d * 0.8f, y + d * 0.3f); // 팔 끝점
  vertex(x - d * 0.55f, y - d * 0.2f); // 팔 끝점
  endShape(CLOSE);
  
  // 오른쪽 팔 (사선)
  fill(0); // 검은색
  beginShape();
  vertex(x + d * 0.4f, y - d * 0.2f); // 팔 시작점
  vertex(x + d * 0.8f, y + d * 0.3f); // 팔 끝점
  vertex(x + d * 0.55f, y - d * 0.2f); // 팔 끝점
  endShape(CLOSE);
  
  // 발
  fill(0); // 검은색
  ellipse(x - d * 0.2f, y + d * 0.8f, d * 0.4f, d * 0.2f); // 왼쪽 발
  ellipse(x + d * 0.2f, y + d * 0.8f, d * 0.4f, d * 0.2f); // 오른쪽 발
  
}


  public void settings() { size(700, 700); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "hw3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
