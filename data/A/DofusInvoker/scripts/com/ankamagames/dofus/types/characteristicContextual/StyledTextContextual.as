package com.ankamagames.dofus.types.characteristicContextual
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class StyledTextContextual extends CharacteristicContextual
   {
      
      private static const STYLE_0_NUMBER_0:Class = StyledTextContextual_STYLE_0_NUMBER_0;
      
      private static const STYLE_0_NUMBER_1:Class = StyledTextContextual_STYLE_0_NUMBER_1;
      
      private static const STYLE_0_NUMBER_2:Class = StyledTextContextual_STYLE_0_NUMBER_2;
      
      private static const STYLE_0_NUMBER_3:Class = StyledTextContextual_STYLE_0_NUMBER_3;
      
      private static const STYLE_0_NUMBER_4:Class = StyledTextContextual_STYLE_0_NUMBER_4;
      
      private static const STYLE_0_NUMBER_5:Class = StyledTextContextual_STYLE_0_NUMBER_5;
      
      private static const STYLE_0_NUMBER_6:Class = StyledTextContextual_STYLE_0_NUMBER_6;
      
      private static const STYLE_0_NUMBER_7:Class = StyledTextContextual_STYLE_0_NUMBER_7;
      
      private static const STYLE_0_NUMBER_8:Class = StyledTextContextual_STYLE_0_NUMBER_8;
      
      private static const STYLE_0_NUMBER_9:Class = StyledTextContextual_STYLE_0_NUMBER_9;
      
      private static const STYLE_0_NUMBER_MOINS:Class = StyledTextContextual_STYLE_0_NUMBER_MOINS;
      
      private static const STYLE_0_NUMBER_PLUS:Class = StyledTextContextual_STYLE_0_NUMBER_PLUS;
      
      private static const STYLE_1_NUMBER_0:Class = StyledTextContextual_STYLE_1_NUMBER_0;
      
      private static const STYLE_1_NUMBER_1:Class = StyledTextContextual_STYLE_1_NUMBER_1;
      
      private static const STYLE_1_NUMBER_2:Class = StyledTextContextual_STYLE_1_NUMBER_2;
      
      private static const STYLE_1_NUMBER_3:Class = StyledTextContextual_STYLE_1_NUMBER_3;
      
      private static const STYLE_1_NUMBER_4:Class = StyledTextContextual_STYLE_1_NUMBER_4;
      
      private static const STYLE_1_NUMBER_5:Class = StyledTextContextual_STYLE_1_NUMBER_5;
      
      private static const STYLE_1_NUMBER_6:Class = StyledTextContextual_STYLE_1_NUMBER_6;
      
      private static const STYLE_1_NUMBER_7:Class = StyledTextContextual_STYLE_1_NUMBER_7;
      
      private static const STYLE_1_NUMBER_8:Class = StyledTextContextual_STYLE_1_NUMBER_8;
      
      private static const STYLE_1_NUMBER_9:Class = StyledTextContextual_STYLE_1_NUMBER_9;
      
      private static const STYLE_1_NUMBER_MOINS:Class = StyledTextContextual_STYLE_1_NUMBER_MOINS;
      
      private static const STYLE_1_NUMBER_PLUS:Class = StyledTextContextual_STYLE_1_NUMBER_PLUS;
      
      private static const STYLE_2_NUMBER_0:Class = StyledTextContextual_STYLE_2_NUMBER_0;
      
      private static const STYLE_2_NUMBER_1:Class = StyledTextContextual_STYLE_2_NUMBER_1;
      
      private static const STYLE_2_NUMBER_2:Class = StyledTextContextual_STYLE_2_NUMBER_2;
      
      private static const STYLE_2_NUMBER_3:Class = StyledTextContextual_STYLE_2_NUMBER_3;
      
      private static const STYLE_2_NUMBER_4:Class = StyledTextContextual_STYLE_2_NUMBER_4;
      
      private static const STYLE_2_NUMBER_5:Class = StyledTextContextual_STYLE_2_NUMBER_5;
      
      private static const STYLE_2_NUMBER_6:Class = StyledTextContextual_STYLE_2_NUMBER_6;
      
      private static const STYLE_2_NUMBER_7:Class = StyledTextContextual_STYLE_2_NUMBER_7;
      
      private static const STYLE_2_NUMBER_8:Class = StyledTextContextual_STYLE_2_NUMBER_8;
      
      private static const STYLE_2_NUMBER_9:Class = StyledTextContextual_STYLE_2_NUMBER_9;
      
      private static const STYLE_2_NUMBER_MOINS:Class = StyledTextContextual_STYLE_2_NUMBER_MOINS;
      
      private static const STYLE_2_NUMBER_PLUS:Class = StyledTextContextual_STYLE_2_NUMBER_PLUS;
      
      private static const STYLE_3_NUMBER_0:Class = StyledTextContextual_STYLE_3_NUMBER_0;
      
      private static const STYLE_3_NUMBER_1:Class = StyledTextContextual_STYLE_3_NUMBER_1;
      
      private static const STYLE_3_NUMBER_2:Class = StyledTextContextual_STYLE_3_NUMBER_2;
      
      private static const STYLE_3_NUMBER_3:Class = StyledTextContextual_STYLE_3_NUMBER_3;
      
      private static const STYLE_3_NUMBER_4:Class = StyledTextContextual_STYLE_3_NUMBER_4;
      
      private static const STYLE_3_NUMBER_5:Class = StyledTextContextual_STYLE_3_NUMBER_5;
      
      private static const STYLE_3_NUMBER_6:Class = StyledTextContextual_STYLE_3_NUMBER_6;
      
      private static const STYLE_3_NUMBER_7:Class = StyledTextContextual_STYLE_3_NUMBER_7;
      
      private static const STYLE_3_NUMBER_8:Class = StyledTextContextual_STYLE_3_NUMBER_8;
      
      private static const STYLE_3_NUMBER_9:Class = StyledTextContextual_STYLE_3_NUMBER_9;
      
      private static const STYLE_3_NUMBER_MOINS:Class = StyledTextContextual_STYLE_3_NUMBER_MOINS;
      
      private static const STYLE_3_NUMBER_PLUS:Class = StyledTextContextual_STYLE_3_NUMBER_PLUS;
       
      
      public function StyledTextContextual(value:String, style:uint)
      {
         super();
         this.init(value,style);
      }
      
      private function init(value:String, style:uint) : void
      {
         var last:DisplayObject = null;
         var char:String = null;
         var n:Sprite = null;
         for(var i:uint = 0; i < value.length; i++)
         {
            char = value.charAt(i);
            switch(char)
            {
               case "-":
                  char = "MOINS";
                  break;
               case "+":
                  char = "PLUS";
                  break;
            }
            n = new StyledTextContextual["STYLE_" + style + "_NUMBER_" + char]() as Sprite;
            n.scaleX = 0.7;
            n.scaleY = 0.7;
            if(last)
            {
               n.x = last.x + last.width + 5;
            }
            addChild(n);
            last = n;
         }
         mouseEnabled = false;
         mouseChildren = false;
         cacheAsBitmap = true;
      }
   }
}
