package Ankama_Cartography.ui.type
{
   import flash.geom.Point;
   
   public class Flag
   {
       
      
      public var id:String;
      
      public var position:Point;
      
      public var legend:String;
      
      public var color:uint;
      
      public var canBeManuallyRemoved:Boolean;
      
      public var worldMap:int;
      
      public var allowDuplicate:Boolean;
      
      public function Flag(id:String, x:int, y:int, legend:String, color:int = -1, canBeManuallyRemoved:Boolean = true, allowDuplicate:Boolean = false)
      {
         super();
         this.id = id;
         this.position = new Point(x,y);
         this.legend = legend;
         this.color = color;
         this.canBeManuallyRemoved = canBeManuallyRemoved;
         this.allowDuplicate = allowDuplicate;
      }
   }
}
