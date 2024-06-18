package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightCommonInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9113;
       
      
      public var fightId:uint = 0;
      
      public var fightType:uint = 0;
      
      public var fightTeams:Vector.<FightTeamInformations>;
      
      public var fightTeamsPositions:Vector.<uint>;
      
      public var fightTeamsOptions:Vector.<FightOptionsInformations>;
      
      private var _fightTeamstree:FuncTree;
      
      private var _fightTeamsPositionstree:FuncTree;
      
      private var _fightTeamsOptionstree:FuncTree;
      
      public function FightCommonInformations()
      {
         this.fightTeams = new Vector.<FightTeamInformations>();
         this.fightTeamsPositions = new Vector.<uint>();
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9113;
      }
      
      public function initFightCommonInformations(fightId:uint = 0, fightType:uint = 0, fightTeams:Vector.<FightTeamInformations> = null, fightTeamsPositions:Vector.<uint> = null, fightTeamsOptions:Vector.<FightOptionsInformations> = null) : FightCommonInformations
      {
         this.fightId = fightId;
         this.fightType = fightType;
         this.fightTeams = fightTeams;
         this.fightTeamsPositions = fightTeamsPositions;
         this.fightTeamsOptions = fightTeamsOptions;
         return this;
      }
      
      public function reset() : void
      {
         this.fightId = 0;
         this.fightType = 0;
         this.fightTeams = new Vector.<FightTeamInformations>();
         this.fightTeamsPositions = new Vector.<uint>();
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightCommonInformations(output);
      }
      
      public function serializeAs_FightCommonInformations(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeByte(this.fightType);
         output.writeShort(this.fightTeams.length);
         for(var _i3:uint = 0; _i3 < this.fightTeams.length; _i3++)
         {
            output.writeShort((this.fightTeams[_i3] as FightTeamInformations).getTypeId());
            (this.fightTeams[_i3] as FightTeamInformations).serialize(output);
         }
         output.writeShort(this.fightTeamsPositions.length);
         for(var _i4:uint = 0; _i4 < this.fightTeamsPositions.length; _i4++)
         {
            if(this.fightTeamsPositions[_i4] < 0 || this.fightTeamsPositions[_i4] > 559)
            {
               throw new Error("Forbidden value (" + this.fightTeamsPositions[_i4] + ") on element 4 (starting at 1) of fightTeamsPositions.");
            }
            output.writeVarShort(this.fightTeamsPositions[_i4]);
         }
         output.writeShort(this.fightTeamsOptions.length);
         for(var _i5:uint = 0; _i5 < this.fightTeamsOptions.length; _i5++)
         {
            (this.fightTeamsOptions[_i5] as FightOptionsInformations).serializeAs_FightOptionsInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightCommonInformations(input);
      }
      
      public function deserializeAs_FightCommonInformations(input:ICustomDataInput) : void
      {
         var _id3:uint = 0;
         var _item3:FightTeamInformations = null;
         var _val4:uint = 0;
         var _item5:FightOptionsInformations = null;
         this._fightIdFunc(input);
         this._fightTypeFunc(input);
         var _fightTeamsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _fightTeamsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(FightTeamInformations,_id3);
            _item3.deserialize(input);
            this.fightTeams.push(_item3);
         }
         var _fightTeamsPositionsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _fightTeamsPositionsLen; _i4++)
         {
            _val4 = input.readVarUhShort();
            if(_val4 < 0 || _val4 > 559)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of fightTeamsPositions.");
            }
            this.fightTeamsPositions.push(_val4);
         }
         var _fightTeamsOptionsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _fightTeamsOptionsLen; _i5++)
         {
            _item5 = new FightOptionsInformations();
            _item5.deserialize(input);
            this.fightTeamsOptions.push(_item5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightCommonInformations(tree);
      }
      
      public function deserializeAsyncAs_FightCommonInformations(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._fightTypeFunc);
         this._fightTeamstree = tree.addChild(this._fightTeamstreeFunc);
         this._fightTeamsPositionstree = tree.addChild(this._fightTeamsPositionstreeFunc);
         this._fightTeamsOptionstree = tree.addChild(this._fightTeamsOptionstreeFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of FightCommonInformations.fightId.");
         }
      }
      
      private function _fightTypeFunc(input:ICustomDataInput) : void
      {
         this.fightType = input.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of FightCommonInformations.fightType.");
         }
      }
      
      private function _fightTeamstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._fightTeamstree.addChild(this._fightTeamsFunc);
         }
      }
      
      private function _fightTeamsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:FightTeamInformations = ProtocolTypeManager.getInstance(FightTeamInformations,_id);
         _item.deserialize(input);
         this.fightTeams.push(_item);
      }
      
      private function _fightTeamsPositionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._fightTeamsPositionstree.addChild(this._fightTeamsPositionsFunc);
         }
      }
      
      private function _fightTeamsPositionsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0 || _val > 559)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of fightTeamsPositions.");
         }
         this.fightTeamsPositions.push(_val);
      }
      
      private function _fightTeamsOptionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._fightTeamsOptionstree.addChild(this._fightTeamsOptionsFunc);
         }
      }
      
      private function _fightTeamsOptionsFunc(input:ICustomDataInput) : void
      {
         var _item:FightOptionsInformations = new FightOptionsInformations();
         _item.deserialize(input);
         this.fightTeamsOptions.push(_item);
      }
   }
}
