package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobMultiCraftAvailableSkillsMessage extends JobAllowMultiCraftRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6031;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerId:Number = 0;
      
      public var skills:Vector.<uint>;
      
      private var _skillstree:FuncTree;
      
      public function JobMultiCraftAvailableSkillsMessage()
      {
         this.skills = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6031;
      }
      
      public function initJobMultiCraftAvailableSkillsMessage(enabled:Boolean = false, playerId:Number = 0, skills:Vector.<uint> = null) : JobMultiCraftAvailableSkillsMessage
      {
         super.initJobAllowMultiCraftRequestMessage(enabled);
         this.playerId = playerId;
         this.skills = skills;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.skills = new Vector.<uint>();
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
         this.serializeAs_JobMultiCraftAvailableSkillsMessage(output);
      }
      
      public function serializeAs_JobMultiCraftAvailableSkillsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_JobAllowMultiCraftRequestMessage(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeShort(this.skills.length);
         for(var _i2:uint = 0; _i2 < this.skills.length; _i2++)
         {
            if(this.skills[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.skills[_i2] + ") on element 2 (starting at 1) of skills.");
            }
            output.writeVarShort(this.skills[_i2]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobMultiCraftAvailableSkillsMessage(input);
      }
      
      public function deserializeAs_JobMultiCraftAvailableSkillsMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         super.deserialize(input);
         this._playerIdFunc(input);
         var _skillsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _skillsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of skills.");
            }
            this.skills.push(_val2);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobMultiCraftAvailableSkillsMessage(tree);
      }
      
      public function deserializeAsyncAs_JobMultiCraftAvailableSkillsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
         this._skillstree = tree.addChild(this._skillstreeFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobMultiCraftAvailableSkillsMessage.playerId.");
         }
      }
      
      private function _skillstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._skillstree.addChild(this._skillsFunc);
         }
      }
      
      private function _skillsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of skills.");
         }
         this.skills.push(_val);
      }
   }
}
