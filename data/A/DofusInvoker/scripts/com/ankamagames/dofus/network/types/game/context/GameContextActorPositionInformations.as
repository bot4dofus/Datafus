package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameContextActorPositionInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3228;
       
      
      public var contextualId:Number = 0;
      
      public var disposition:EntityDispositionInformations;
      
      private var _dispositiontree:FuncTree;
      
      public function GameContextActorPositionInformations()
      {
         this.disposition = new EntityDispositionInformations();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3228;
      }
      
      public function initGameContextActorPositionInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null) : GameContextActorPositionInformations
      {
         this.contextualId = contextualId;
         this.disposition = disposition;
         return this;
      }
      
      public function reset() : void
      {
         this.contextualId = 0;
         this.disposition = new EntityDispositionInformations();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameContextActorPositionInformations(output);
      }
      
      public function serializeAs_GameContextActorPositionInformations(output:ICustomDataOutput) : void
      {
         if(this.contextualId < -9007199254740992 || this.contextualId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.contextualId + ") on element contextualId.");
         }
         output.writeDouble(this.contextualId);
         output.writeShort(this.disposition.getTypeId());
         this.disposition.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextActorPositionInformations(input);
      }
      
      public function deserializeAs_GameContextActorPositionInformations(input:ICustomDataInput) : void
      {
         this._contextualIdFunc(input);
         var _id2:uint = input.readUnsignedShort();
         this.disposition = ProtocolTypeManager.getInstance(EntityDispositionInformations,_id2);
         this.disposition.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextActorPositionInformations(tree);
      }
      
      public function deserializeAsyncAs_GameContextActorPositionInformations(tree:FuncTree) : void
      {
         tree.addChild(this._contextualIdFunc);
         this._dispositiontree = tree.addChild(this._dispositiontreeFunc);
      }
      
      private function _contextualIdFunc(input:ICustomDataInput) : void
      {
         this.contextualId = input.readDouble();
         if(this.contextualId < -9007199254740992 || this.contextualId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.contextualId + ") on element of GameContextActorPositionInformations.contextualId.");
         }
      }
      
      private function _dispositiontreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.disposition = ProtocolTypeManager.getInstance(EntityDispositionInformations,_id);
         this.disposition.deserializeAsync(this._dispositiontree);
      }
   }
}
