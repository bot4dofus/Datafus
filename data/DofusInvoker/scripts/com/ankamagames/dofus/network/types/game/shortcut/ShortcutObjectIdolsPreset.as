package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ShortcutObjectIdolsPreset extends ShortcutObject implements INetworkType
   {
      
      public static const protocolId:uint = 9778;
       
      
      public var presetId:int = 0;
      
      public function ShortcutObjectIdolsPreset()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9778;
      }
      
      public function initShortcutObjectIdolsPreset(slot:uint = 0, presetId:int = 0) : ShortcutObjectIdolsPreset
      {
         super.initShortcutObject(slot);
         this.presetId = presetId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.presetId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ShortcutObjectIdolsPreset(output);
      }
      
      public function serializeAs_ShortcutObjectIdolsPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_ShortcutObject(output);
         output.writeShort(this.presetId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutObjectIdolsPreset(input);
      }
      
      public function deserializeAs_ShortcutObjectIdolsPreset(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._presetIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutObjectIdolsPreset(tree);
      }
      
      public function deserializeAsyncAs_ShortcutObjectIdolsPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._presetIdFunc);
      }
      
      private function _presetIdFunc(input:ICustomDataInput) : void
      {
         this.presetId = input.readShort();
      }
   }
}
