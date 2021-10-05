package flashx.textLayout.compose
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Matrix;
   
   [ExcludeClass]
   public class FloatCompositionData
   {
       
      
      public var graphic:DisplayObject;
      
      public var columnIndex:int;
      
      public var floatType:String;
      
      public var x:Number;
      
      public var y:Number;
      
      public var alpha:Number;
      
      public var matrix:Matrix;
      
      public var absolutePosition:int;
      
      public var depth:Number;
      
      public var knockOutWidth:Number;
      
      public var parent:DisplayObjectContainer;
      
      public function FloatCompositionData(absolutePosition:int, graphic:DisplayObject, floatType:String, x:Number, y:Number, alpha:Number, matrix:Matrix, depth:Number, knockOutWidth:Number, columnIndex:int, parent:DisplayObjectContainer)
      {
         super();
         this.absolutePosition = absolutePosition;
         this.graphic = graphic;
         this.floatType = floatType;
         this.x = x;
         this.y = y;
         this.alpha = alpha;
         this.matrix = matrix;
         this.depth = depth;
         this.knockOutWidth = knockOutWidth;
         this.columnIndex = columnIndex;
         this.parent = parent;
      }
   }
}
