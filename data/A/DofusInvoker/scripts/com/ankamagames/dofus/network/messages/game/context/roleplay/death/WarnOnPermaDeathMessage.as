package com.ankamagames.dofus.network.messages.game.context.roleplay.death
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class WarnOnPermaDeathMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4732;
       
      
      private var _isInitialized:Boolean = false;
      
      public var enable:Boolean = false;
      
      public function WarnOnPermaDeathMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4732;
      }
      
      public function initWarnOnPermaDeathMessage(enable:Boolean = false) : WarnOnPermaDeathMessage
      {
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enable = false;
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
         this.serializeAs_WarnOnPermaDeathMessage(output);
      }
      
      public function serializeAs_WarnOnPermaDeathMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_WarnOnPermaDeathMessage(input);
      }
      
      public function deserializeAs_WarnOnPermaDeathMessage(input:ICustomDataInput) : void
      {
         this._enableFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_WarnOnPermaDeathMessage(tree);
      }
      
      public function deserializeAsyncAs_WarnOnPermaDeathMessage(tree:FuncTree) : void
      {
         tree.addChild(this._enableFunc);
      }
      
      private function _enableFunc(input:ICustomDataInput) : void
      {
         this.enable = input.readBoolean();
      }
   }
}
