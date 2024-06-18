package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameContextRefreshEntityLookMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7865;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:Number = 0;
      
      public var look:EntityLook;
      
      private var _looktree:FuncTree;
      
      public function GameContextRefreshEntityLookMessage()
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
         return 7865;
      }
      
      public function initGameContextRefreshEntityLookMessage(id:Number = 0, look:EntityLook = null) : GameContextRefreshEntityLookMessage
      {
         this.id = id;
         this.look = look;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
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
         this.serializeAs_GameContextRefreshEntityLookMessage(output);
      }
      
      public function serializeAs_GameContextRefreshEntityLookMessage(output:ICustomDataOutput) : void
      {
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         this.look.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextRefreshEntityLookMessage(input);
      }
      
      public function deserializeAs_GameContextRefreshEntityLookMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextRefreshEntityLookMessage(tree);
      }
      
      public function deserializeAsyncAs_GameContextRefreshEntityLookMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         this._looktree = tree.addChild(this._looktreeFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameContextRefreshEntityLookMessage.id.");
         }
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
   }
}
