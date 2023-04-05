package com.ankamagames.berilia.types.data
{
   public class Margin
   {
       
      
      public var left:int;
      
      public var right:int;
      
      public var top:int;
      
      public var bottom:int;
      
      public function Margin(left:int = 0, right:int = 0, top:int = 0, bottom:int = 0)
      {
         super();
         this.setTo(left,right,top,bottom);
      }
      
      public function setTo(left:int = 0, right:int = 0, top:int = 0, bottom:int = 0) : void
      {
         this.left = left;
         this.right = right;
         this.top = top;
         this.bottom = bottom;
      }
   }
}
