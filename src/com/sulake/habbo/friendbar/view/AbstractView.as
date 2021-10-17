package com.sulake.habbo.friendbar.view
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;

    public class AbstractView extends Component 
    {

        protected var _windowManager:IHabboWindowManager;
        protected var var_1327:IAvatarRenderManager;
        protected var var_1312:IHabboLocalizationManager;
        protected var var_1322:IHabboConfigurationManager;
        protected var var_1354:ISessionDataManager;

        public function AbstractView(param1:HabboFriendBar, param2:uint, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
            queueInterface(new IIDSessionDataManager(), this.onSessionManagerAvailable);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRendererAvailable);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerAvailable);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationAvailable);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationAvailable);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this._windowManager)
                {
                    if (!this._windowManager.disposed)
                    {
                        this._windowManager.release(new IIDHabboWindowManager());
                        this._windowManager = null;
                    };
                };
                if (this.var_1327)
                {
                    if (!this.var_1327.disposed)
                    {
                        this.var_1327.release(new IIDAvatarRenderManager());
                        this.var_1327 = null;
                    };
                };
                if (this.var_1312)
                {
                    if (!this.var_1312.disposed)
                    {
                        this.var_1312.release(new IIDHabboLocalizationManager());
                        this.var_1312 = null;
                    };
                };
                if (this.var_1322)
                {
                    if (!this.var_1322.disposed)
                    {
                        this.var_1322.release(new IIDHabboConfigurationManager());
                        this.var_1322 = null;
                    };
                };
                if (this.var_1354)
                {
                    if (!this.var_1354.disposed)
                    {
                        this.var_1354.release(new IIDSessionDataManager());
                        this.var_1354 = null;
                    };
                };
                super.dispose();
            };
        }

        protected function onAvatarRendererAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_1327 = (param2 as IAvatarRenderManager);
        }

        protected function onWindowManagerAvailable(param1:IID, param2:IUnknown):void
        {
            this._windowManager = (param2 as IHabboWindowManager);
        }

        protected function onLocalizationAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_1312 = (param2 as IHabboLocalizationManager);
        }

        protected function onConfigurationAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_1322 = (param2 as IHabboConfigurationManager);
        }

        protected function onSessionManagerAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_1354 = (param2 as ISessionDataManager);
        }


    }
}