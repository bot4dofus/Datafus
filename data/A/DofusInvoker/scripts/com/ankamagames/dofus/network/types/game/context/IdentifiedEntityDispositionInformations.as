package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class IdentifiedEntityDispositionInformations extends EntityDispositionInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6579;
       
      
      public var id:Number = 0;
      
      public function IdentifiedEntityDispositionInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6579;
      }
      
      public function initIdentifiedEntityDispositionInformations(cellId:int = 0, direction:uint = 1, id:Number = 0) : IdentifiedEntityDispositionInformations
      {
         super.initEntityDispositionInformations(cellId,direction);
         this.id = id;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.id = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IdentifiedEntityDispositionInformations(output);
      }
      
      public function serializeAs_IdentifiedEntityDispositionInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_EntityDispositionInformations(output);
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdentifiedEntityDispositionInformations(input);
      }
      
      public function deserializeAs_IdentifiedEntityDispositionInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._idFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdentifiedEntityDispositionInformations(tree);
      }
      
      public function deserializeAsyncAs_IdentifiedEntityDispositionInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of IdentifiedEntityDispositionInformations.id.");
         }
      }
   }
}
