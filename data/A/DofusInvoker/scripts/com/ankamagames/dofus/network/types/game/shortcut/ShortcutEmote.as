package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ShortcutEmote extends Shortcut implements INetworkType
   {
      
      public static const protocolId:uint = 1189;
       
      
      public var emoteId:uint = 0;
      
      public function ShortcutEmote()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1189;
      }
      
      public function initShortcutEmote(slot:uint = 0, emoteId:uint = 0) : ShortcutEmote
      {
         super.initShortcut(slot);
         this.emoteId = emoteId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.emoteId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ShortcutEmote(output);
      }
      
      public function serializeAs_ShortcutEmote(output:ICustomDataOutput) : void
      {
         super.serializeAs_Shortcut(output);
         if(this.emoteId < 0 || this.emoteId > 65535)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         output.writeShort(this.emoteId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutEmote(input);
      }
      
      public function deserializeAs_ShortcutEmote(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._emoteIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutEmote(tree);
      }
      
      public function deserializeAsyncAs_ShortcutEmote(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._emoteIdFunc);
      }
      
      private function _emoteIdFunc(input:ICustomDataInput) : void
      {
         this.emoteId = input.readUnsignedShort();
         if(this.emoteId < 0 || this.emoteId > 65535)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of ShortcutEmote.emoteId.");
         }
      }
   }
}
