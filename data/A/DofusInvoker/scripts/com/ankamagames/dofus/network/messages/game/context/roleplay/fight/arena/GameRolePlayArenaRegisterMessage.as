package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaRegisterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2855;
       
      
      private var _isInitialized:Boolean = false;
      
      public var arenaType:uint = 3;
      
      public function GameRolePlayArenaRegisterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2855;
      }
      
      public function initGameRolePlayArenaRegisterMessage(arenaType:uint = 3) : GameRolePlayArenaRegisterMessage
      {
         this.arenaType = arenaType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.arenaType = 3;
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
         this.serializeAs_GameRolePlayArenaRegisterMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaRegisterMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.arenaType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaRegisterMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaRegisterMessage(input:ICustomDataInput) : void
      {
         this._arenaTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaRegisterMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaRegisterMessage(tree:FuncTree) : void
      {
         tree.addChild(this._arenaTypeFunc);
      }
      
      private function _arenaTypeFunc(input:ICustomDataInput) : void
      {
         this.arenaType = input.readInt();
         if(this.arenaType < 0)
         {
            throw new Error("Forbidden value (" + this.arenaType + ") on element of GameRolePlayArenaRegisterMessage.arenaType.");
         }
      }
   }
}
