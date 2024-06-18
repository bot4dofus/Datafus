package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayNpcQuestFlag implements INetworkType
   {
      
      public static const protocolId:uint = 6478;
       
      
      public var questsToValidId:Vector.<uint>;
      
      public var questsToStartId:Vector.<uint>;
      
      private var _questsToValidIdtree:FuncTree;
      
      private var _questsToStartIdtree:FuncTree;
      
      public function GameRolePlayNpcQuestFlag()
      {
         this.questsToValidId = new Vector.<uint>();
         this.questsToStartId = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6478;
      }
      
      public function initGameRolePlayNpcQuestFlag(questsToValidId:Vector.<uint> = null, questsToStartId:Vector.<uint> = null) : GameRolePlayNpcQuestFlag
      {
         this.questsToValidId = questsToValidId;
         this.questsToStartId = questsToStartId;
         return this;
      }
      
      public function reset() : void
      {
         this.questsToValidId = new Vector.<uint>();
         this.questsToStartId = new Vector.<uint>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayNpcQuestFlag(output);
      }
      
      public function serializeAs_GameRolePlayNpcQuestFlag(output:ICustomDataOutput) : void
      {
         output.writeShort(this.questsToValidId.length);
         for(var _i1:uint = 0; _i1 < this.questsToValidId.length; _i1++)
         {
            if(this.questsToValidId[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.questsToValidId[_i1] + ") on element 1 (starting at 1) of questsToValidId.");
            }
            output.writeVarShort(this.questsToValidId[_i1]);
         }
         output.writeShort(this.questsToStartId.length);
         for(var _i2:uint = 0; _i2 < this.questsToStartId.length; _i2++)
         {
            if(this.questsToStartId[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.questsToStartId[_i2] + ") on element 2 (starting at 1) of questsToStartId.");
            }
            output.writeVarShort(this.questsToStartId[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayNpcQuestFlag(input);
      }
      
      public function deserializeAs_GameRolePlayNpcQuestFlag(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _questsToValidIdLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _questsToValidIdLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of questsToValidId.");
            }
            this.questsToValidId.push(_val1);
         }
         var _questsToStartIdLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _questsToStartIdLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of questsToStartId.");
            }
            this.questsToStartId.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayNpcQuestFlag(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayNpcQuestFlag(tree:FuncTree) : void
      {
         this._questsToValidIdtree = tree.addChild(this._questsToValidIdtreeFunc);
         this._questsToStartIdtree = tree.addChild(this._questsToStartIdtreeFunc);
      }
      
      private function _questsToValidIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._questsToValidIdtree.addChild(this._questsToValidIdFunc);
         }
      }
      
      private function _questsToValidIdFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of questsToValidId.");
         }
         this.questsToValidId.push(_val);
      }
      
      private function _questsToStartIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._questsToStartIdtree.addChild(this._questsToStartIdFunc);
         }
      }
      
      private function _questsToStartIdFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of questsToStartId.");
         }
         this.questsToStartId.push(_val);
      }
   }
}
