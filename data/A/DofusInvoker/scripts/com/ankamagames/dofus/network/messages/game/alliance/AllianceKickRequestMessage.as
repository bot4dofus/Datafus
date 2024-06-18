package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceKickRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4578;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kickedId:Number = 0;
      
      public function AllianceKickRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4578;
      }
      
      public function initAllianceKickRequestMessage(kickedId:Number = 0) : AllianceKickRequestMessage
      {
         this.kickedId = kickedId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kickedId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceKickRequestMessage(output);
      }
      
      public function serializeAs_AllianceKickRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.kickedId < -9007199254740992 || this.kickedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kickedId + ") on element kickedId.");
         }
         output.writeVarLong(this.kickedId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceKickRequestMessage(input);
      }
      
      public function deserializeAs_AllianceKickRequestMessage(input:ICustomDataInput) : void
      {
         this._kickedIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceKickRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceKickRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._kickedIdFunc);
      }
      
      private function _kickedIdFunc(input:ICustomDataInput) : void
      {
         this.kickedId = input.readVarLong();
         if(this.kickedId < -9007199254740992 || this.kickedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kickedId + ") on element of AllianceKickRequestMessage.kickedId.");
         }
      }
   }
}
