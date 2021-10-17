package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.common.ISideContentModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.session.HabboClubLevelEnum;

    public class WardrobeModel implements ISideContentModel 
    {

        private var var_2438:HabboAvatarEditor;
        private var _view:WardrobeView;
        private var var_2995:Map;
        private var _isInitialized:Boolean = false;

        public function WardrobeModel(param1:HabboAvatarEditor)
        {
            this.var_2438 = param1;
        }

        public function dispose():void
        {
            var _loc1_:WardrobeSlot;
            this.var_2438 = null;
            for each (_loc1_ in this.var_2995)
            {
                _loc1_.dispose();
                _loc1_ = null;
            };
            this.var_2995 = null;
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            this._isInitialized = false;
        }

        public function reset():void
        {
            this._isInitialized = false;
        }

        private function init():void
        {
            var _loc2_:WardrobeSlot;
            if (this.var_2438.handler != null)
            {
                this.var_2438.handler.getWardrobe();
            };
            if (this.var_2995)
            {
                for each (_loc2_ in this.var_2995)
                {
                    _loc2_.dispose();
                    _loc2_ = null;
                };
            };
            this.var_2995 = new Map();
            var _loc1_:int = 1;
            while (_loc1_ <= 10)
            {
                this.var_2995.add(_loc1_, new WardrobeSlot(this.var_2438, _loc1_, this.isSlotEnabled(_loc1_)));
                _loc1_++;
            };
            if (this._view)
            {
                this._view.dispose();
            };
            this._view = new WardrobeView(this);
            this._isInitialized = true;
            this.updateView();
        }

        public function get controller():HabboAvatarEditor
        {
            return (this.var_2438);
        }

        public function getWindowContainer():IWindowContainer
        {
            if (!this._isInitialized)
            {
                this.init();
            };
            return (this._view.getWindowContainer());
        }

        public function updateView():void
        {
            this._view.update();
        }

        public function updateSlots(param1:int, param2:Array):void
        {
            var _loc3_:WardrobeSlot;
            var _loc4_:OutfitData;
            if (!this._isInitialized)
            {
                return;
            };
            if (!param2)
            {
                ErrorReportStorage.addDebugData("WardrobeModel", "updateSlots: outfits is null!");
            };
            if (!this.var_2995)
            {
                ErrorReportStorage.addDebugData("WardrobeModel", "updateSlots: _slots is null!");
            };
            for each (_loc4_ in param2)
            {
                _loc3_ = (this.var_2995.getValue(_loc4_.slotId) as WardrobeSlot);
                if (_loc3_)
                {
                    _loc3_.update(_loc4_.figureString, _loc4_.gender, this.isSlotEnabled(_loc3_.id));
                };
            };
        }

        private function isSlotEnabled(param1:int):Boolean
        {
            if (param1 <= 5)
            {
                return (this.var_2438.manager.sessionData.hasUserRight("fuse_use_wardrobe", HabboClubLevelEnum.var_256));
            };
            return (this.var_2438.manager.sessionData.hasUserRight("fuse_larger_wardrobe", HabboClubLevelEnum.var_114));
        }

        public function get slots():Array
        {
            return (this.var_2995.getValues());
        }


    }
}