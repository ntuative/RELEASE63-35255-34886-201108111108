package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;

    public class ModerationManager extends Component implements IHabboModeration 
    {

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var var_1354:ISessionDataManager;
        private var _configuration:IHabboConfigurationManager;
        private var _navigator:IHabboNavigator;
        private var _soundManager:IHabboSoundManager;
        private var var_4197:ModerationMessageHandler;
        private var _issueManager:IssueManager;
        private var var_4198:StartPanelCtrl;
        private var var_4199:WindowTracker;
        private var var_4200:ModeratorInitData;
        private var var_4201:int;

        public function ModerationManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            this.var_4198 = new StartPanelCtrl(this);
            this.var_4199 = new WindowTracker();
        }

        override public function dispose():void
        {
            if (this.var_4198)
            {
                this.var_4198.dispose();
                this.var_4198 = null;
            };
            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._communication)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this.var_1354)
            {
                this.var_1354.release(new IIDSessionDataManager());
                this.var_1354 = null;
            };
            if (this._configuration)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._navigator)
            {
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            };
            if (this._soundManager)
            {
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            this._connection = null;
            super.dispose();
        }

        public function userSelected(param1:int, param2:String):void
        {
            Logger.log(((("USER SELECTED: " + param1) + ", ") + param2));
            this.var_4198.userSelected(param1, param2);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (this.var_1354);
        }

        public function get issueManager():IssueManager
        {
            return (this._issueManager);
        }

        public function get connection():IConnection
        {
            return (this._connection);
        }

        public function get startPanel():StartPanelCtrl
        {
            return (this.var_4198);
        }

        public function get initMsg():ModeratorInitData
        {
            return (this.var_4200);
        }

        public function get messageHandler():ModerationMessageHandler
        {
            return (this.var_4197);
        }

        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }

        public function get windowTracker():WindowTracker
        {
            return (this.var_4199);
        }

        public function get currentFlatId():int
        {
            return (this.var_4201);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (this._soundManager);
        }

        public function set initMsg(param1:ModeratorInitData):void
        {
            this.var_4200 = param1;
        }

        public function set currentFlatId(param1:int):void
        {
            this.var_4201 = param1;
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._windowManager = (param2 as IHabboWindowManager);
            this._issueManager = new IssueManager(this);
        }

        private function onCommunicationReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._communication = (param2 as IHabboCommunicationManager);
            if (this._communication != null)
            {
                this._connection = this._communication.getHabboMainConnection(this.onConnectionReady);
                if (this._connection != null)
                {
                    this.onConnectionReady(this._connection);
                };
            };
        }

        private function onConnectionReady(param1:IConnection):void
        {
            if (disposed)
            {
                return;
            };
            if (param1 != null)
            {
                this._connection = param1;
                this.var_4197 = new ModerationMessageHandler(this);
            };
        }

        private function onSessionDataReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_1354 = (param2 as ISessionDataManager);
        }

        private function onConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._configuration = (param2 as IHabboConfigurationManager);
        }

        private function onNavigatorReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._navigator = IHabboNavigator(param2);
        }

        private function onSoundManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._soundManager = (param2 as IHabboSoundManager);
        }

        public function getXmlWindow(param1:String):IWindow
        {
            var _loc2_:IAsset = assets.getAssetByName((param1 + "_xml"));
            var _loc3_:XmlAsset = XmlAsset(_loc2_);
            return (this._windowManager.buildFromXML(XML(_loc3_.content)));
        }

        public function openHkPage(param1:String, param2:String):void
        {
            var _loc3_:String = this.configuration.getKey(param1);
            var _loc4_:String = (_loc3_ + param2);
            var _loc5_:String = "housekeeping";
            HabboWebTools.navigateToURL(_loc4_, _loc5_);
        }

        public function disableButton(param1:Boolean, param2:IWindowContainer, param3:String):void
        {
            var _loc4_:IButtonWindow = IButtonWindow(param2.findChildByName(param3));
            if (!param1)
            {
                _loc4_.disable();
                _loc4_.toolTipCaption = "No permission";
            };
        }

        public function goToRoom(param1:int):void
        {
            Logger.log(("MOD: GO TO ROOM: " + param1));
            this._navigator.goToRoom(param1, false);
        }


    }
}