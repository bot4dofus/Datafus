package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class IconNamedPreset extends PresetsContainerPreset implements INetworkType
   {
      
      public static const protocolId:uint = 3270;
       
      
      public var iconId:uint = 0;
      
      public var name:String = "";
      
      public function IconNamedPreset()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3270;
      }
      
      public function initIconNamedPreset(id:int = 0, presets:Vector.<Preset> = null, iconId:uint = 0, name:String = "") : IconNamedPreset
      {
         super.initPresetsContainerPreset(id,presets);
         this.iconId = iconId;
         this.name = name;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.iconId = 0;
         this.name = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IconNamedPreset(output);
      }
      
      public function serializeAs_IconNamedPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_PresetsContainerPreset(output);
         if(this.iconId < 0)
         {
            throw new Error("Forbidden value (" + this.iconId + ") on element iconId.");
         }
         output.writeShort(this.iconId);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IconNamedPreset(input);
      }
      
      public function deserializeAs_IconNamedPreset(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._iconIdFunc(input);
         this._nameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IconNamedPreset(tree);
      }
      
      public function deserializeAsyncAs_IconNamedPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._iconIdFunc);
         tree.addChild(this._nameFunc);
      }
      
      private function _iconIdFunc(input:ICustomDataInput) : void
      {
         this.iconId = input.readShort();
         if(this.iconId < 0)
         {
            throw new Error("Forbidden value (" + this.iconId + ") on element of IconNamedPreset.iconId.");
         }
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
