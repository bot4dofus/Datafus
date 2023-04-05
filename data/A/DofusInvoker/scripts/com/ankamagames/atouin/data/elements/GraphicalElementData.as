package com.ankamagames.atouin.data.elements
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class GraphicalElementData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicalElementData));
       
      
      public var id:int;
      
      public var type:int;
      
      public function GraphicalElementData(elementId:int, elementType:int)
      {
         super();
         this.id = elementId;
         this.type = elementType;
      }
      
      public function fromRaw(raw:IDataInput, version:int) : void
      {
         throw new AbstractMethodCallError();
      }
   }
}
