package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachTeleportResponseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1178;
       
      
      private var _isInitialized:Boolean = false;
      
      public var teleported:Boolean = false;
      
      public function BreachTeleportResponseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1178;
      }
      
      public function initBreachTeleportResponseMessage(teleported:Boolean = false) : BreachTeleportResponseMessage
      {
         this.teleported = teleported;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.teleported = false;
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
         this.serializeAs_BreachTeleportResponseMessage(output);
      }
      
      public function serializeAs_BreachTeleportResponseMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.teleported);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachTeleportResponseMessage(input);
      }
      
      public function deserializeAs_BreachTeleportResponseMessage(input:ICustomDataInput) : void
      {
         this._teleportedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachTeleportResponseMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachTeleportResponseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._teleportedFunc);
      }
      
      private function _teleportedFunc(input:ICustomDataInput) : void
      {
         this.teleported = input.readBoolean();
      }
   }
}
