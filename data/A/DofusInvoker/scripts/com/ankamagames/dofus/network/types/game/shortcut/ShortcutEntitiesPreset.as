package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ShortcutEntitiesPreset extends Shortcut implements INetworkType
   {
      
      public static const protocolId:uint = 3288;
       
      
      public var presetId:int = 0;
      
      public function ShortcutEntitiesPreset()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3288;
      }
      
      public function initShortcutEntitiesPreset(slot:uint = 0, presetId:int = 0) : ShortcutEntitiesPreset
      {
         super.initShortcut(slot);
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
         this.serializeAs_ShortcutEntitiesPreset(output);
      }
      
      public function serializeAs_ShortcutEntitiesPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Shortcut(output);
         output.writeShort(this.presetId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutEntitiesPreset(input);
      }
      
      public function deserializeAs_ShortcutEntitiesPreset(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._presetIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutEntitiesPreset(tree);
      }
      
      public function deserializeAsyncAs_ShortcutEntitiesPreset(tree:FuncTree) : void
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
