package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PrismFightersInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1824;
       
      
      public var subAreaId:uint = 0;
      
      public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;
      
      public var allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      public var enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      private var _waitingForHelpInfotree:FuncTree;
      
      private var _allyCharactersInformationstree:FuncTree;
      
      private var _enemyCharactersInformationstree:FuncTree;
      
      public function PrismFightersInformation()
      {
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1824;
      }
      
      public function initPrismFightersInformation(subAreaId:uint = 0, waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo = null, allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null, enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null) : PrismFightersInformation
      {
         this.subAreaId = subAreaId;
         this.waitingForHelpInfo = waitingForHelpInfo;
         this.allyCharactersInformations = allyCharactersInformations;
         this.enemyCharactersInformations = enemyCharactersInformations;
         return this;
      }
      
      public function reset() : void
      {
         this.subAreaId = 0;
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PrismFightersInformation(output);
      }
      
      public function serializeAs_PrismFightersInformation(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
         output.writeShort(this.allyCharactersInformations.length);
         for(var _i3:uint = 0; _i3 < this.allyCharactersInformations.length; _i3++)
         {
            output.writeShort((this.allyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).getTypeId());
            (this.allyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).serialize(output);
         }
         output.writeShort(this.enemyCharactersInformations.length);
         for(var _i4:uint = 0; _i4 < this.enemyCharactersInformations.length; _i4++)
         {
            output.writeShort((this.enemyCharactersInformations[_i4] as CharacterMinimalPlusLookInformations).getTypeId());
            (this.enemyCharactersInformations[_i4] as CharacterMinimalPlusLookInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightersInformation(input);
      }
      
      public function deserializeAs_PrismFightersInformation(input:ICustomDataInput) : void
      {
         var _id3:uint = 0;
         var _item3:CharacterMinimalPlusLookInformations = null;
         var _id4:uint = 0;
         var _item4:CharacterMinimalPlusLookInformations = null;
         this._subAreaIdFunc(input);
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.waitingForHelpInfo.deserialize(input);
         var _allyCharactersInformationsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _allyCharactersInformationsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id3);
            _item3.deserialize(input);
            this.allyCharactersInformations.push(_item3);
         }
         var _enemyCharactersInformationsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _enemyCharactersInformationsLen; _i4++)
         {
            _id4 = input.readUnsignedShort();
            _item4 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id4);
            _item4.deserialize(input);
            this.enemyCharactersInformations.push(_item4);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismFightersInformation(tree);
      }
      
      public function deserializeAsyncAs_PrismFightersInformation(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         this._waitingForHelpInfotree = tree.addChild(this._waitingForHelpInfotreeFunc);
         this._allyCharactersInformationstree = tree.addChild(this._allyCharactersInformationstreeFunc);
         this._enemyCharactersInformationstree = tree.addChild(this._enemyCharactersInformationstreeFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightersInformation.subAreaId.");
         }
      }
      
      private function _waitingForHelpInfotreeFunc(input:ICustomDataInput) : void
      {
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.waitingForHelpInfo.deserializeAsync(this._waitingForHelpInfotree);
      }
      
      private function _allyCharactersInformationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._allyCharactersInformationstree.addChild(this._allyCharactersInformationsFunc);
         }
      }
      
      private function _allyCharactersInformationsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:CharacterMinimalPlusLookInformations = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id);
         _item.deserialize(input);
         this.allyCharactersInformations.push(_item);
      }
      
      private function _enemyCharactersInformationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._enemyCharactersInformationstree.addChild(this._enemyCharactersInformationsFunc);
         }
      }
      
      private function _enemyCharactersInformationsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:CharacterMinimalPlusLookInformations = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id);
         _item.deserialize(input);
         this.enemyCharactersInformations.push(_item);
      }
   }
}
