package com.ankamagames.dofus.network.types.game.context.roleplay.npc
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MapNpcQuestInfo implements INetworkType
   {
      
      public static const protocolId:uint = 7887;
       
      
      public var mapId:Number = 0;
      
      public var npcsIdsWithQuest:Vector.<int>;
      
      public var questFlags:Vector.<GameRolePlayNpcQuestFlag>;
      
      private var _npcsIdsWithQuesttree:FuncTree;
      
      private var _questFlagstree:FuncTree;
      
      public function MapNpcQuestInfo()
      {
         this.npcsIdsWithQuest = new Vector.<int>();
         this.questFlags = new Vector.<GameRolePlayNpcQuestFlag>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7887;
      }
      
      public function initMapNpcQuestInfo(mapId:Number = 0, npcsIdsWithQuest:Vector.<int> = null, questFlags:Vector.<GameRolePlayNpcQuestFlag> = null) : MapNpcQuestInfo
      {
         this.mapId = mapId;
         this.npcsIdsWithQuest = npcsIdsWithQuest;
         this.questFlags = questFlags;
         return this;
      }
      
      public function reset() : void
      {
         this.mapId = 0;
         this.npcsIdsWithQuest = new Vector.<int>();
         this.questFlags = new Vector.<GameRolePlayNpcQuestFlag>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MapNpcQuestInfo(output);
      }
      
      public function serializeAs_MapNpcQuestInfo(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeShort(this.npcsIdsWithQuest.length);
         for(var _i2:uint = 0; _i2 < this.npcsIdsWithQuest.length; _i2++)
         {
            output.writeInt(this.npcsIdsWithQuest[_i2]);
         }
         output.writeShort(this.questFlags.length);
         for(var _i3:uint = 0; _i3 < this.questFlags.length; _i3++)
         {
            (this.questFlags[_i3] as GameRolePlayNpcQuestFlag).serializeAs_GameRolePlayNpcQuestFlag(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapNpcQuestInfo(input);
      }
      
      public function deserializeAs_MapNpcQuestInfo(input:ICustomDataInput) : void
      {
         var _val2:int = 0;
         var _item3:GameRolePlayNpcQuestFlag = null;
         this._mapIdFunc(input);
         var _npcsIdsWithQuestLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _npcsIdsWithQuestLen; _i2++)
         {
            _val2 = input.readInt();
            this.npcsIdsWithQuest.push(_val2);
         }
         var _questFlagsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _questFlagsLen; _i3++)
         {
            _item3 = new GameRolePlayNpcQuestFlag();
            _item3.deserialize(input);
            this.questFlags.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapNpcQuestInfo(tree);
      }
      
      public function deserializeAsyncAs_MapNpcQuestInfo(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         this._npcsIdsWithQuesttree = tree.addChild(this._npcsIdsWithQuesttreeFunc);
         this._questFlagstree = tree.addChild(this._questFlagstreeFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of MapNpcQuestInfo.mapId.");
         }
      }
      
      private function _npcsIdsWithQuesttreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._npcsIdsWithQuesttree.addChild(this._npcsIdsWithQuestFunc);
         }
      }
      
      private function _npcsIdsWithQuestFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readInt();
         this.npcsIdsWithQuest.push(_val);
      }
      
      private function _questFlagstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._questFlagstree.addChild(this._questFlagsFunc);
         }
      }
      
      private function _questFlagsFunc(input:ICustomDataInput) : void
      {
         var _item:GameRolePlayNpcQuestFlag = new GameRolePlayNpcQuestFlag();
         _item.deserialize(input);
         this.questFlags.push(_item);
      }
   }
}
