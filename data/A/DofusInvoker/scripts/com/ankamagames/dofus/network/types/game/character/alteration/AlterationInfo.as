package com.ankamagames.dofus.network.types.game.character.alteration
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AlterationInfo implements INetworkType
   {
      
      public static const protocolId:uint = 7621;
       
      
      public var alterationId:uint = 0;
      
      public var creationTime:Number = 0;
      
      public var expirationType:uint = 1;
      
      public var expirationValue:Number = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      private var _effectstree:FuncTree;
      
      public function AlterationInfo()
      {
         this.effects = new Vector.<ObjectEffect>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7621;
      }
      
      public function initAlterationInfo(alterationId:uint = 0, creationTime:Number = 0, expirationType:uint = 1, expirationValue:Number = 0, effects:Vector.<ObjectEffect> = null) : AlterationInfo
      {
         this.alterationId = alterationId;
         this.creationTime = creationTime;
         this.expirationType = expirationType;
         this.expirationValue = expirationValue;
         this.effects = effects;
         return this;
      }
      
      public function reset() : void
      {
         this.alterationId = 0;
         this.creationTime = 0;
         this.expirationType = 1;
         this.expirationValue = 0;
         this.effects = new Vector.<ObjectEffect>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AlterationInfo(output);
      }
      
      public function serializeAs_AlterationInfo(output:ICustomDataOutput) : void
      {
         if(this.alterationId < 0 || this.alterationId > 4294967295)
         {
            throw new Error("Forbidden value (" + this.alterationId + ") on element alterationId.");
         }
         output.writeUnsignedInt(this.alterationId);
         if(this.creationTime < -9007199254740992 || this.creationTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.creationTime + ") on element creationTime.");
         }
         output.writeDouble(this.creationTime);
         output.writeByte(this.expirationType);
         if(this.expirationValue < -9007199254740992 || this.expirationValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expirationValue + ") on element expirationValue.");
         }
         output.writeDouble(this.expirationValue);
         output.writeShort(this.effects.length);
         for(var _i5:uint = 0; _i5 < this.effects.length; _i5++)
         {
            output.writeShort((this.effects[_i5] as ObjectEffect).getTypeId());
            (this.effects[_i5] as ObjectEffect).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlterationInfo(input);
      }
      
      public function deserializeAs_AlterationInfo(input:ICustomDataInput) : void
      {
         var _id5:uint = 0;
         var _item5:ObjectEffect = null;
         this._alterationIdFunc(input);
         this._creationTimeFunc(input);
         this._expirationTypeFunc(input);
         this._expirationValueFunc(input);
         var _effectsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _effectsLen; _i5++)
         {
            _id5 = input.readUnsignedShort();
            _item5 = ProtocolTypeManager.getInstance(ObjectEffect,_id5);
            _item5.deserialize(input);
            this.effects.push(_item5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlterationInfo(tree);
      }
      
      public function deserializeAsyncAs_AlterationInfo(tree:FuncTree) : void
      {
         tree.addChild(this._alterationIdFunc);
         tree.addChild(this._creationTimeFunc);
         tree.addChild(this._expirationTypeFunc);
         tree.addChild(this._expirationValueFunc);
         this._effectstree = tree.addChild(this._effectstreeFunc);
      }
      
      private function _alterationIdFunc(input:ICustomDataInput) : void
      {
         this.alterationId = input.readUnsignedInt();
         if(this.alterationId < 0 || this.alterationId > 4294967295)
         {
            throw new Error("Forbidden value (" + this.alterationId + ") on element of AlterationInfo.alterationId.");
         }
      }
      
      private function _creationTimeFunc(input:ICustomDataInput) : void
      {
         this.creationTime = input.readDouble();
         if(this.creationTime < -9007199254740992 || this.creationTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.creationTime + ") on element of AlterationInfo.creationTime.");
         }
      }
      
      private function _expirationTypeFunc(input:ICustomDataInput) : void
      {
         this.expirationType = input.readByte();
         if(this.expirationType < 0)
         {
            throw new Error("Forbidden value (" + this.expirationType + ") on element of AlterationInfo.expirationType.");
         }
      }
      
      private function _expirationValueFunc(input:ICustomDataInput) : void
      {
         this.expirationValue = input.readDouble();
         if(this.expirationValue < -9007199254740992 || this.expirationValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expirationValue + ") on element of AlterationInfo.expirationValue.");
         }
      }
      
      private function _effectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._effectstree.addChild(this._effectsFunc);
         }
      }
      
      private function _effectsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:ObjectEffect = ProtocolTypeManager.getInstance(ObjectEffect,_id);
         _item.deserialize(input);
         this.effects.push(_item);
      }
   }
}
