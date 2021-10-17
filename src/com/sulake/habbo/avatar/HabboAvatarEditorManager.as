package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.avatar.enum.AvatarRenderEvent;
    import flash.events.Event;
    import com.sulake.habbo.avatar.enum.AvatarEditorEvent;

    public class HabboAvatarEditorManager extends Component implements IHabboAvatarEditor 
    {

        private var _windowManager:IHabboWindowManager;
        private var var_2860:IAvatarRenderManager;
        private var var_3071:IHabboInventory;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:IHabboConfigurationManager;
        private var _communication:IHabboCommunicationManager;
        private var _catalog:IHabboCatalog;
        private var var_3072:ISessionDataManager;
        private var var_1604:AvatarEditorMessageHandler;
        private var var_3073:Map;

        public function HabboAvatarEditorManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            this.var_3073 = new Map();
        }

        override public function dispose():void
        {
            var _loc1_:HabboAvatarEditor;
            if (this.var_3073)
            {
                for each (_loc1_ in this.var_3073)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                };
                this.var_3073 = null;
            };
            if (this._configuration != null)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._communication != null)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._catalog != null)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._localization != null)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this.var_2860 != null)
            {
                this.var_2860.release(new IIDAvatarRenderManager());
                this.var_2860 = null;
            };
            if (this._windowManager != null)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this.var_3071 != null)
            {
                this.var_3071.release(new IIDHabboInventory());
                this.var_3071 = null;
            };
            if (this.var_1604 != null)
            {
                this.var_1604.dispose();
                this.var_1604 = null;
            };
            super.dispose();
        }

        public function openEditor(param1:uint, param2:IHabboAvatarEditorDataSaver, param3:Array=null, param4:Boolean=false, param5:String=null):IFrameWindow
        {
            var _loc6_:HabboAvatarEditor = this.var_3073.getValue(param1);
            if (!_loc6_)
            {
                _loc6_ = new HabboAvatarEditor(param1, this);
                this.var_3073.add(param1, _loc6_);
            };
            return (_loc6_.openWindow(param2, param3, param4, param5));
        }

        public function embedEditorToContext(param1:uint, param2:IWindowContainer, param3:IHabboAvatarEditorDataSaver=null, param4:Array=null, param5:Boolean=false):Boolean
        {
            var _loc6_:HabboAvatarEditor = this.var_3073.getValue(param1);
            if (_loc6_)
            {
                _loc6_.dispose();
            };
            _loc6_ = new HabboAvatarEditor(param1, this);
            this.var_3073.add(param1, _loc6_);
            _loc6_.embedToContext(param2, param3, param4, param5);
            return (true);
        }

        public function loadAvatarInEditor(param1:uint, param2:String, param3:String, param4:int=0):void
        {
            var _loc5_:HabboAvatarEditor = (this.var_3073.getValue(param1) as HabboAvatarEditor);
            if (_loc5_)
            {
                return (_loc5_.loadAvatarInEditor(param2, param3, param4));
            };
        }

        public function loadOwnAvatarInEditor(param1:uint):void
        {
            var _loc2_:HabboAvatarEditor = (this.var_3073.getValue(param1) as HabboAvatarEditor);
            if (_loc2_)
            {
                return (_loc2_.loadAvatarInEditor(this.sessionData.figure, this.sessionData.gender, this.sessionData.clubLevel));
            };
        }

        public function close(param1:uint):void
        {
            var _loc2_:HabboAvatarEditor = (this.var_3073.getValue(param1) as HabboAvatarEditor);
            if (!_loc2_)
            {
                return;
            };
            switch (param1)
            {
                case AvatarEditorInstanceId.var_540:
                    _loc2_.hide();
                    return;
                case AvatarEditorInstanceId.var_541:
                    _loc2_.hide();
                    _loc2_.dispose();
                    this.var_3073.remove(param1);
                    return;
                default:
                    _loc2_.dispose();
                    this.var_3073.remove(param1);
            };
        }

        public function getEditor(param1:uint):HabboAvatarEditor
        {
            return (this.var_3073.getValue(param1) as HabboAvatarEditor);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }

        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (this.var_2860);
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._windowManager = (param2 as IHabboWindowManager);
        }

        private function onCatalogReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._catalog = (param2 as IHabboCatalog);
        }

        private function onSessionDataManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3072 = (param2 as ISessionDataManager);
        }

        private function onAvatarRenderManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_2860 = (param2 as IAvatarRenderManager);
            (this.var_2860 as Component).events.addEventListener(AvatarRenderEvent.AVATAR_RENDER_READY, this.onAvatarRendererReady);
        }

        private function onAvatarRendererReady(param1:Event=null):void
        {
            this.events.dispatchEvent(new Event(AvatarEditorEvent.AVATAR_EDITOR_READY));
        }

        private function onInventoryReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3071 = (param2 as IHabboInventory);
        }

        private function onConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._configuration = (param2 as IHabboConfigurationManager);
        }

        private function onCommunicationReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._communication = (param2 as IHabboCommunicationManager);
            this.var_1604 = new AvatarEditorMessageHandler(this, this._communication);
        }

        private function onLocalizationReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._localization = (param2 as IHabboLocalizationManager);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }

        public function get handler():AvatarEditorMessageHandler
        {
            return (this.var_1604);
        }

        public function get catalog():IHabboCatalog
        {
            return (this._catalog);
        }

        public function get sessionData():ISessionDataManager
        {
            return (this.var_3072);
        }


    }
}