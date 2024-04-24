package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ShortcutObjectPreset extends ShortcutObject implements INetworkType
   {
      
      public static const protocolId:uint = 8087;
       
      
      public var presetId:int = 0;
      
      public function ShortcutObjectPreset()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8087;
      }
      
      public function initShortcutObjectPreset(slot:uint = 0, presetId:int = 0) : ShortcutObjectPreset
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
         this.serializeAs_ShortcutObjectPreset(output);
      }
      
      public function serializeAs_ShortcutObjectPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_ShortcutObject(output);
         output.writeShort(this.presetId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutObjectPreset(input);
      }
      
      public function deserializeAs_ShortcutObjectPreset(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._presetIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutObjectPreset(tree);
      }
      
      public function deserializeAsyncAs_ShortcutObjectPreset(tree:FuncTree) : void
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
