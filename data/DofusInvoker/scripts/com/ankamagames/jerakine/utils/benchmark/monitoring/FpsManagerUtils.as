package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.Graph;
   import flash.system.Capabilities;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class FpsManagerUtils
   {
       
      
      public function FpsManagerUtils()
      {
         super();
      }
      
      public static function countKeys(myDictionary:Dictionary) : int
      {
         var key:* = undefined;
         var n:int = 0;
         for(key in myDictionary)
         {
            n++;
         }
         return n;
      }
      
      public static function calculateMB(value:uint) : Number
      {
         var newValue:Number = Math.round(value / 1024 / 1024 * 100);
         return newValue / 100;
      }
      
      public static function getTimeFromNow(value:int) : String
      {
         var mls:int = getTimer() - value;
         var sec:int = mls / 1000;
         var min:int = sec / 60;
         sec -= min * 60;
         return (min > 0 ? min.toString() + " min " : "") + sec.toString() + " sec";
      }
      
      public static function isSpecialGraph(pIndice:String) : Boolean
      {
         var g:Object = null;
         for each(g in FpsManagerConst.SPECIAL_GRAPH)
         {
            if(g.name == pIndice)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function numberOfSpecialGraphDisplayed(graphList:Dictionary) : int
      {
         var g:Graph = null;
         var cpt:int = 0;
         for each(g in graphList)
         {
            if(FpsManagerUtils.isSpecialGraph(g.indice))
            {
               cpt++;
            }
         }
         return cpt;
      }
      
      public static function getVectorMaxValue(vector:Vector.<Number>) : Number
      {
         var v:Number = NaN;
         var value:Number = 0;
         for each(v in vector)
         {
            if(v > value)
            {
               value = v;
            }
         }
         return value;
      }
      
      public static function getVersion() : Number
      {
         var _fullInfo:String = Capabilities.version;
         var _osSplitArr:Array = _fullInfo.split(" ");
         var _versionSplitArr:Array = _osSplitArr[1].split(",");
         return Number(_versionSplitArr[0]);
      }
      
      public static function getBrightRandomColor() : uint
      {
         for(var color:uint = getRandomColor(); color < 8000000; )
         {
            color = getRandomColor();
         }
         return color;
      }
      
      public static function getRandomColor() : uint
      {
         return Math.random() * 16777215;
      }
      
      public static function addAlphaToColor(rgb:uint, alpha:uint) : uint
      {
         return (alpha << 24) + rgb;
      }
   }
}
