package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.Sprite;
   import flash.utils.getQualifiedClassName;
   
   public class GraphicCell extends Sprite implements ICustomUnicNameGetter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicCell));
       
      
      private var _dropValidator:Function;
      
      private var _removeDropSource:Function;
      
      private var _processDrop:Function;
      
      private var _name:String;
      
      public var cellId:uint;
      
      private var _initialElevation:int = 0;
      
      public function GraphicCell(cellId:uint)
      {
         this._dropValidator = this.returnTrueFunction;
         this._removeDropSource = this.returnTrueFunction;
         this._processDrop = this.returnTrueFunction;
         super();
         this.cellId = cellId;
         name = cellId.toString();
         this._name = "cell::" + cellId;
         buttonMode = true;
         mouseChildren = false;
         cacheAsBitmap = true;
      }
      
      public function get customUnicName() : String
      {
         return this._name;
      }
      
      public function set dropValidator(dv:Function) : void
      {
         this._dropValidator = dv;
      }
      
      public function get dropValidator() : Function
      {
         return this._dropValidator;
      }
      
      public function set removeDropSource(rds:Function) : void
      {
         this._removeDropSource = rds;
      }
      
      public function get removeDropSource() : Function
      {
         return this._removeDropSource;
      }
      
      public function set processDrop(pd:Function) : void
      {
         this._processDrop = pd;
      }
      
      public function get processDrop() : Function
      {
         return this._processDrop;
      }
      
      public function set initialElevation(value:int) : void
      {
         this._initialElevation = value;
      }
      
      public function get initialElevation() : int
      {
         return this._initialElevation;
      }
      
      private function returnTrueFunction(... args) : Boolean
      {
         return true;
      }
   }
}
