class SpriteFrame{
  PImage sprite;
  
  
  SpriteFrame(String imgFile){
    sprite = loadImage(imgFile);
    sprite.format = ARGB;
    sprite.loadPixels();
    sprite = transparentizeBackground(sprite, sprite.pixels[0]);
  }
  
  PImage get(int x, int y, int w, int h){
    return sprite.get(x, y, w, h);
  }
  
  
  
  
  
  
}