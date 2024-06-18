package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AdminQuietCommandMessage extends AdminCommandMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8282;
       
      
      private var _isInitialized:Boolean = false;
      
      public function AdminQuietCommandMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8282;
      }
      
      public function initAdminQuietCommandMessage(messageUuid:Uuid = null, content:String = "") : AdminQuietCommandMessage
      {
         super.initAdminCommandMessage(messageUuid,content);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AdminQuietCommandMessage(output);
      }
      
      public function serializeAs_AdminQuietCommandMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AdminCommandMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AdminQuietCommandMessage(input);
      }
      
      public function deserializeAs_AdminQuietCommandMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AdminQuietCommandMessage(tree);
      }
      
      public function deserializeAsyncAs_AdminQuietCommandMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
