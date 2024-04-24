package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class Shortcut implements INetworkType
   {
      
      public static const protocolId:uint = 938;
       
      
      public var slot:uint = 0;
      
      public function Shortcut()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 938;
      }
      
      public function initShortcut(slot:uint = 0) : Shortcut
      {
         this.slot = slot;
         return this;
      }
      
      public function reset() : void
      {
         this.slot = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_Shortcut(output);
      }
      
      public function serializeAs_Shortcut(output:ICustomDataOutput) : void
      {
         if(this.slot < 0 || this.slot > 99)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         output.writeByte(this.slot);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_Shortcut(input);
      }
      
      public function deserializeAs_Shortcut(input:ICustomDataInput) : void
      {
         this._slotFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_Shortcut(tree);
      }
      
      public function deserializeAsyncAs_Shortcut(tree:FuncTree) : void
      {
         tree.addChild(this._slotFunc);
      }
      
      private function _slotFunc(input:ICustomDataInput) : void
      {
         this.slot = input.readByte();
         if(this.slot < 0 || this.slot > 99)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element of Shortcut.slot.");
         }
      }
   }
}
