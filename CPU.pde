class CPU {
  String[] prog;
  int acc, pc, x, y, sp;
  boolean H = false;
  HashMap<String, Integer> vars = new HashMap();
  CPU(String file) {
    prog = loadStrings(file);
    
    for(String line : prog) {
      String[] sections = line.split(" ");
      println(sections[0]);
      switch(sections[0]){
        case "#include":
          String[] inc = loadStrings(sections[1]);
          prog = concat(prog,inc);
          if(debug) for(String s : prog) println(s);
          break;
      }
    }
    int lineNum = 0;
    for(String line : prog) {
      String[] sections = line.split(" ");
      if(debug) println(sections[0]);
      switch(sections[0]){
       case "#def":
         vars.put(sections[1],parseInt(sections[2]));
         break;
         
       case "#mark":
         if(debug) println("Hash Of '"+sections[1]+"': "+sections[1].hashCode());
         vars.put(sections[1],lineNum);
         break;
         
       case "#data":
         mem[parseInt(sections[2])] = parseInt(sections[1]);
         break;
      }
      if(debug) println(vars);
      lineNum++;
      
    }
    
  }
  
  void clock() {
    String[] ins = prog[pc++].split(" ");
    switch(ins[0]) {
      
      case "halt":
        H = true;
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
        
      case "store":
        mem[parseInt(ins[1])] = acc;
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
        
      case "printc":
        //placeChar(parseInt(ins[1])],parseInt(ins[2])],parseInt(ins[3])]);
        break;
        
      case "clr":
        x = 0;
        break;
        
      case "set":
        x = parseInt(ins[1]);
        break;
      
      case "loadnext":
        acc = mem[x++ % mem.length];
        break;
        
      case "storenext":
        mem[x++ % mem.length] = acc;
        break;
        
      case "loadprev":
        acc = mem[--x % mem.length];
        break;
        
      case "storeprev":
        mem[--x % mem.length] = acc;
        break;
        
      case "jump":
        pc = parseInt(ins[1]);
        break;
        
      case "tax":
        x = acc;
        break;
        
      case "txa":
        acc = x;
        break;
        
      case "tay":
        y = acc;
        break;
        
      case "tya":
        acc = y;
        break;
        
      case "loadrx":
        acc = mem[parseInt(ins[1]) + x];
        break;
        
      case "storerx":
        mem[parseInt(ins[1]) + x] = acc;
        break;
        
      case "loadry":
        acc = mem[parseInt(ins[1]) + y];
        break;
        
      case "storery":
        mem[parseInt(ins[1]) + y] = acc;
        break;
        
      case "dma":
        int sourceStart = parseInt(ins[1]);
        int sourceAmount = parseInt(ins[2]);
        int destStart = parseInt(ins[3]);
        
        for(int i = 0; i < sourceAmount; i++) {
          mem[destStart + i] = mem[sourceStart + i];
        }
        break;
        
      case "inca": acc++; break;
        
        
      //case "plot":
      //  int x, y, c;
      //  x = parseInt(ins[1]);
      //  y = parseInt(ins[2]);
      //  c = parseInt(ins[3]);
      //  mem[0xA000 + ((y * w) + x)] = c;
      //  break;
        
        
    }
  }
  
  int parseInt(String s) {
    
    if(debug) println("Hash Of '"+s+"': "+s.hashCode());
    
    char type = s.charAt(s.length() - 1);
    
    String val = s.subSequence(0,s.length() - 1).toString();
    
    int dat = 0;
    
    switch(type) {
      case 'H': dat = Integer.parseInt(val,16); break;
      case 'B': dat = Integer.parseInt(val,2); break;
      case 'O': dat = Integer.parseInt(val,8); break;
      default:
        if(debug) println(vars.get(val));
        if(vars.containsKey(val)) { 
          dat = vars.get(val);
        } else {
          dat = Integer.parseInt(s,10); break;
        }
    }
    
    if(debug) println(val+" "+dat);
    return dat;
  } 
  
  void placeChar(int x, int y, int c) {
    
  }
  
  
}
