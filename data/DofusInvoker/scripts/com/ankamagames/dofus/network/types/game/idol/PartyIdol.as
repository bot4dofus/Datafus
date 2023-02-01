package com.ankamagames.dofus.network.types.game.idol
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PartyIdol extends Idol implements INetworkType
   {
      
      public static const protocolId:uint = 8979;
       
      
      public var ownersIds:Vector.<Number>;
      
      private var _ownersIdstree:FuncTree;
      
      public function PartyIdol()
      {
         this.ownersIds = new Vector.<Number>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8979;
      }
      
      public function initPartyIdol(id:uint = 0, xpBonusPercent:uint = 0, dropBonusPercent:uint = 0, ownersIds:Vector.<Number> = null) : PartyIdol
      {
         super.initIdol(id,xpBonusPercent,dropBonusPercent);
         this.ownersIds = ownersIds;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.ownersIds = new Vector.<Number>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyIdol(output);
      }
      
      public function serializeAs_PartyIdol(output:ICustomDataOutput) : void
      {
         super.serializeAs_Idol(output);
         output.writeShort(this.ownersIds.length);
         for(var _i1:uint = 0; _i1 < this.ownersIds.length; _i1++)
         {
            if(this.ownersIds[_i1] < 0 || this.ownersIds[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.ownersIds[_i1] + ") on element 1 (starting at 1) of ownersIds.");
            }
            output.writeVarLong(this.ownersIds[_i1]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyIdol(input);
      }
      
      public function deserializeAs_PartyIdol(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         super.deserialize(input);
         var _ownersIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _ownersIdsLen; _i1++)
         {
            _val1 = input.readVarUhLong();
            if(_val1 < 0 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of ownersIds.");
            }
            this.ownersIds.push(_val1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyIdol(tree);
      }
      
      public function deserializeAsyncAs_PartyIdol(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._ownersIdstree = tree.addChild(this._ownersIdstreeFunc);
      }
      
      private function _ownersIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._ownersIdstree.addChild(this._ownersIdsFunc);
         }
      }
      
      private function _ownersIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readVarUhLong();
         if(_val < 0 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ownersIds.");
         }
         this.ownersIds.push(_val);
      }
   }
}
