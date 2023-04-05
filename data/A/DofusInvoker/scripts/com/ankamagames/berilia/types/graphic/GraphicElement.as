package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GraphicElement implements IDataCenter
   {
      
      private static var _aGEIndex:Array = [];
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicElement));
       
      
      public var sprite:GraphicContainer;
      
      public var location:GraphicLocation;
      
      public var name:String;
      
      public var render:Boolean = false;
      
      public var size:GraphicSize;
      
      public var locations:Array;
      
      public var hintAvailable:Boolean;
      
      public var isInstance:Boolean = false;
      
      public function GraphicElement(spSprite:GraphicContainer, aLocations:Array, sName:String)
      {
         super();
         this.sprite = spSprite;
         if(aLocations != null && aLocations.length > 0)
         {
            this.locations = aLocations;
            this.location = aLocations[0];
         }
         else
         {
            this.location = new GraphicLocation();
            this.locations = [this.location];
         }
         this.name = sName;
         this.size = new GraphicSize();
      }
      
      public static function getGraphicElement(spSprite:GraphicContainer, aLocations:Array, sName:String = null) : GraphicElement
      {
         var ge:GraphicElement = null;
         if(sName == null || _aGEIndex[sName] == null)
         {
            ge = new GraphicElement(spSprite,aLocations,sName);
            if(sName != null)
            {
               _aGEIndex[sName] = ge;
            }
         }
         else
         {
            ge = _aGEIndex[sName];
         }
         if(aLocations != null)
         {
            ge.locations = aLocations;
            if(aLocations != null && aLocations[0] != null)
            {
               ge.location = aLocations[0];
            }
         }
         return ge;
      }
      
      public static function init() : void
      {
         _aGEIndex = [];
      }
   }
}
