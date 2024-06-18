package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ServerSettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 154;
       
      
      private var _isInitialized:Boolean = false;
      
      public var lang:String = "";
      
      public var community:uint = 0;
      
      public var gameType:int = -1;
      
      public var isMonoAccount:Boolean = false;
      
      public var arenaLeaveBanTime:uint = 0;
      
      public var itemMaxLevel:uint = 0;
      
      public var hasFreeAutopilot:Boolean = false;
      
      public function ServerSettingsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 154;
      }
      
      public function initServerSettingsMessage(lang:String = "", community:uint = 0, gameType:int = -1, isMonoAccount:Boolean = false, arenaLeaveBanTime:uint = 0, itemMaxLevel:uint = 0, hasFreeAutopilot:Boolean = false) : ServerSettingsMessage
      {
         this.lang = lang;
         this.community = community;
         this.gameType = gameType;
         this.isMonoAccount = isMonoAccount;
         this.arenaLeaveBanTime = arenaLeaveBanTime;
         this.itemMaxLevel = itemMaxLevel;
         this.hasFreeAutopilot = hasFreeAutopilot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.lang = "";
         this.community = 0;
         this.gameType = -1;
         this.isMonoAccount = false;
         this.arenaLeaveBanTime = 0;
         this.itemMaxLevel = 0;
         this.hasFreeAutopilot = false;
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
         this.serializeAs_ServerSettingsMessage(output);
      }
      
      public function serializeAs_ServerSettingsMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.isMonoAccount);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.hasFreeAutopilot);
         output.writeByte(_box0);
         output.writeUTF(this.lang);
         if(this.community < 0)
         {
            throw new Error("Forbidden value (" + this.community + ") on element community.");
         }
         output.writeByte(this.community);
         output.writeByte(this.gameType);
         if(this.arenaLeaveBanTime < 0)
         {
            throw new Error("Forbidden value (" + this.arenaLeaveBanTime + ") on element arenaLeaveBanTime.");
         }
         output.writeVarShort(this.arenaLeaveBanTime);
         if(this.itemMaxLevel < 0)
         {
            throw new Error("Forbidden value (" + this.itemMaxLevel + ") on element itemMaxLevel.");
         }
         output.writeInt(this.itemMaxLevel);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSettingsMessage(input);
      }
      
      public function deserializeAs_ServerSettingsMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._langFunc(input);
         this._communityFunc(input);
         this._gameTypeFunc(input);
         this._arenaLeaveBanTimeFunc(input);
         this._itemMaxLevelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerSettingsMessage(tree);
      }
      
      public function deserializeAsyncAs_ServerSettingsMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._langFunc);
         tree.addChild(this._communityFunc);
         tree.addChild(this._gameTypeFunc);
         tree.addChild(this._arenaLeaveBanTimeFunc);
         tree.addChild(this._itemMaxLevelFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.isMonoAccount = BooleanByteWrapper.getFlag(_box0,0);
         this.hasFreeAutopilot = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _langFunc(input:ICustomDataInput) : void
      {
         this.lang = input.readUTF();
      }
      
      private function _communityFunc(input:ICustomDataInput) : void
      {
         this.community = input.readByte();
         if(this.community < 0)
         {
            throw new Error("Forbidden value (" + this.community + ") on element of ServerSettingsMessage.community.");
         }
      }
      
      private function _gameTypeFunc(input:ICustomDataInput) : void
      {
         this.gameType = input.readByte();
      }
      
      private function _arenaLeaveBanTimeFunc(input:ICustomDataInput) : void
      {
         this.arenaLeaveBanTime = input.readVarUhShort();
         if(this.arenaLeaveBanTime < 0)
         {
            throw new Error("Forbidden value (" + this.arenaLeaveBanTime + ") on element of ServerSettingsMessage.arenaLeaveBanTime.");
         }
      }
      
      private function _itemMaxLevelFunc(input:ICustomDataInput) : void
      {
         this.itemMaxLevel = input.readInt();
         if(this.itemMaxLevel < 0)
         {
            throw new Error("Forbidden value (" + this.itemMaxLevel + ") on element of ServerSettingsMessage.itemMaxLevel.");
         }
      }
   }
}
