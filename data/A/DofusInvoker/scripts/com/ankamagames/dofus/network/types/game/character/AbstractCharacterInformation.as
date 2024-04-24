package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AbstractCharacterInformation implements INetworkType
   {
      
      public static const protocolId:uint = 4664;
       
      
      public var id:Number = 0;
      
      public function AbstractCharacterInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4664;
      }
      
      public function initAbstractCharacterInformation(id:Number = 0) : AbstractCharacterInformation
      {
         this.id = id;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractCharacterInformation(output);
      }
      
      public function serializeAs_AbstractCharacterInformation(output:ICustomDataOutput) : void
      {
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarLong(this.id);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractCharacterInformation(input);
      }
      
      public function deserializeAs_AbstractCharacterInformation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractCharacterInformation(tree);
      }
      
      public function deserializeAsyncAs_AbstractCharacterInformation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhLong();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AbstractCharacterInformation.id.");
         }
      }
   }
}
