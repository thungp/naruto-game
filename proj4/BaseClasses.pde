
public interface CharacterState {
  
  public final int STANCE_STATE = 0;
  public final int HEAVY_DAMAGE_2 = 1;
}

public interface GameObjectIF {
   
  public void checkCollision(GameObjectIF gameObject);
  public void handleCollision(GameObjectIF gameObject);
  public PVector getPosition();
  public Dimension getDimension();
  
}

public interface RectangleIF{
  
}

public interface CircleIF{
  
}

class Dimension {
  int dimWidth;
  int dimHeight;
  
  
  Dimension(int dimWidth, int dimHeight){
    this.dimWidth = dimWidth;
    this.dimHeight = dimHeight;
  }
  
  public int getDimWidth(){
    return dimWidth;
  }
  public int getDimHeight(){
    return dimHeight;
  }
  public void setDimWidth(int dimWidth){
    this.dimWidth = dimWidth;
  }
  public void setDimHeight(int dimHeight){
    this.dimHeight = dimHeight;
  }
}
  

class Rectangle {
   private int x;
   private int y;
   private int rWidth;
   private int rLength;
   
   public int getX(){
     return x;
   }
   public int getY(){
     return y;
   }
   public int getWidth(){
     return rWidth;
   }
   public int getRLength(){
     return rLength;
   }
   public void setX(int x){
     this.x = x;
   }
   public void setY(int y){
     this.y = y;
   }
   public void setWidth(int rWidth){
     this.rWidth = rWidth;
   }
   public void setLength(int rLength){
     this.rLength = rLength;
   }
   
  
}