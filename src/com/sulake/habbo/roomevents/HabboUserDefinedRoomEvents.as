package com.sulake.habbo.roomevents
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngineServices;
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.habbo.communication.enum.HabboProtocolOption;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.events.RoomSessionEvent;

    public class HabboUserDefinedRoomEvents extends Component implements IHabboUserDefinedRoomEvents 
    {

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:IHabboConfigurationManager;
        private var var_4967:UserDefinedRoomEventsCtrl;
        private var var_4033:IncomingMessages;
        private var _roomEngine:IRoomEngine;
        private var var_3319:IRoomSession;
        private var var_3318:IRoomSessionManager;
        private var var_1354:ISessionDataManager;
        private var _userName:String;

        public function HabboUserDefinedRoomEvents(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            Logger.log(("UDE initialized: " + param3));
            this.var_4967 = new UserDefinedRoomEventsCtrl(this);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationComponentInit);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }

        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }

        override public function dispose():void
        {
            if (this._communication)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            super.dispose();
        }

        public function stuffSelected(param1:int, param2:String):void
        {
            var _loc3_:ISelectedRoomObjectData = (this._roomEngine as IRoomEngineServices).getPlacedObjectData(this.roomId, this.roomCategory);
            if (((_loc3_) && (_loc3_.id == -(param1))))
            {
                (this._roomEngine as IRoomEngineServices).setPlacedObjectData(this.roomId, this.roomCategory, null);
                return;
            };
            this.var_4967.stuffSelected(param1, param2);
        }

        public function send(param1:IMessageComposer, param2:Boolean=false):void
        {
            this._communication.getHabboMainConnection(null).send(param1, ((param2) ? HabboProtocolOption.OLD_STYLE : -1));
        }

        public function getXmlWindow(name:String):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try
            {
                asset = assets.getAssetByName((name + "_xml"));
                xmlAsset = XmlAsset(asset);
                window = this._windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error)
            {
            };
            return (window);
        }

        public function refreshButton(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function, param5:int, param6:String=null):void
        {
            if (!param6)
            {
                param6 = param2;
            };
            var _loc7_:IBitmapWrapperWindow = (param1.findChildByName(param2) as IBitmapWrapperWindow);
            if (!param3)
            {
                _loc7_.visible = false;
            }
            else
            {
                this.prepareButton(_loc7_, param6, param4, param5);
                _loc7_.visible = true;
            };
        }

        private function prepareButton(param1:IBitmapWrapperWindow, param2:String, param3:Function, param4:int):void
        {
            param1.id = param4;
            param1.procedure = param3;
            if (param1.bitmap != null)
            {
                return;
            };
            param1.bitmap = this.getButtonImage(param2);
            param1.width = param1.bitmap.width;
            param1.height = param1.bitmap.height;
        }

        public function getButtonImage(param1:String, param2:String="_png"):BitmapData
        {
            var _loc3_:String = (param1 + param2);
            var _loc4_:IAsset = assets.getAssetByName(_loc3_);
            var _loc5_:BitmapDataAsset = BitmapDataAsset(_loc4_);
            var _loc6_:BitmapData = BitmapData(_loc5_.content);
            return (_loc6_.clone());
        }

        private function onCommunicationComponentInit(param1:IID=null, param2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(param2);
            this.var_4033 = new IncomingMessages(this);
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(param2);
        }

        private function onLocalizationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._localization = IHabboLocalizationManager(param2);
        }

        public function get userDefinedRoomEventsCtrl():UserDefinedRoomEventsCtrl
        {
            return (this.var_4967);
        }

        private function onRoomEngineReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._roomEngine = IRoomEngine(param2);
        }

        public function get roomEngine():IRoomEngine
        {
            return (this._roomEngine);
        }

        private function onConfigurationReady(param1:IID, param2:IUnknown):void
        {
            if (param2 == null)
            {
                return;
            };
            this._configuration = (param2 as IHabboConfigurationManager);
        }

        private function onRoomSessionManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3318 = (param2 as IRoomSessionManager);
            this.registerSessionEvents();
        }

        private function onSessionDataManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_1354 = (param2 as ISessionDataManager);
        }

        private function registerSessionEvents():void
        {
            if (this.var_3318)
            {
                this.var_3318.events.addEventListener(RoomSessionEvent.var_93, this.roomSessionStateEventHandler);
                this.var_3318.events.addEventListener(RoomSessionEvent.var_94, this.roomSessionStateEventHandler);
                this.var_3318.events.addEventListener(RoomSessionEvent.var_98, this.roomSessionStateEventHandler);
            };
        }

        private function roomSessionStateEventHandler(param1:RoomSessionEvent):void
        {
            if (this._roomEngine == null)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionEvent.var_93:
                case RoomSessionEvent.var_94:
                case RoomSessionEvent.var_98:
                    this.var_3319 = param1.session;
                    return;
            };
        }

        public function get roomId():int
        {
            return ((this.var_3319) ? this.var_3319.roomId : 0);
        }

        public function get roomCategory():int
        {
            return ((this.var_3319) ? this.var_3319.roomCategory : 0);
        }

        public function get userName():String
        {
            return (this._userName);
        }

        public function set userName(param1:String):void
        {
            this._userName = param1;
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (this.var_1354);
        }


    }
}