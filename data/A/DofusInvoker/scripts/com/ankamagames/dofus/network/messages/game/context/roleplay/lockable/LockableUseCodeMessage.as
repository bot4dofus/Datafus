package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LockableUseCodeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3147;
       
      
      private var _isInitialized:Boolean = false;
      
      public var code:String = "";
      
      public function LockableUseCodeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3147;
      }
      
      public function initLockableUseCodeMessage(code:String = "") : LockableUseCodeMessage
      {
         this.code = code;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.code = "";
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
         this.serializeAs_LockableUseCodeMessage(output);
      }
      
      public function serializeAs_LockableUseCodeMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.code);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LockableUseCodeMessage(input);
      }
      
      public function deserializeAs_LockableUseCodeMessage(input:ICustomDataInput) : void
      {
         this._codeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LockableUseCodeMessage(tree);
      }
      
      public function deserializeAsyncAs_LockableUseCodeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._codeFunc);
      }
      
      private function _codeFunc(input:ICustomDataInput) : void
      {
         this.code = input.readUTF();
      }
   }
}
