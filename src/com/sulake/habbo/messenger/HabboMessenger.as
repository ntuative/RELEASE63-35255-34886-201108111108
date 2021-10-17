package com.sulake.habbo.messenger
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.messenger.domain.Conversations;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.messenger.domain.ConversationsDeps;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.habbo.friendlist.IFriend;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.sound.HabboSoundTypesEnum;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.utils.Dictionary;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorMessageParser;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.*;
    import com.sulake.habbo.messenger.domain.*;

    public class HabboMessenger extends Component implements IHabboMessenger, IAvatarImageListener 
    {

        public static const var_274:String = "face";

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var _friendList:IHabboFriendList;
        private var var_1327:IAvatarRenderManager;
        private var var_4146:Conversations;
        private var var_4147:MessengerView;
        private var _soundManager:IHabboSoundManager;

        public function HabboMessenger(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            lock();
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderedReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
        }

        override public function dispose():void
        {
            if (this._soundManager)
            {
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
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
            if (this._configuration)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._localization)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._friendList)
            {
                this._friendList.release(new IIDHabboFriendList());
                this._friendList = null;
            };
            if (this.var_1327)
            {
                this.var_1327.release(new IIDAvatarRenderManager());
                this.var_1327 = null;
            };
            if (this.var_4147)
            {
                this.var_4147.dispose();
                this.var_4147 = null;
            };
            super.dispose();
        }

        private function onSoundManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._soundManager = (param2 as IHabboSoundManager);
            this.tryInit();
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._windowManager = (param2 as IHabboWindowManager);
            this.tryInit();
        }

        private function onCommunicationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._communication = (param2 as IHabboCommunicationManager);
            this.tryInit();
        }

        private function onAvatarRenderedReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_1327 = (param2 as IAvatarRenderManager);
            this.tryInit();
        }

        private function onConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._configuration = (param2 as IHabboConfigurationManager);
            this.tryInit();
        }

        private function onLocalizationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._localization = (param2 as IHabboLocalizationManager);
            this.tryInit();
        }

        private function onFriendListReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._friendList = (param2 as IHabboFriendList);
            this.tryInit();
        }

        private function tryInit():void
        {
            if ((((((((this._windowManager) && (this._communication)) && (this._configuration)) && (this._localization)) && (this._friendList)) && (this.var_1327)) && (this._soundManager)))
            {
                unlock();
                this._communication.addHabboConnectionMessageEvent(new MessengerInitEvent(this.onMessengerInit));
            };
        }

        private function onMessengerInit(param1:IMessageEvent):void
        {
            this.var_4146 = new Conversations(new ConversationsDeps(this));
            this.var_4147 = new MessengerView(this);
            this._communication.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(this.onNewConsoleMessage));
            this._communication.addHabboConnectionMessageEvent(new RoomInviteEvent(this.onRoomInvite));
            this._communication.addHabboConnectionMessageEvent(new InstantMessageErrorEvent(this.onInstantMessageError));
        }

        public function startConversation(param1:int):void
        {
            var _loc2_:Conversation = this.var_4146.addConversation(param1);
            if (_loc2_ == null)
            {
                Logger.log((("No friend " + param1) + " found. Shouldn't happen"));
            }
            else
            {
                this.var_4146.setSelected(_loc2_);
                this.var_4147.openMessenger();
                this.var_4147.refresh();
            };
        }

        public function getActiveConversation():IConversation
        {
            return ((this.var_4146) ? this.var_4146.findSelectedConversation() : null);
        }

        public function setFollowingAllowed(param1:int, param2:Boolean):void
        {
            this.var_4146.setFollowingAllowedAndUpdateView(param1, param2);
        }

        public function setOnlineStatus(param1:int, param2:Boolean):void
        {
            this.var_4146.setOnlineStatusAndUpdateView(param1, param2);
        }

        public function createConversation(param1:int):Conversation
        {
            var _loc2_:IFriend = this._friendList.getFriend(param1);
            if (_loc2_ == null)
            {
                Logger.log(("No friend found with: " + param1));
                return (null);
            };
            Logger.log(((((((("A FRIEND FOUND: " + _loc2_.id) + ", ") + _loc2_.name) + ", ") + _loc2_.gender) + ", ") + _loc2_.figure));
            return (new Conversation(_loc2_.id, _loc2_.name, _loc2_.figure, _loc2_.followingAllowed));
        }

        public function getAvatarFaceBitmap(param1:String):BitmapData
        {
            var _loc3_:BitmapData;
            var _loc2_:IAvatarImage = this.var_1327.createAvatarImage(param1, AvatarScaleType.var_275, null, this);
            if (_loc2_)
            {
                _loc3_ = _loc2_.getImage(AvatarSetType.var_130, true);
                _loc2_.dispose();
                return (_loc3_);
            };
            return (null);
        }

        public function send(param1:IMessageComposer):void
        {
            this._communication.getHabboMainConnection(null).send(param1);
        }

        public function playSendSound():void
        {
            if (this._soundManager != null)
            {
                this._soundManager.playSound(HabboSoundTypesEnum.var_169);
            };
        }

        public function isOpen():Boolean
        {
            return ((this.var_4147) && (this.var_4147.isMessengerOpen()));
        }

        public function toggleMessenger():void
        {
            if (this.var_4147)
            {
                if (this.var_4147.isMessengerOpen())
                {
                    this.var_4147.close();
                }
                else
                {
                    this.var_4147.openMessenger();
                };
            };
        }

        public function openHabboWebPage(linkAlias:String, params:Dictionary, event:WindowEvent):void
        {
            params["predefined"] = this.getPageParam("url.prefix");
            var url:String = this.getVariable(linkAlias, params);
            var webWindowName:String = "habboMain";
            try
            {
                HabboWebTools.navigateToURL(url, webWindowName);
            }
            catch(e:Error)
            {
                Logger.log(("GOT ERROR: " + e));
            };
            var wme:WindowMouseEvent = (event as WindowMouseEvent);
        }

        public function getText(param1:String):String
        {
            return (this._localization.getKey(param1, param1));
        }

        private function getPageParam(param1:String):String
        {
            var _loc2_:String;
            if (param1 == "url.prefix")
            {
                _loc2_ = "d31.web.varoke.net";
                _loc2_ = this._configuration.getKey("url.prefix", _loc2_);
                _loc2_ = _loc2_.replace("http://", "");
                return (_loc2_.replace("https://", ""));
            };
            return (null);
        }

        private function getVariable(param1:String, param2:Dictionary):String
        {
            return (this._configuration.getKey(param1, param1, param2));
        }

        private function onNewConsoleMessage(param1:IMessageEvent):void
        {
            var _loc2_:NewConsoleMessageMessageParser = (param1 as NewConsoleMessageEvent).getParser();
            Logger.log(((("Received console msg: " + _loc2_.messageText) + ", ") + _loc2_.senderId));
            var _loc3_:Message = new Message(Message.var_276, _loc2_.senderId, _loc2_.messageText, Util.getFormattedNow());
            this.addMsg(_loc3_);
        }

        private function onRoomInvite(param1:IMessageEvent):void
        {
            var _loc2_:RoomInviteMessageParser = (param1 as RoomInviteEvent).getParser();
            var _loc3_:Message = new Message(Message.var_277, _loc2_.senderId, ((this.getText("messenger.invitation") + " ") + _loc2_.messageText), Util.getFormattedNow());
            this.addMsg(_loc3_);
        }

        private function addMsg(param1:Message):void
        {
            this.var_4146.addMessageAndUpdateView(param1);
            if (!this.var_4147.isMessengerOpen())
            {
                if (this._soundManager != null)
                {
                    this._soundManager.playSound(HabboSoundTypesEnum.var_168);
                };
            };
        }

        private function onInstantMessageError(param1:IMessageEvent):void
        {
            var _loc2_:InstantMessageErrorMessageParser = (param1 as InstantMessageErrorEvent).getParser();
            var _loc3_:Message = new Message(Message.var_278, _loc2_.userId, this.getInstantMessageErrorText(_loc2_.errorCode), Util.getFormattedNow());
            this.var_4146.addMessageAndUpdateView(_loc3_);
        }

        private function getInstantMessageErrorText(param1:int):String
        {
            if (param1 == 3)
            {
                return (this.getText("messenger.error.receivermuted"));
            };
            if (param1 == 4)
            {
                return (this.getText("messenger.error.sendermuted"));
            };
            if (param1 == 5)
            {
                return (this.getText("messenger.error.offline"));
            };
            if (param1 == 6)
            {
                return (this.getText("messenger.error.notfriend"));
            };
            if (param1 == 7)
            {
                return (this.getText("messenger.error.busy"));
            };
            return ("Unknown im error " + param1);
        }

        public function refreshButton(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function, param5:int):void
        {
            var _loc6_:IBitmapWrapperWindow = (param1.findChildByName(param2) as IBitmapWrapperWindow);
            this.refreshButtonDir(_loc6_, param2, param3, param4, param5);
        }

        public function refreshButtonDir(param1:IBitmapWrapperWindow, param2:String, param3:Boolean, param4:Function, param5:int):void
        {
            if (!param3)
            {
                param1.visible = false;
            }
            else
            {
                this.prepareButton(param1, param2, param4, param5);
                param1.visible = true;
            };
        }

        private function prepareButton(param1:IBitmapWrapperWindow, param2:String, param3:Function, param4:int):void
        {
            param1.id = param4;
            if (param1.bitmap != null)
            {
                return;
            };
            param1.bitmap = this.getButtonImage(param2);
            param1.width = param1.bitmap.width;
            param1.height = param1.bitmap.height;
            param1.procedure = param3;
        }

        public function getButtonImage(param1:String):BitmapData
        {
            var _loc5_:BitmapData;
            var _loc2_:IAsset = assets.getAssetByName((param1 + "_png"));
            var _loc3_:BitmapDataAsset = (_loc2_ as BitmapDataAsset);
            Logger.log(("GETTING ASSET: " + param1));
            var _loc4_:BitmapData = (_loc3_.content as BitmapData);
            Logger.log(((("GOT ASSET: " + _loc2_) + ", ") + _loc4_));
            _loc5_ = new BitmapData(_loc4_.width, _loc4_.height, true, 0);
            _loc5_.draw(_loc4_);
            return (_loc5_);
        }

        public function getXmlWindow(param1:String):IWindow
        {
            var _loc2_:IAsset = assets.getAssetByName((param1 + "_xml"));
            var _loc3_:XmlAsset = XmlAsset(_loc2_);
            return (this._windowManager.buildFromXML(XML(_loc3_.content)));
        }

        public function isEmbeddedMinimailEnabled():Boolean
        {
            var _loc1_:String = this._configuration.getKey("client.minimail.embed.enabled");
            return (_loc1_ == "true");
        }

        public function avatarImageReady(param1:String):void
        {
            if (this.var_4147)
            {
                this.var_4147.refresh();
            };
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get conversations():Conversations
        {
            return (this.var_4146);
        }

        public function get messengerView():MessengerView
        {
            return (this.var_4147);
        }


    }
}