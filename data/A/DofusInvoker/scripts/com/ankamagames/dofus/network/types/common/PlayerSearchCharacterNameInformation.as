package com.ankamagames.dofus.network.types.common
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PlayerSearchCharacterNameInformation extends AbstractPlayerSearchInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8303;
       
      
      public var name:String = "";
      
      public function PlayerSearchCharacterNameInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8303;
      }
      
      public function initPlayerSearchCharacterNameInformation(name:String = "") : PlayerSearchCharacterNameInformation
      {
         this.name = name;
         return this;
      }
      
      override public function reset() : void
      {
         this.name = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PlayerSearchCharacterNameInformation(output);
      }
      
      public function serializeAs_PlayerSearchCharacterNameInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPlayerSearchInformation(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PlayerSearchCharacterNameInformation(input);
      }
      
      public function deserializeAs_PlayerSearchCharacterNameInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PlayerSearchCharacterNameInformation(tree);
      }
      
      public function deserializeAsyncAs_PlayerSearchCharacterNameInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
