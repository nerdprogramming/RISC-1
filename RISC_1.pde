import processing.sound.*;

//=================================================================================================================================================================

//=================================================================================================================================================================

int h, w;
int[] mem = new int[2560000];
int scaleFactor = 8;
int dumpStart = 0x9000;
boolean debug = true;

CPU cpu;
APU apu;

void setup() {
  size(640,480);
  h = height / scaleFactor;
  w = width / scaleFactor;
  
  for(int i = 0; i < mem.length; i++) mem[i] = 0;
  cpu = new CPU("programs/Test.prg");
  apu = new APU();
}

void draw() {
  background(255);
  scale(scaleFactor);
  for(int i = 0; i < 10 & !cpu.H; i++) {
    cpu.clock();
    apu.tick();
  }
  drawScreen();
  
  
  if(debug) {
    println("A: "+cpu.acc+" PC: "+cpu.pc+" X: "+cpu.x+" Y: "+cpu.y);
    for(int y = 0; y < 16; y++) {
      for(int x = 0; x < 16; x++) {
        print(" "+mem[dumpStart + (y * w + x) + 0]);
      }
      println();
    }
  }
  
}

void drawScreen() {
  int maxValR = 16;
  int maxValG = 16;
  int maxValB = 16;
   
  colorMode(RGB,maxValR,maxValG,maxValB);
  for(int y = 0; y < h; y++) {
    for(int x = 0; x < w; x++) {
      fill(toCGA(mem[0xA000 + (y * w + x) + 0]));
      noStroke();
      rect(x,y,1,1);
    }
  }
  stroke(10);
}


color toCGA(int num) {
  num %= 8;
  color out = color(0,0,0);
  
  switch(num) {
    case 1: out = color(000,000,255); break;
    case 2: out = color(000,255,000); break;
    case 3: out = color(000,255,255); break;
    case 4: out = color(255,000,000); break;
    case 5: out = color(255,000,255); break;
    case 6: out = color(255,255,000); break;
    case 7: out = color(255,255,255); break;
  }
  
  return out;
}
