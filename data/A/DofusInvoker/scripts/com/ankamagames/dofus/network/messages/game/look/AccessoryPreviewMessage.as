package com.ankamagames.dofus.network.messages.game.look
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AccessoryPreviewMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1503;
       
      
      private var _isInitialized:Boolean = false;
      
      public var look:EntityLook;
      
      private var _looktree:FuncTree;
      
      public function AccessoryPreviewMessage()
      {
         this.look = new EntityLook();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1503;
      }
      
      public function initAccessoryPreviewMessage(look:EntityLook = null) : AccessoryPreviewMessage
      {
         this.look = look;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.look = new EntityLook();
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
         this.serializeAs_AccessoryPreviewMessage(output);
      }
      
      public function serializeAs_AccessoryPreviewMessage(output:ICustomDataOutput) : void
      {
         this.look.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccessoryPreviewMessage(input);
      }
      
      public function deserializeAs_AccessoryPreviewMessage(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccessoryPreviewMessage(tree);
      }
      
      public function deserializeAsyncAs_AccessoryPreviewMessage(tree:FuncTree) : void
      {
         this._looktree = tree.addChild(this._looktreeFunc);
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
   }
}
