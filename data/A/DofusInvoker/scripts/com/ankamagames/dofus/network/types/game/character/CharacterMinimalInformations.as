package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalInformations extends CharacterBasicMinimalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9474;
       
      
      public var level:uint = 0;
      
      public function CharacterMinimalInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9474;
      }
      
      public function initCharacterMinimalInformations(id:Number = 0, name:String = "", level:uint = 0) : CharacterMinimalInformations
      {
         super.initCharacterBasicMinimalInformations(id,name);
         this.level = level;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalInformations(output);
      }
      
      public function serializeAs_CharacterMinimalInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterBasicMinimalInformations(output);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._levelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._levelFunc);
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of CharacterMinimalInformations.level.");
         }
      }
   }
}
