package com.ankamagames.dofus.network.types.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ChallengeTargetWithAttackerInformation extends ChallengeTargetInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8417;
       
      
      public var attackersIds:Vector.<Number>;
      
      private var _attackersIdstree:FuncTree;
      
      public function ChallengeTargetWithAttackerInformation()
      {
         this.attackersIds = new Vector.<Number>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8417;
      }
      
      public function initChallengeTargetWithAttackerInformation(targetId:Number = 0, targetCell:int = 0, attackersIds:Vector.<Number> = null) : ChallengeTargetWithAttackerInformation
      {
         super.initChallengeTargetInformation(targetId,targetCell);
         this.attackersIds = attackersIds;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.attackersIds = new Vector.<Number>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ChallengeTargetWithAttackerInformation(output);
      }
      
      public function serializeAs_ChallengeTargetWithAttackerInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChallengeTargetInformation(output);
         output.writeShort(this.attackersIds.length);
         for(var _i1:uint = 0; _i1 < this.attackersIds.length; _i1++)
         {
            if(this.attackersIds[_i1] < -9007199254740992 || this.attackersIds[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.attackersIds[_i1] + ") on element 1 (starting at 1) of attackersIds.");
            }
            output.writeDouble(this.attackersIds[_i1]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeTargetWithAttackerInformation(input);
      }
      
      public function deserializeAs_ChallengeTargetWithAttackerInformation(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         super.deserialize(input);
         var _attackersIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _attackersIdsLen; _i1++)
         {
            _val1 = input.readDouble();
            if(_val1 < -9007199254740992 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of attackersIds.");
            }
            this.attackersIds.push(_val1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeTargetWithAttackerInformation(tree);
      }
      
      public function deserializeAsyncAs_ChallengeTargetWithAttackerInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._attackersIdstree = tree.addChild(this._attackersIdstreeFunc);
      }
      
      private function _attackersIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._attackersIdstree.addChild(this._attackersIdsFunc);
         }
      }
      
      private function _attackersIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readDouble();
         if(_val < -9007199254740992 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of attackersIds.");
         }
         this.attackersIds.push(_val);
      }
   }
}
