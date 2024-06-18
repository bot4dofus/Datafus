package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterBasicMinimalInformations extends AbstractCharacterInformation implements INetworkType
   {
      
      public static const protocolId:uint = 6994;
       
      
      public var name:String = "";
      
      public function CharacterBasicMinimalInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6994;
      }
      
      public function initCharacterBasicMinimalInformations(id:Number = 0, name:String = "") : CharacterBasicMinimalInformations
      {
         super.initAbstractCharacterInformation(id);
         this.name = name;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterBasicMinimalInformations(output);
      }
      
      public function serializeAs_CharacterBasicMinimalInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractCharacterInformation(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterBasicMinimalInformations(input);
      }
      
      public function deserializeAs_CharacterBasicMinimalInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterBasicMinimalInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterBasicMinimalInformations(tree:FuncTree) : void
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
