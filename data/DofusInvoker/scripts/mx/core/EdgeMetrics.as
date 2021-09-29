package mx.core
{
   use namespace mx_internal;
   
   public class EdgeMetrics
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const EMPTY:EdgeMetrics = new EdgeMetrics(0,0,0,0);
       
      
      public var bottom:Number;
      
      public var left:Number;
      
      public var right:Number;
      
      public var top:Number;
      
      public function EdgeMetrics(left:Number = 0, top:Number = 0, right:Number = 0, bottom:Number = 0)
      {
         super();
         this.left = left;
         this.top = top;
         this.right = right;
         this.bottom = bottom;
      }
      
      public function clone() : EdgeMetrics
      {
         return new EdgeMetrics(this.left,this.top,this.right,this.bottom);
      }
   }
}
