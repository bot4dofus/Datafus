package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterCharacteristicForPreset extends SimpleCharacterCharacteristicForPreset implements INetworkType
   {
      
      public static const protocolId:uint = 3299;
       
      
      public var stuff:int = 0;
      
      public function CharacterCharacteristicForPreset()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3299;
      }
      
      public function initCharacterCharacteristicForPreset(keyword:String = "", base:int = 0, additionnal:int = 0, stuff:int = 0) : CharacterCharacteristicForPreset
      {
         super.initSimpleCharacterCharacteristicForPreset(keyword,base,additionnal);
         this.stuff = stuff;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.stuff = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterCharacteristicForPreset(output);
      }
      
      public function serializeAs_CharacterCharacteristicForPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_SimpleCharacterCharacteristicForPreset(output);
         output.writeVarInt(this.stuff);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCharacteristicForPreset(input);
      }
      
      public function deserializeAs_CharacterCharacteristicForPreset(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._stuffFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCharacteristicForPreset(tree);
      }
      
      public function deserializeAsyncAs_CharacterCharacteristicForPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._stuffFunc);
      }
      
      private function _stuffFunc(input:ICustomDataInput) : void
      {
         this.stuff = input.readVarInt();
      }
   }
}
