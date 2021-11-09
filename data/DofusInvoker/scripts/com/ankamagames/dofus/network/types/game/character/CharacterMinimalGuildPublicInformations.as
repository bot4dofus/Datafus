package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalGuildPublicInformations extends CharacterMinimalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6882;
       
      
      public var rank:uint = 0;
      
      public function CharacterMinimalGuildPublicInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6882;
      }
      
      public function initCharacterMinimalGuildPublicInformations(id:Number = 0, name:String = "", level:uint = 0, rank:uint = 0) : CharacterMinimalGuildPublicInformations
      {
         super.initCharacterMinimalInformations(id,name,level);
         this.rank = rank;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.rank = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalGuildPublicInformations(output);
      }
      
      public function serializeAs_CharacterMinimalGuildPublicInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalInformations(output);
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         output.writeVarInt(this.rank);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalGuildPublicInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalGuildPublicInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._rankFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalGuildPublicInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalGuildPublicInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._rankFunc);
      }
      
      private function _rankFunc(input:ICustomDataInput) : void
      {
         this.rank = input.readVarUhInt();
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of CharacterMinimalGuildPublicInformations.rank.");
         }
      }
   }
}
