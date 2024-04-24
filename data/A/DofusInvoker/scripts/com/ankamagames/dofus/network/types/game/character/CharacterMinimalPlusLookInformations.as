package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalPlusLookInformations extends CharacterMinimalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8749;
       
      
      public var entityLook:EntityLook;
      
      public var breed:int = 0;
      
      private var _entityLooktree:FuncTree;
      
      public function CharacterMinimalPlusLookInformations()
      {
         this.entityLook = new EntityLook();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8749;
      }
      
      public function initCharacterMinimalPlusLookInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0) : CharacterMinimalPlusLookInformations
      {
         super.initCharacterMinimalInformations(id,name,level);
         this.entityLook = entityLook;
         this.breed = breed;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.entityLook = new EntityLook();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalPlusLookInformations(output);
      }
      
      public function serializeAs_CharacterMinimalPlusLookInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalInformations(output);
         this.entityLook.serializeAs_EntityLook(output);
         output.writeByte(this.breed);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalPlusLookInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalPlusLookInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.entityLook = new EntityLook();
         this.entityLook.deserialize(input);
         this._breedFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalPlusLookInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalPlusLookInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._entityLooktree = tree.addChild(this._entityLooktreeFunc);
         tree.addChild(this._breedFunc);
      }
      
      private function _entityLooktreeFunc(input:ICustomDataInput) : void
      {
         this.entityLook = new EntityLook();
         this.entityLook.deserializeAsync(this._entityLooktree);
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
   }
}
