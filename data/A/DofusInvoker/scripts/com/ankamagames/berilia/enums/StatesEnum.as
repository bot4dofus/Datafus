package com.ankamagames.berilia.enums
{
   public class StatesEnum
   {
      
      public static const STATE_NORMAL:uint = 0;
      
      public static const STATE_OVER:uint = 1;
      
      public static const STATE_CLICKED:uint = 2;
      
      public static const STATE_SELECTED:uint = 3;
      
      public static const STATE_SELECTED_OVER:uint = 4;
      
      public static const STATE_SELECTED_CLICKED:uint = 5;
      
      public static const STATE_DISABLED:uint = 6;
      
      public static const STATE_NORMAL_STRING:String = "NORMAL";
      
      public static const STATE_OVER_STRING:String = "OVER";
      
      public static const STATE_CLICKED_STRING:String = "PRESSED";
      
      public static const STATE_DISABLED_STRING:String = "DISABLED";
      
      public static const STATE_SELECTED_STRING:String = "SELECTED";
      
      public static const STATE_SELECTED_OVER_STRING:String = "SELECTED_OVER";
      
      public static const STATE_SELECTED_CLICKED_STRING:String = "SELECTED_PRESSED";
       
      
      public function StatesEnum()
      {
         super();
      }
      
      public static function getStateEnumList() : Vector.<String>
      {
         return Vector.<String>([STATE_NORMAL_STRING,STATE_CLICKED_STRING,STATE_DISABLED_STRING,STATE_OVER_STRING,STATE_SELECTED_CLICKED_STRING,STATE_SELECTED_OVER_STRING,STATE_SELECTED_STRING]);
      }
   }
}
