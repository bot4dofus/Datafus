package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PortalUseRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6790;
       
      
      private var _isInitialized:Boolean = false;
      
      public var portalId:uint = 0;
      
      public function PortalUseRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6790;
      }
      
      public function initPortalUseRequestMessage(portalId:uint = 0) : PortalUseRequestMessage
      {
         this.portalId = portalId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.portalId = 0;
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
         this.serializeAs_PortalUseRequestMessage(output);
      }
      
      public function serializeAs_PortalUseRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.portalId < 0)
         {
            throw new Error("Forbidden value (" + this.portalId + ") on element portalId.");
         }
         output.writeVarInt(this.portalId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PortalUseRequestMessage(input);
      }
      
      public function deserializeAs_PortalUseRequestMessage(input:ICustomDataInput) : void
      {
         this._portalIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PortalUseRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PortalUseRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._portalIdFunc);
      }
      
      private function _portalIdFunc(input:ICustomDataInput) : void
      {
         this.portalId = input.readVarUhInt();
         if(this.portalId < 0)
         {
            throw new Error("Forbidden value (" + this.portalId + ") on element of PortalUseRequestMessage.portalId.");
         }
      }
   }
}
