package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionOrnament extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 9745;
       
      
      public var ornamentId:uint = 0;
      
      public var level:uint = 0;
      
      public var leagueId:int = 0;
      
      public var ladderPosition:int = 0;
      
      public function HumanOptionOrnament()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9745;
      }
      
      public function initHumanOptionOrnament(ornamentId:uint = 0, level:uint = 0, leagueId:int = 0, ladderPosition:int = 0) : HumanOptionOrnament
      {
         this.ornamentId = ornamentId;
         this.level = level;
         this.leagueId = leagueId;
         this.ladderPosition = ladderPosition;
         return this;
      }
      
      override public function reset() : void
      {
         this.ornamentId = 0;
         this.level = 0;
         this.leagueId = 0;
         this.ladderPosition = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionOrnament(output);
      }
      
      public function serializeAs_HumanOptionOrnament(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element ornamentId.");
         }
         output.writeVarShort(this.ornamentId);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         output.writeVarShort(this.leagueId);
         output.writeInt(this.ladderPosition);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionOrnament(input);
      }
      
      public function deserializeAs_HumanOptionOrnament(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._ornamentIdFunc(input);
         this._levelFunc(input);
         this._leagueIdFunc(input);
         this._ladderPositionFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionOrnament(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionOrnament(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._ornamentIdFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._leagueIdFunc);
         tree.addChild(this._ladderPositionFunc);
      }
      
      private function _ornamentIdFunc(input:ICustomDataInput) : void
      {
         this.ornamentId = input.readVarUhShort();
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element of HumanOptionOrnament.ornamentId.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of HumanOptionOrnament.level.");
         }
      }
      
      private function _leagueIdFunc(input:ICustomDataInput) : void
      {
         this.leagueId = input.readVarShort();
      }
      
      private function _ladderPositionFunc(input:ICustomDataInput) : void
      {
         this.ladderPosition = input.readInt();
      }
   }
}
