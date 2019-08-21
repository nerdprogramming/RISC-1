class APU extends PApplet {
  public final int CH1_NOTE = 0x9000;
  public final int CH1_AMP = 0x9001;
  public final int CH2_NOTE = 0x9002;
  public final int CH2_AMP = 0x9003;
  public final int CH3_NOTE = 0x9004;
  public final int CH3_AMP = 0x9005;
  
  public final SqrOsc ch1 = new SqrOsc(this), ch2 = new SqrOsc(this), ch3 = new SqrOsc(this);
  
 
  public final int chipRate = 1000;
  public final float chipFreq = 1 / chipRate;
  
  public boolean readyForNext = true;
  
  public void tick() {
      if(mem[CH1_AMP] > 0) {
        ch1.freq(midiToFreq(mem[CH1_NOTE]));
        ch1.amp(map(mem[CH1_AMP],0,256,0,1));
        ch1.play();
      } else {
        ch1.stop();
      }
      
      if(mem[CH2_AMP] > 0) {
        ch2.freq(midiToFreq(mem[CH2_NOTE]));
        ch2.amp(map(mem[CH2_AMP],0,256,0,1));
        ch2.play();
      } else {
        ch2.stop();
      }
      
      if(mem[CH3_AMP] > 0) {
        ch3.freq(midiToFreq(mem[CH3_NOTE]));
        ch3.amp(map(mem[CH3_AMP],0,256,0,1));
        ch3.play();
      } else {
        ch3.stop();
      }
  }
 
  float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0))) * 440;
}
  
}
