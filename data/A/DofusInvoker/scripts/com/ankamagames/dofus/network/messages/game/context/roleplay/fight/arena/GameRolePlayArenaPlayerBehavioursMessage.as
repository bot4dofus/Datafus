package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaPlayerBehavioursMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6735;
       
      
      private var _isInitialized:Boolean = false;
      
      public var flags:Vector.<String>;
      
      public var sanctions:Vector.<String>;
      
      public var banDuration:uint = 0;
      
      private var _flagstree:FuncTree;
      
      private var _sanctionstree:FuncTree;
      
      public function GameRolePlayArenaPlayerBehavioursMessage()
      {
         this.flags = new Vector.<String>();
         this.sanctions = new Vector.<String>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6735;
      }
      
      public function initGameRolePlayArenaPlayerBehavioursMessage(flags:Vector.<String> = null, sanctions:Vector.<String> = null, banDuration:uint = 0) : GameRolePlayArenaPlayerBehavioursMessage
      {
         this.flags = flags;
         this.sanctions = sanctions;
         this.banDuration = banDuration;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.flags = new Vector.<String>();
         this.sanctions = new Vector.<String>();
         this.banDuration = 0;
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
         this.serializeAs_GameRolePlayArenaPlayerBehavioursMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaPlayerBehavioursMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.flags.length);
         for(var _i1:uint = 0; _i1 < this.flags.length; _i1++)
         {
            output.writeUTF(this.flags[_i1]);
         }
         output.writeShort(this.sanctions.length);
         for(var _i2:uint = 0; _i2 < this.sanctions.length; _i2++)
         {
            output.writeUTF(this.sanctions[_i2]);
         }
         if(this.banDuration < 0)
         {
            throw new Error("Forbidden value (" + this.banDuration + ") on element banDuration.");
         }
         output.writeInt(this.banDuration);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaPlayerBehavioursMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaPlayerBehavioursMessage(input:ICustomDataInput) : void
      {
         var _val1:String = null;
         var _val2:String = null;
         var _flagsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _flagsLen; _i1++)
         {
            _val1 = input.readUTF();
            this.flags.push(_val1);
         }
         var _sanctionsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _sanctionsLen; _i2++)
         {
            _val2 = input.readUTF();
            this.sanctions.push(_val2);
         }
         this._banDurationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaPlayerBehavioursMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaPlayerBehavioursMessage(tree:FuncTree) : void
      {
         this._flagstree = tree.addChild(this._flagstreeFunc);
         this._sanctionstree = tree.addChild(this._sanctionstreeFunc);
         tree.addChild(this._banDurationFunc);
      }
      
      private function _flagstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._flagstree.addChild(this._flagsFunc);
         }
      }
      
      private function _flagsFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.flags.push(_val);
      }
      
      private function _sanctionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._sanctionstree.addChild(this._sanctionsFunc);
         }
      }
      
      private function _sanctionsFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.sanctions.push(_val);
      }
      
      private function _banDurationFunc(input:ICustomDataInput) : void
      {
         this.banDuration = input.readInt();
         if(this.banDuration < 0)
         {
            throw new Error("Forbidden value (" + this.banDuration + ") on element of GameRolePlayArenaPlayerBehavioursMessage.banDuration.");
         }
      }
   }
}
