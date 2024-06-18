package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StatedElement implements INetworkType
   {
      
      public static const protocolId:uint = 1041;
       
      
      public var elementId:uint = 0;
      
      public var elementCellId:uint = 0;
      
      public var elementState:uint = 0;
      
      public var onCurrentMap:Boolean = false;
      
      public function StatedElement()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1041;
      }
      
      public function initStatedElement(elementId:uint = 0, elementCellId:uint = 0, elementState:uint = 0, onCurrentMap:Boolean = false) : StatedElement
      {
         this.elementId = elementId;
         this.elementCellId = elementCellId;
         this.elementState = elementState;
         this.onCurrentMap = onCurrentMap;
         return this;
      }
      
      public function reset() : void
      {
         this.elementId = 0;
         this.elementCellId = 0;
         this.elementState = 0;
         this.onCurrentMap = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StatedElement(output);
      }
      
      public function serializeAs_StatedElement(output:ICustomDataOutput) : void
      {
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         output.writeInt(this.elementId);
         if(this.elementCellId < 0 || this.elementCellId > 559)
         {
            throw new Error("Forbidden value (" + this.elementCellId + ") on element elementCellId.");
         }
         output.writeVarShort(this.elementCellId);
         if(this.elementState < 0)
         {
            throw new Error("Forbidden value (" + this.elementState + ") on element elementState.");
         }
         output.writeVarInt(this.elementState);
         output.writeBoolean(this.onCurrentMap);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatedElement(input);
      }
      
      public function deserializeAs_StatedElement(input:ICustomDataInput) : void
      {
         this._elementIdFunc(input);
         this._elementCellIdFunc(input);
         this._elementStateFunc(input);
         this._onCurrentMapFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatedElement(tree);
      }
      
      public function deserializeAsyncAs_StatedElement(tree:FuncTree) : void
      {
         tree.addChild(this._elementIdFunc);
         tree.addChild(this._elementCellIdFunc);
         tree.addChild(this._elementStateFunc);
         tree.addChild(this._onCurrentMapFunc);
      }
      
      private function _elementIdFunc(input:ICustomDataInput) : void
      {
         this.elementId = input.readInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of StatedElement.elementId.");
         }
      }
      
      private function _elementCellIdFunc(input:ICustomDataInput) : void
      {
         this.elementCellId = input.readVarUhShort();
         if(this.elementCellId < 0 || this.elementCellId > 559)
         {
            throw new Error("Forbidden value (" + this.elementCellId + ") on element of StatedElement.elementCellId.");
         }
      }
      
      private function _elementStateFunc(input:ICustomDataInput) : void
      {
         this.elementState = input.readVarUhInt();
         if(this.elementState < 0)
         {
            throw new Error("Forbidden value (" + this.elementState + ") on element of StatedElement.elementState.");
         }
      }
      
      private function _onCurrentMapFunc(input:ICustomDataInput) : void
      {
         this.onCurrentMap = input.readBoolean();
      }
   }
}
