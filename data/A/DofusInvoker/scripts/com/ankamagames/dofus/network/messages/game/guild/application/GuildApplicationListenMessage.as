package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildApplicationListenMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5367;
       
      
      private var _isInitialized:Boolean = false;
      
      public var listen:Boolean = false;
      
      public function GuildApplicationListenMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5367;
      }
      
      public function initGuildApplicationListenMessage(listen:Boolean = false) : GuildApplicationListenMessage
      {
         this.listen = listen;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.listen = false;
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
         this.serializeAs_GuildApplicationListenMessage(output);
      }
      
      public function serializeAs_GuildApplicationListenMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.listen);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildApplicationListenMessage(input);
      }
      
      public function deserializeAs_GuildApplicationListenMessage(input:ICustomDataInput) : void
      {
         this._listenFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildApplicationListenMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildApplicationListenMessage(tree:FuncTree) : void
      {
         tree.addChild(this._listenFunc);
      }
      
      private function _listenFunc(input:ICustomDataInput) : void
      {
         this.listen = input.readBoolean();
      }
   }
}
