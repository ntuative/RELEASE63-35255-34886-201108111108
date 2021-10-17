package com.sulake.habbo.avatar.promo
{
    import com.sulake.habbo.avatar.common.ISideContentModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.IWindowContainer;

    public class ClubPromoModel implements ISideContentModel 
    {

        private var var_2438:HabboAvatarEditor;
        private var _view:ClubPromoView;

        public function ClubPromoModel(param1:HabboAvatarEditor)
        {
            this.var_2438 = param1;
        }

        public function dispose():void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
        }

        public function reset():void
        {
        }

        private function init():void
        {
            if (!this._view)
            {
                this._view = new ClubPromoView(this);
            };
        }

        public function tryClubClothes():void
        {
            this._view.showBuyView();
            if (this.var_2438)
            {
                this.var_2438.useClubClothing();
            };
            if (this.var_2438.manager.communication)
            {
                this.var_2438.manager.communication.getHabboMainConnection(null).send(new EventLogMessageComposer("AvatarEditor", "click", "try_club_clothes"));
            };
        }

        public function get controller():HabboAvatarEditor
        {
            return (this.var_2438);
        }

        public function getWindowContainer():IWindowContainer
        {
            this.init();
            if (this._view)
            {
                return (this._view.getWindowContainer());
            };
            return (null);
        }


    }
}