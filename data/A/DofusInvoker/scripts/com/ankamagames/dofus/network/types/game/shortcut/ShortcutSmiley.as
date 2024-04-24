package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ShortcutSmiley extends Shortcut implements INetworkType
   {
      
      public static const protocolId:uint = 3053;
       
      
      public var smileyId:uint = 0;
      
      public function ShortcutSmiley()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3053;
      }
      
      public function initShortcutSmiley(slot:uint = 0, smileyId:uint = 0) : ShortcutSmiley
      {
         super.initShortcut(slot);
         this.smileyId = smileyId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.smileyId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ShortcutSmiley(output);
      }
      
      public function serializeAs_ShortcutSmiley(output:ICustomDataOutput) : void
      {
         super.serializeAs_Shortcut(output);
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         output.writeVarShort(this.smileyId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutSmiley(input);
      }
      
      public function deserializeAs_ShortcutSmiley(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._smileyIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutSmiley(tree);
      }
      
      public function deserializeAsyncAs_ShortcutSmiley(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._smileyIdFunc);
      }
      
      private function _smileyIdFunc(input:ICustomDataInput) : void
      {
         this.smileyId = input.readVarUhShort();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of ShortcutSmiley.smileyId.");
         }
      }
   }
}
