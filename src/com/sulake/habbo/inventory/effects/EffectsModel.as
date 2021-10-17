package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;
    import com.sulake.core.window.IWindowContainer;

    public class EffectsModel implements IInventoryModel 
    {

        private var var_2438:HabboInventory;
        private var _view:EffectsView;
        private var var_3705:Array;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _activeEffectsProxy:EffectListProxy;
        private var _inactiveEffectsProxy:EffectListProxy;
        private var _disposed:Boolean = false;

        public function EffectsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager)
        {
            this.var_2438 = param1;
            this.var_3705 = new Array();
            this._assets = param4;
            this._communication = param3;
            this._activeEffectsProxy = new EffectListProxy(this, 1);
            this._inactiveEffectsProxy = new EffectListProxy(this, 0);
            this._view = new EffectsView(this, param2, param4, param5, this._activeEffectsProxy, this._inactiveEffectsProxy);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.var_2438 = null;
                if (this._view != null)
                {
                    this._view.dispose();
                };
                if (this._activeEffectsProxy != null)
                {
                    this._activeEffectsProxy.dispose();
                    this._activeEffectsProxy = null;
                };
                if (this._inactiveEffectsProxy != null)
                {
                    this._inactiveEffectsProxy.dispose();
                    this._inactiveEffectsProxy = null;
                };
                this._disposed = true;
            };
        }

        public function requestInitialization(param1:int=0):void
        {
        }

        public function categorySwitch(param1:String):void
        {
        }

        public function addEffect(param1:Effect, param2:Boolean=true):void
        {
            var _loc4_:BitmapDataAsset;
            var _loc3_:Effect = this.getEffect(param1.type);
            if (_loc3_ != null)
            {
                _loc3_.effectsInInventory++;
            }
            else
            {
                _loc4_ = BitmapDataAsset(this._assets.getAssetByName((("fx_icon_" + param1.type) + "_png")));
                if (_loc4_ != null)
                {
                    param1.iconImage = BitmapData(_loc4_.content);
                };
                this.var_3705.push(param1);
            };
            if (param2)
            {
                this.refreshViews();
            };
        }

        private function getEffect(param1:int):Effect
        {
            var _loc3_:Effect;
            var _loc2_:int;
            while (_loc2_ < this.var_3705.length)
            {
                _loc3_ = this.var_3705[_loc2_];
                if (_loc3_.type == param1)
                {
                    return (_loc3_);
                };
                _loc2_++;
            };
            return (null);
        }

        private function removeEffect(param1:int):void
        {
            var _loc3_:Effect;
            var _loc2_:int;
            while (_loc2_ < this.var_3705.length)
            {
                _loc3_ = this.var_3705[_loc2_];
                if (_loc3_.type == param1)
                {
                    this.var_3705.splice(_loc2_, 1);
                    this.refreshViews();
                    return;
                };
                _loc2_++;
            };
        }

        public function refreshViews():void
        {
            this._view.updateListViews();
            this._view.updateActionView();
        }

        public function requestEffectActivated(param1:int):void
        {
            this.var_2438.communication.getHabboMainConnection(null).send(new AvatarEffectActivatedComposer(param1));
        }

        public function setEffectActivated(param1:int):void
        {
            var _loc2_:Effect = this.getEffect(param1);
            if (_loc2_ != null)
            {
                this.stopUsingAllEffects(false, false);
                _loc2_.isActive = true;
                _loc2_.isInUse = true;
                this.refreshViews();
            };
        }

        public function useEffect(param1:int):void
        {
            this.stopUsingAllEffects(false, false);
            var _loc2_:Effect = this.getEffect(param1);
            if (_loc2_ == null)
            {
                return;
            };
            if (!_loc2_.isActive)
            {
                this.requestEffectActivated(_loc2_.type);
            };
            if (_loc2_.isInUse == false)
            {
                _loc2_.isInUse = true;
                this.var_2438.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(param1));
                this.refreshViews();
            };
        }

        public function stopUsingEffect(param1:int, param2:Boolean=false):void
        {
            var _loc3_:Effect = this.getEffect(param1);
            if (_loc3_ != null)
            {
                if (_loc3_.isInUse == true)
                {
                    _loc3_.isInUse = false;
                    if (param2)
                    {
                        this.var_2438.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(-1));
                    };
                    this.refreshViews();
                };
            };
        }

        public function stopUsingAllEffects(param1:Boolean=true, param2:Boolean=true):void
        {
            var _loc4_:Effect;
            var _loc3_:int;
            while (_loc3_ < this.var_3705.length)
            {
                _loc4_ = this.var_3705[_loc3_];
                _loc4_.isInUse = false;
                _loc3_++;
            };
            if (param1)
            {
                this.var_2438.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(-1));
            };
            if (param2)
            {
                this.refreshViews();
            };
        }

        public function toggleEffectSelected(param1:int):void
        {
            var _loc2_:Effect = this.getEffect(param1);
            if (_loc2_ != null)
            {
                if (_loc2_.isSelected)
                {
                    this.setEffectDeselected(param1);
                }
                else
                {
                    this.setEffectSelected(param1);
                };
                this.refreshViews();
            };
        }

        public function setEffectSelected(param1:int):void
        {
            var _loc2_:Effect = this.getEffect(param1);
            if (_loc2_ != null)
            {
                this.setAllEffectsDeselected(false);
                _loc2_.isSelected = true;
                this.refreshViews();
            };
        }

        public function setEffectDeselected(param1:int):void
        {
            var _loc2_:Effect = this.getEffect(param1);
            if (_loc2_ != null)
            {
                _loc2_.isSelected = false;
                this.refreshViews();
            };
        }

        private function setAllEffectsDeselected(param1:Boolean=true):void
        {
            var _loc3_:Effect;
            var _loc2_:int;
            while (_loc2_ < this.var_3705.length)
            {
                _loc3_ = this.var_3705[_loc2_];
                _loc3_.isSelected = false;
                _loc2_++;
            };
            if (param1)
            {
                this.refreshViews();
            };
        }

        public function getSelectedEffect(param1:int=-1):Effect
        {
            var _loc4_:Effect;
            var _loc2_:Array = this.getEffects(param1);
            var _loc3_:int;
            while (_loc3_ < _loc2_.length)
            {
                _loc4_ = _loc2_[_loc3_];
                if (_loc4_.isSelected)
                {
                    return (_loc4_);
                };
                _loc3_++;
            };
            return (null);
        }

        private function getEffectIndex(param1:int, param2:int=-1):int
        {
            var _loc4_:Array;
            var _loc5_:int;
            var _loc6_:Effect;
            var _loc3_:Effect = this.getEffect(param1);
            if (_loc3_ != null)
            {
                _loc4_ = this.getEffects(param2);
                _loc5_ = 0;
                while (_loc5_ < _loc4_.length)
                {
                    _loc6_ = _loc4_[_loc5_];
                    if (_loc6_.type == param1)
                    {
                        return (_loc5_);
                    };
                    _loc5_++;
                };
            };
            return (-1);
        }

        public function getEffects(param1:int=-1):Array
        {
            var _loc4_:Effect;
            var _loc2_:Array = new Array();
            var _loc3_:int;
            while (_loc3_ < this.var_3705.length)
            {
                _loc4_ = this.var_3705[_loc3_];
                if (((((_loc4_.isActive) && (param1 == 1)) || ((!(_loc4_.isActive)) && (param1 == 0))) || (param1 == -1)))
                {
                    _loc2_.push(_loc4_);
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        public function setEffectExpired(param1:int):void
        {
            var _loc2_:Effect = this.getEffect(param1);
            if (_loc2_ != null)
            {
                if (_loc2_.effectsInInventory > 1)
                {
                    _loc2_.setOneEffectExpired();
                    this.refreshViews();
                }
                else
                {
                    this.removeEffect(_loc2_.type);
                };
            };
        }

        public function getItemInIndex(param1:int, param2:int=-1):Effect
        {
            var _loc3_:Array = this.getEffects(param2);
            if (((param1 < 0) || (param1 >= _loc3_.length)))
            {
                return (null);
            };
            return (_loc3_[param1]);
        }

        public function getWindowContainer():IWindowContainer
        {
            return (this._view.getWindowContainer());
        }

        public function closingInventoryView():void
        {
        }

        public function subCategorySwitch(param1:String):void
        {
        }


    }
}