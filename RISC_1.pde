//=================================================================================================================================================================
class CPU {
  String[] prog;
  int acc, pc, x, y, sp;
  CPU(String file) {
    prog = loadStrings(file);
  }
  
  void clock() {
    String[] ins = prog[pc++].split(" ");
    switch(ins[0]) {
      
      case "halt":
        noLoop();
        break;
      
      case "loadi":
        acc = parseInt(ins[1]);
        break;
        
      case "load":
        acc = mem[parseInt(ins[1])];
        break;
        
      case "storei":
        mem[parseInt(ins[2])] = parseInt(ins[1]);
        break;
        
      case "add":
        acc += mem[parseInt(ins[1])];
        break;
        
      case "sub":
        acc -= mem[parseInt(ins[1])];
        break;
        
      case "mul":
        acc *= mem[parseInt(ins[1])];
        break;
        
      case "div":
        acc /= mem[parseInt(ins[1])];
        break;
        
      case "sqrt":
        acc = floor(sqrt(mem[parseInt(ins[1])]));
        break;
        
      case "asl":
        acc *= 2;
        break;
        
      case "asr":
        acc /= 2;
        break;
      
        
        
    }
  }
  
  int parseInt(String s) {
    char type = s.charAt(s.length() - 1);
    
    String val = s.subSequence(0,s.length() - 1).toString();
    
    int dat = 0;
    
    switch(type) {
      case 'H': dat = Integer.parseInt(val,16); break;
      case 'B': dat = Integer.parseInt(val,2); break;
      case 'O': dat = Integer.parseInt(val,8); break;
      default: dat = Integer.parseInt(s,10); break;
    }
    
    println(val+" "+dat);
    return dat;
  } 
  
}
//=================================================================================================================================================================

int h, w;
int[] mem = new int[256000];
int scaleFactor = 4;

CPU cpu;

void setup() { //<>//
  size(640,480);
  h = height / scaleFactor;
  w = width / scaleFactor;
  
  for(int i = 0; i < mem.length; i++) mem[i] = 0;
  cpu = new CPU("programs/Test.prg");
}

void draw() {
  background(255);
  scale(scaleFactor);
  cpu.clock();
  drawScreen();
}

void drawScreen() {
  int maxVal = 16;
   
  colorMode(RGB,maxVal);
  for(int y = 0; y < h; y++) {
    for(int x = 0; x < w; x++) {
      fill(mem[0xA000 + (y * w + x) + 0]);
      noStroke();
      rect(x,y,1,1);
    }
  }
}