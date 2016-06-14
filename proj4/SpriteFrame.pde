class SpriteFrame{
  PImage sprite;
  PImage spriteFlipped;
  
  
  SpriteFrame(String imgFile){
    sprite = loadImage(imgFile);
    sprite.format = ARGB;
    sprite.loadPixels();
    sprite = transparentizeBackground(sprite, sprite.pixels[0]);
    
    // 
    //https://processing.org/discourse/beta/num_1203607253.html
    // http://stackoverflow.com/questions/29334348/processing-mirror-image-over-x-axis
    spriteFlipped = createImage(sprite.width,sprite.height,ARGB);//create a new image with the same dimensions
    for(int y = 0; y < sprite.height; y++){
      for(int x = 0; x < sprite.width; x++){
        spriteFlipped.set(sprite.width-x-1,y,sprite.get(x,y));
      }
    }
    
    spriteFlipped.loadPixels();
    spriteFlipped = transparentizeBackground(spriteFlipped, spriteFlipped.pixels[0]);
    
  }
  
  PImage get(int x, int y, int w, int h){
    return sprite.get(x, y, w, h);
  }
  PImage getFlipped(int x, int y, int w, int h){
    return spriteFlipped.get(x, y, w, h);
  }
  
  PImage getFlippedFull() {
    return spriteFlipped;
  }
  
  
 
  
}