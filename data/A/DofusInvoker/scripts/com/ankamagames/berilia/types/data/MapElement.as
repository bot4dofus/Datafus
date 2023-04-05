package com.ankamagames.berilia.types.data
{
   import com.ankamagames.berilia.managers.MapElementManager;
   import com.ankamagames.berilia.types.graphic.MapGroupElement;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.utils.getQualifiedClassName;
   
   public class MapElement
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapElement));
       
      
      private var _id:String;
      
      private var _owner:WeakReference;
      
      public var x:int;
      
      public var y:int;
      
      public var layer:String;
      
      public var group:MapGroupElement;
      
      public function MapElement(id:String, x:int, y:int, layer:String, owner:*)
      {
         super();
         this.x = x;
         this.y = y;
         this.layer = layer;
         this._owner = new WeakReference(owner);
         MapElementManager.getInstance().addElementById(id,this,owner);
         this._id = id;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get classType() : String
      {
         return "MapElement";
      }
      
      public function remove() : void
      {
         if(this._owner.object)
         {
            MapElementManager.getInstance().removeElementById(this._id,this._owner.object);
         }
      }
   }
}
