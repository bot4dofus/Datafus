package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ShortcutObject extends Shortcut implements INetworkType
   {
      
      public static const protocolId:uint = 8861;
       
      
      public function ShortcutObject()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8861;
      }
      
      public function initShortcutObject(slot:uint = 0) : ShortcutObject
      {
         super.initShortcut(slot);
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ShortcutObject(output);
      }
      
      public function serializeAs_ShortcutObject(output:ICustomDataOutput) : void
      {
         super.serializeAs_Shortcut(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutObject(input);
      }
      
      public function deserializeAs_ShortcutObject(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutObject(tree);
      }
      
      public function deserializeAsyncAs_ShortcutObject(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
