String[] imgNames = {"vangoah.jpg"};
PImage img;
int imgIndex = 0;
void nextImage() {
  background(255);
  loop();
  frameCount =0;
  
  img = loadImage(imgNames[imgIndex]);
  img.loadPixels();
  
  imgIndex += 1;
  /*if (imgIndex >= imgNames.length) {
    imgIndex = 0;
  }*/
  loop();
}
void paintStroke(float strokeLength, color strokeColor, int strokeThickness) {
  float stepLength = strokeLength/4.0;
  float tangent1 = 10;
  float tangent2 = 0;
  float odds = random(5);
  /*if (odds < 0.7) {
    tangent1 = random(-strokeLength, strokeLength);
    tangent2 = random(-strokeLength, strokeLength);
  } */
 
  noFill();
  stroke(strokeColor);
  strokeWeight(strokeThickness);
  curve(tangent1, -stepLength*2, 0, -stepLength, 0, stepLength, tangent2, stepLength*2);
  
  int z = 1;
  for (int num = strokeThickness; num > 0; num --) {
    float offset = random(-50, 25);
    color newColor = color(red(strokeColor)+offset, green(strokeColor)+offset, blue(strokeColor)+offset, random(100, 255));
    
    stroke(newColor);
    strokeWeight((int)random(0, 3));
    curve(tangent1, -stepLength*2, z-strokeThickness/2, -stepLength*random(0.9, 1.1), z-strokeThickness/2, stepLength*random(0.9, 1.1), tangent2, stepLength*2);
    
    z += 1;
  }
}


void setup() {
  size(950, 700);
    nextImage();
}


void draw() {
  translate(width/2, height/2);
  
  int index = 0;
  
  for (int y = 0; y < img.height; y+=1) {
    for (int x = 0; x < img.width; x+=1) {
      int odds = (int)random(20000);
      
      if (odds < 1) {
        color pixelColor = img.pixels[index];
        pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 100);
        
        pushMatrix();
        translate(x-img.width/2, y-img.height/2);
        rotate(radians(random(-90, 90)));

       if (frameCount < 20) {
          paintStroke(random(150, 250), pixelColor, (int)random(30, 50));
        } else if (frameCount < 50) {
          paintStroke(random(75, 125), pixelColor, (int)random(10, 25));
        } else if (frameCount < 300) {
          paintStroke(random(30, 60), pixelColor, (int)random(10, 20));
        } else if (frameCount < 350) {
          paintStroke(random(5, 20), pixelColor, (int)random(15, 30));
        } else if (frameCount < 600) {
          paintStroke(random(1, 10), pixelColor, (int)random(5, 14));
        }
        
        popMatrix();
      }
      
      index += 1;
    }
  }
   if (frameCount > 60) {
    noLoop();
  }
}
