package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildApplicationPresenceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5980;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isApplication:Boolean = false;
      
      public function GuildApplicationPresenceMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5980;
      }
      
      public function initGuildApplicationPresenceMessage(isApplication:Boolean = false) : GuildApplicationPresenceMessage
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
         this.serializeAs_GuildApplicationPresenceMessage(output);
      }
      
      public function serializeAs_GuildApplicationPresenceMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.isApplication);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildApplicationPresenceMessage(input);
      }
      
      public function deserializeAs_GuildApplicationPresenceMessage(input:ICustomDataInput) : void
      {
         this._isApplicationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildApplicationPresenceMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildApplicationPresenceMessage(tree:FuncTree) : void
      {
         tree.addChild(this._isApplicationFunc);
      }
      
      private function _isApplicationFunc(input:ICustomDataInput) : void
      {
         this.isApplication = input.readBoolean();
      }
   }
}
