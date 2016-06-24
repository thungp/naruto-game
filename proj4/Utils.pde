
// make background transparent
// currently hard coded to look for green color only 
// based on sample
PImage transparentizeBackground(PImage p, color col) {
  PImage p2;
  p.loadPixels();
  
  p2 = p.copy();
  p2.loadPixels();
  int pLen = p2.pixels.length;
  
  for(int i = 0; i < pLen; i++){
    int isGreenMatch = (int)green(p2.pixels[i]);
    int isBlueMatch  = (int)blue(p2.pixels[i]);
    int isRedMatch   = (int)red(p2.pixels[i]);
    if(isGreenMatch == (int)green(col) && isBlueMatch == (int)blue(col) && isRedMatch == (int)red(col)) {
      p2.pixels[i] = color(0, 0, 0, 0);
    }
  }
  return p2;
}


boolean intersects(GameObjectIF obj1, GameObjectIF obj2){
  // ref http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
  int circDistx;
  int circDisty;
  int rectCenterX;
  int rectCenterY;
  int rectHeight;
  int rectWidth;
  GameObjectIF circleObj;
  GameObjectIF rectangleObj;
  
  // detects collision of circle and rectangle
  if( (obj1 instanceof CircleIF && obj2 instanceof RectangleIF) ||
       (obj2 instanceof CircleIF && obj1 instanceof RectangleIF)) {
     
     if(obj1 instanceof CircleIF && obj2 instanceof RectangleIF) {
       circleObj = obj1;
       rectangleObj = obj2;
     } else {
       circleObj = obj2;
       rectangleObj = obj1;
     }
     circleObj = obj1;
     rectangleObj = obj2;
    
     // obj1 is a Circle obj2 is a square
     Dimension rectDimension = rectangleObj.getDimension();
     rectWidth = rectDimension.getDimWidth(); 
     int rectHalfWidth = rectWidth/2;
     PVector rectPostionVector = obj2.getPosition(); 
     rectCenterX = (int)rectPostionVector.x + rectHalfWidth;
  
     rectHeight = rectDimension.getDimHeight(); 
     int rectHalfHeight = rectHeight/2;
  
     rectCenterY = (int)rectPostionVector.y  + rectHalfHeight;
    
     circDistx = abs((int) circleObj.getPosition().x - rectCenterX); 
     circDisty = abs((int) circleObj.getPosition().y - rectCenterY);
     if(circDistx > (rectHalfWidth + (int) circleObj.getDimension().getDimWidth()) ) {return false;}
     if(circDisty > (rectHalfHeight + (int) circleObj.getDimension().getDimHeight()) ) {return false;}
     
     if(circDistx <= (rectHalfWidth)) { return true; }
     if(circDisty <= (rectHalfHeight))  {return true;}
     
     int cornerDistanceSq = (int) Math.pow((circDistx - rectHalfWidth), 2) + (int) Math.pow((circDisty - rectHalfHeight), 2);
  
     return (cornerDistanceSq <= (int) Math.pow( circleObj.getDimension().getDimWidth(), 2) );
     
  }
  return false;
}



// level starts with 0 and goes up, 
PImage blurImg(PImage p, int level) {

  int border = (level * 2)  + 1 ;

  int den = border * border;
  
  float v = (float) 1.0 / den;
                  
  float[][] kernel = new float[border][border];
  for(int i = 0; i < kernel.length; i++) {
    for(int j = 0; j< kernel[i].length; j++){
      kernel[i][j] = v;
    }
  }
  
  p.loadPixels();
  
  int width = p.width;
  int height = p.height;
  
  //step 1. initialize src with original source Color
  int[][] srcColor = new int[height][width];
  for(int i = 0; i < height; i++) {
    for(int j = 0; j < width; j++) {
      int k = i * width + j;
      srcColor[i][j] = p.pixels[k];
      
    }
  }

  
  // create new image 
  PImage p2 = createImage(width, height, RGB);
  p2.loadPixels();
  // Step 2. Update srcColrbased on blur rules and 1D adjacent neighborhood
  for(int y = level; y <  srcColor.length - level; y++) {
    for(int x = level; x < srcColor[y].length - level ; x++) {
      float sumRed = 0; // Kernel sum for this pixel
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = (-1 * level); ky <= level; ky++) {
        for (int kx = (-1 * level); kx <= level; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*p.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float redVal = red(p.pixels[pos]);
          float greenVal = green(p.pixels[pos]);
          float blueVal = blue(p.pixels[pos]);
          
          // Multiply adjacent pixels based on the kernel values
          sumRed += kernel[ky+level][kx+level] * redVal;
          sumGreen += kernel[ky+level][kx+level] * greenVal;
          sumBlue += kernel[ky+level][kx+level] * blueVal;
        }
      }
      // For this pixel in the new image, set the new convoluted value
      // based on the sum from the kernel
      p2.pixels[y*p.width + x] = color(sumRed, sumGreen, sumBlue);
      
    }
  }
  p2.updatePixels();
 
 return p2; 
}


// level starts with 0 and goes up, 
PImage sharpenImg(PImage p, int level) {
  
  // level - val
  // 0 - 1
  // 1 - 5
  // 2 - 9
  // 3 - 13
  // 4 - 17
  // ((level * 4) + 1
  //

  int border = (level * 2)  + 1 ;

  int den = border * border;
  
  float v = (float) 1.0 / den;
  
  int centralVal = (level * 4) + 1;
  // initialize kernel matrix
  float[][] kernel = new float[border][border];
  for(int i = 0; i < kernel.length; i++) {
    for(int j = 0; j< kernel[i].length; j++){
      if(i == level && j == level) {
        kernel[i][j] = centralVal;
      } else if (i == level) {
        kernel[i][j] = -1;
      } else if (j == level) {
        kernel[i][j] = -1;
      } else {
        kernel[i][j] = 0;
      }
    }
  }
  
  p.loadPixels();
  
  int width = p.width;
  int height = p.height;
  
  //step 1. initialize src with original source Color
  int[][] srcColor = new int[height][width];
  for(int i = 0; i < height; i++) {
    for(int j = 0; j < width; j++) {
      int k = i * width + j;
      srcColor[i][j] = p.pixels[k];
      
    }
  }

  
  // create new image 
  PImage p2 = createImage(width, height, RGB);
  p2.loadPixels();
  // Step 2. Update srcColrbased on blur rules and 1D adjacent neighborhood
  for(int y = level; y <  srcColor.length - level; y++) {
    for(int x = level; x < srcColor[y].length - level ; x++) {
      float sumRed = 0; // Kernel sum for this pixel
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = (-1 * level); ky <= level; ky++) {
        for (int kx = (-1 * level); kx <= level; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*p.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float redVal = red(p.pixels[pos]);
          float greenVal = green(p.pixels[pos]);
          float blueVal = blue(p.pixels[pos]);
          
          // Multiply adjacent pixels based on the kernel values
          sumRed += kernel[ky+level][kx+level] * redVal;
          sumGreen += kernel[ky+level][kx+level] * greenVal;
          sumBlue += kernel[ky+level][kx+level] * blueVal;
        }
      }
      // For this pixel in the new image, set the new convoluted value
      // based on the sum from the kernel
      p2.pixels[y*p.width + x] = color(sumRed, sumGreen, sumBlue);
      
    }
  }
  p2.updatePixels();
 
 return p2; 
}