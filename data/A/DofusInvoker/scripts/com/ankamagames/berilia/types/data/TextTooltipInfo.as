package com.ankamagames.berilia.types.data
{
   public class TextTooltipInfo
   {
       
      
      public var content:String;
      
      public var css:String;
      
      public var cssClass:String;
      
      public var maxWidth:int;
      
      public var bgCornerRadius:int = 0;
      
      public var checkSuperposition:Boolean;
      
      public var cellId:int = -1;
      
      public function TextTooltipInfo(content:String, css:String = null, cssClass:String = null, maxWidth:int = 400, pCheckSuperposition:Boolean = false, pCellId:int = -1)
      {
         super();
         this.content = content;
         this.css = css;
         if(cssClass)
         {
            this.cssClass = cssClass;
         }
         else
         {
            this.cssClass = "text";
         }
         this.maxWidth = maxWidth;
         this.checkSuperposition = pCheckSuperposition;
         this.cellId = pCellId;
      }
   }
}
