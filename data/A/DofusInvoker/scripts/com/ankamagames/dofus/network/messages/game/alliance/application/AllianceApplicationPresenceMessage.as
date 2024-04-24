package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceApplicationPresenceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8696;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isApplication:Boolean = false;
      
      public function AllianceApplicationPresenceMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8696;
      }
      
      public function initAllianceApplicationPresenceMessage(isApplication:Boolean = false) : AllianceApplicationPresenceMessage
      {
         this.isApplication = isApplication;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.isApplication = false;
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
         this.serializeAs_AllianceApplicationPresenceMessage(output);
      }
      
      public function serializeAs_AllianceApplicationPresenceMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.isApplication);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceApplicationPresenceMessage(input);
      }
      
      public function deserializeAs_AllianceApplicationPresenceMessage(input:ICustomDataInput) : void
      {
         this._isApplicationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceApplicationPresenceMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceApplicationPresenceMessage(tree:FuncTree) : void
      {
         tree.addChild(this._isApplicationFunc);
      }
      
      private function _isApplicationFunc(input:ICustomDataInput) : void
      {
         this.isApplication = input.readBoolean();
      }
   }
}
