import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import processing.sound.*;
import processing.video.*;

PostFX fx; 
SoundFile file;
Amplitude amp;

String PATH = "C:/Users/chino/OneDrive/Desktop/IT5016D_Assessment 2_20220965/data/satch.mp4.mp4";
Movie mov; 
int numPixels;
int blocksize = 1;
color myMovColors[];

void setup() {
size(900,900, P3D);
fx = new PostFX(this);
//file = new SoundFile(this, "C:/Users/chino/OneDrive/Desktop/Project_4/data/satchshred.mp3");
//file.play();


amp= new Amplitude(this);
amp.input(file);

 mov = new Movie(this, PATH);
 numPixels = width/blocksize;
 myMovColors = new color[numPixels * numPixels];
 mov.loop();
}
void movieEvent(Movie m) {
  m.read();
  m.loadPixels();
  m.play();
  
  for (int j = 0; j < numPixels; j=j+8){
   for (int i = 0; i < numPixels; i=i+8) {
     myMovColors[j*numPixels + i] = m.get(i,j);
    }
  }

}
void draw(){
  background(0);
  float v = amp.analyze()*600;
  image(mov,0,0);
  for (int j = 0; j < numPixels; j=j+8) {
   for (int i = 0; i < numPixels; i=i+8) {
     int loc = myMovColors[j*numPixels + i];
     float r = red(loc);
     float g = green(loc);
     float b = blue(loc);
     float br = brightness(loc);
     stroke(r,g,b);
     strokeWeight(5);
     point(i*blocksize, j*blocksize,(br*1.2)+v);
    }
  }
fx.render()
.sobel()
.bloom(0.5, 20, 100)
.compose();
}

  

  
