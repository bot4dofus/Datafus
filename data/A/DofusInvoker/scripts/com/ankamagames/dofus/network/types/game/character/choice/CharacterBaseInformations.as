package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterBaseInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4381;
       
      
      public var sex:Boolean = false;
      
      public function CharacterBaseInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4381;
      }
      
      public function initCharacterBaseInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, sex:Boolean = false) : CharacterBaseInformations
      {
         super.initCharacterMinimalPlusLookInformations(id,name,level,entityLook,breed);
         this.sex = sex;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.sex = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterBaseInformations(output);
      }
      
      public function serializeAs_CharacterBaseInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalPlusLookInformations(output);
         output.writeBoolean(this.sex);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterBaseInformations(input);
      }
      
      public function deserializeAs_CharacterBaseInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._sexFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterBaseInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterBaseInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._sexFunc);
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
   }
}
