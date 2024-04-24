package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SimpleCharacterCharacteristicForPreset implements INetworkType
   {
      
      public static const protocolId:uint = 5762;
       
      
      public var keyword:String = "";
      
      public var base:int = 0;
      
      public var additionnal:int = 0;
      
      public function SimpleCharacterCharacteristicForPreset()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5762;
      }
      
      public function initSimpleCharacterCharacteristicForPreset(keyword:String = "", base:int = 0, additionnal:int = 0) : SimpleCharacterCharacteristicForPreset
      {
         this.keyword = keyword;
         this.base = base;
         this.additionnal = additionnal;
         return this;
      }
      
      public function reset() : void
      {
         this.keyword = "";
         this.base = 0;
         this.additionnal = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SimpleCharacterCharacteristicForPreset(output);
      }
      
      public function serializeAs_SimpleCharacterCharacteristicForPreset(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.keyword);
         output.writeVarInt(this.base);
         output.writeVarInt(this.additionnal);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SimpleCharacterCharacteristicForPreset(input);
      }
      
      public function deserializeAs_SimpleCharacterCharacteristicForPreset(input:ICustomDataInput) : void
      {
         this._keywordFunc(input);
         this._baseFunc(input);
         this._additionnalFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SimpleCharacterCharacteristicForPreset(tree);
      }
      
      public function deserializeAsyncAs_SimpleCharacterCharacteristicForPreset(tree:FuncTree) : void
      {
         tree.addChild(this._keywordFunc);
         tree.addChild(this._baseFunc);
         tree.addChild(this._additionnalFunc);
      }
      
      private function _keywordFunc(input:ICustomDataInput) : void
      {
         this.keyword = input.readUTF();
      }
      
      private function _baseFunc(input:ICustomDataInput) : void
      {
         this.base = input.readVarInt();
      }
      
      private function _additionnalFunc(input:ICustomDataInput) : void
      {
         this.additionnal = input.readVarInt();
      }
   }
}
