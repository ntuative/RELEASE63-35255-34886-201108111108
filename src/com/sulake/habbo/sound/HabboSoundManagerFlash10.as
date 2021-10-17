package com.sulake.habbo.sound
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.trax.TraxSequencer;
    import flash.utils.ByteArray;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.habbo.sound.events.TraxSongLoadEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.IAsset;
    import flash.media.Sound;
    import com.sulake.habbo.sound.object.HabboSound;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import com.sulake.habbo.sound.trax.TraxData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.SoundSettingsEvent;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.sound.music.HabboMusicController;
    import com.sulake.habbo.communication.messages.outgoing.sound.SetSoundSettingsComposer;
    import com.sulake.habbo.communication.messages.parser.sound.SoundSettingsParser;
    import com.sulake.habbo.sound.trax.TraxSample;
    import flash.utils.getTimer;

    public class HabboSoundManagerFlash10 extends Component implements IHabboSoundManager, IUpdateReceiver 
    {

        private static const var_174:int = 60;
        private static const var_175:int = 25165823;
        private static const var_176:int = 0xFFFFFF;

        private var _configuration:IHabboConfigurationManager;
        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _roomEngine:IRoomEngine;
        private var var_3890:IHabboNotifications;
        private var var_3858:Number = 1;
        private var var_5078:Map = new Map();
        private var var_5079:Array = [];
        private var var_5080:Map = new Map();
        private var var_5081:Map = new Map();
        private var var_5082:int = -1;
        private var var_5083:TraxSequencer;
        private var var_5038:IHabboMusicController;
        private var var_5084:Map = new Map();
        private var var_5085:ByteArray = new ByteArray();
        private var var_5086:Boolean = false;

        public function HabboSoundManagerFlash10(param1:IContext, param2:uint=0, param3:IAssetLibrary=null, param4:Boolean=true)
        {
            super(param1, param2, param3);
            if (param4)
            {
                queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
                queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
                queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
                queueInterface(new IIDHabboNotifications(), this.onNotificationsReady);
            };
            events.addEventListener(TraxSongLoadEvent.var_165, this.onTraxLoadComplete);
            registerUpdateReceiver(this, 1);
            Logger.log("Sound manager 10 init");
        }

        public function get musicController():IHabboMusicController
        {
            return (this.var_5038);
        }

        public function get volume():Number
        {
            return (this.var_3858);
        }

        public function set volume(param1:Number):void
        {
            this.updateVolumeSetting(param1);
            this.storeVolumeSetting();
        }

        public function set previewVolume(param1:Number):void
        {
            this.updateVolumeSetting(param1);
        }

        override public function dispose():void
        {
            this._connection = null;
            if (this.var_5038)
            {
                this.var_5038.dispose();
                this.var_5038 = null;
            };
            if (this.var_5080)
            {
                this.var_5080.dispose();
                this.var_5080 = null;
            };
            if (this.var_5081)
            {
                this.var_5081.dispose();
                this.var_5081 = null;
            };
            if (this.var_5078)
            {
                this.var_5078.dispose();
                this.var_5078 = null;
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
            if (this._roomEngine)
            {
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this.var_3890)
            {
                this.var_3890.release(new IIDHabboNotifications());
                this.var_3890 = null;
            };
            super.dispose();
        }

        public function playSound(param1:String):void
        {
            var _loc3_:String;
            var _loc4_:IAsset;
            var _loc5_:Sound;
            var _loc2_:HabboSound = this.var_5081.getValue(param1);
            if (_loc2_ == null)
            {
                _loc3_ = "";
                switch (param1)
                {
                    case HabboSoundTypesEnum.var_166:
                        _loc3_ = "sound_call_for_help";
                        break;
                    case HabboSoundTypesEnum.var_167:
                        _loc3_ = "sound_guide_received_invitation";
                        break;
                    case HabboSoundTypesEnum.var_168:
                        _loc3_ = "sound_console_new_message";
                        break;
                    case HabboSoundTypesEnum.var_169:
                        _loc3_ = "sound_console_message_sent";
                        break;
                    case HabboSoundTypesEnum.var_141:
                        _loc3_ = "sound_catalogue_pixels";
                        break;
                    case HabboSoundTypesEnum.var_139:
                        _loc3_ = "sound_catalogue_cash";
                        break;
                    case HabboSoundTypesEnum.var_170:
                        _loc3_ = "sound_respect_received";
                        break;
                    default:
                        Logger.log(("HabboSoundManagerFlash10: Unknown sound request: " + param1));
                };
                _loc4_ = assets.getAssetByName(_loc3_);
                _loc5_ = (_loc4_.content as Sound);
                if (_loc5_ == null)
                {
                    return;
                };
                _loc2_ = new HabboSound(_loc5_);
                this.var_5081.add(param1, _loc2_);
            };
            _loc2_.volume = this.var_3858;
            _loc2_.play();
        }

        private function loadSample(param1:int):void
        {
            if (this._configuration == null)
            {
                return;
            };
            var _loc2_:String = this._configuration.getKey("flash.dynamic.download.url", "furniture/");
            _loc2_ = (_loc2_ + this._configuration.getKey("flash.dynamic.download.samples.template", "mp3/sound_machine_sample_%typeid%.mp3"));
            _loc2_ = _loc2_.replace(/%typeid%/, param1.toString());
            var _loc3_:URLRequest = new URLRequest(_loc2_);
            var _loc4_:Sound = new Sound();
            _loc4_.addEventListener(Event.COMPLETE, this.onSampleLoadComplete);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            _loc4_.load(_loc3_);
            this.var_5078.add(_loc4_, param1);
        }

        public function loadTraxSong(param1:int, param2:String):IHabboSound
        {
            if (this.var_5083 != null)
            {
                return (this.addTraxSongForDownload(param1, param2));
            };
            var _loc3_:TraxSequencer = this.createTraxInstance(param1, param2);
            if (!_loc3_.ready)
            {
                this.var_5083 = _loc3_;
                this.var_5082 = param1;
            };
            return (_loc3_ as IHabboSound);
        }

        private function addTraxSongForDownload(param1:int, param2:String):IHabboSound
        {
            var _loc3_:TraxSequencer = this.createTraxInstance(param1, param2, false);
            if (!_loc3_.ready)
            {
                this.var_5084.add(param1, _loc3_);
            };
            return (_loc3_);
        }

        private function createTraxInstance(param1:int, param2:String, param3:Boolean=true):TraxSequencer
        {
            var _loc4_:TraxData = new TraxData(param2);
            var _loc5_:TraxSequencer = new TraxSequencer(param1, _loc4_, this.var_5080, events);
            _loc5_.volume = this.var_3858;
            this.validateSampleAvailability(_loc5_, param3);
            return (_loc5_);
        }

        private function validateSampleAvailability(param1:TraxSequencer, param2:Boolean):void
        {
            var _loc3_:TraxData = param1.traxData;
            var _loc4_:Array = _loc3_.getSampleIds();
            var _loc5_:Boolean;
            var _loc6_:int;
            while (_loc6_ < _loc4_.length)
            {
                if (this.var_5080.getValue(int(_loc4_[_loc6_])) == null)
                {
                    if (param2)
                    {
                        this.loadSample(int(_loc4_[_loc6_]));
                    };
                    _loc5_ = true;
                };
                _loc6_++;
            };
            if (_loc5_)
            {
                param1.ready = false;
            }
            else
            {
                param1.ready = true;
            };
        }

        public function notifyPlayedSong(param1:String, param2:String):void
        {
            if (this.var_3890 == null)
            {
                return;
            };
            this.var_3890.addSongPlayingNotification(param1, param2);
        }

        private function onHabboConfigurationInit(param1:IID=null, param2:IUnknown=null):void
        {
            if (param2 != null)
            {
                this._configuration = (param2 as IHabboConfigurationManager);
                if (this._configuration.getBoolean("trax.player.sample.memory.purge.enabled", false))
                {
                    this.var_5086 = true;
                };
            };
        }

        protected function setHabboConfiguration(param1:IHabboConfigurationManager):void
        {
            this._configuration = param1;
        }

        private function onCommunicationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (param2 != null)
            {
                this._communication = IHabboCommunicationManager(param2);
                this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
            };
        }

        private function onAuthenticationOK(param1:IMessageEvent):void
        {
            var _loc2_:IConnection = this._communication.getHabboMainConnection(this.onConnectionReady);
            if (_loc2_ != null)
            {
                _loc2_.addMessageEvent(new SoundSettingsEvent(this.onSoundSettingsEvent));
                _loc2_.send(new GetSoundSettingsComposer());
                this.onConnectionReady(_loc2_);
                this.initMusicController();
            };
        }

        private function onRoomEngineReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (param2 == null)
            {
                return;
            };
            this._roomEngine = IRoomEngine(param2);
            this.initMusicController();
        }

        private function onNotificationsReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (param2 == null)
            {
                return;
            };
            this.var_3890 = IHabboNotifications(param2);
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
            };
            this.initMusicController();
        }

        private function initMusicController():void
        {
            if (((((this._configuration == null) || (this._connection == null)) || (this._roomEngine == null)) || (!(this.var_5038 == null))))
            {
                return;
            };
            this.var_5038 = new HabboMusicController(this, events, this._roomEngine.events, this._connection);
        }

        protected function setMusicController(param1:IHabboMusicController):void
        {
            this.var_5038 = param1;
        }

        private function onSampleLoadComplete(param1:Event):void
        {
            var _loc2_:Sound = (param1.target as Sound);
            this.var_5079.push(_loc2_);
        }

        private function onTraxLoadComplete(param1:Event):void
        {
            var _loc2_:TraxSongLoadEvent = (param1 as TraxSongLoadEvent);
            if (_loc2_ == null)
            {
                return;
            };
            if (this.var_5038 == null)
            {
                return;
            };
            this.var_5038.onSongLoaded(_loc2_.id);
        }

        private function ioErrorHandler(param1:Event):void
        {
            events.dispatchEvent(new TraxSongLoadEvent(TraxSongLoadEvent.var_171, this.var_5082));
            this.var_5082 = -1;
            this.var_5083 = null;
        }

        private function storeVolumeSetting():void
        {
            if (this._connection != null)
            {
                this._connection.send(new SetSoundSettingsComposer(int((this.var_3858 * 100))));
            };
        }

        private function updateVolumeSetting(param1:Number):void
        {
            this.var_3858 = param1;
            this.var_5038.updateVolume(this.var_3858);
        }

        private function onSoundSettingsEvent(param1:IMessageEvent):void
        {
            var _loc2_:SoundSettingsEvent = (param1 as SoundSettingsEvent);
            var _loc3_:SoundSettingsParser = (_loc2_.getParser() as SoundSettingsParser);
            if (((_loc3_.volume == 1) || (_loc3_.volume == 0)))
            {
                this.updateVolumeSetting((_loc3_.volume * 1));
            }
            else
            {
                this.updateVolumeSetting((_loc3_.volume / 100));
            };
        }

        private function processLoadedSample(param1:Sound):void
        {
            var _loc2_:int;
            var _loc3_:Number;
            var _loc4_:TraxSample;
            if (this.var_5078.getValue(param1) != null)
            {
                _loc2_ = this.var_5078.remove(param1);
                if (this.var_5080.getValue(_loc2_) == null)
                {
                    this.var_5085.clear();
                    _loc3_ = param1.length;
                    param1.extract(this.var_5085, int((_loc3_ * 44.1)));
                    _loc4_ = new TraxSample(this.var_5085, _loc2_, TraxSample.var_172, TraxSample.var_173);
                    this.var_5080.add(_loc2_, _loc4_);
                };
            };
        }

        private function processLoadedSamples():void
        {
            var _loc1_:int;
            var _loc2_:int;
            var _loc3_:Sound;
            var _loc4_:int;
            if (this.var_5079.length > 0)
            {
                _loc1_ = getTimer();
                _loc2_ = _loc1_;
                while ((((_loc2_ - _loc1_) < var_174) && (this.var_5079.length > 0)))
                {
                    _loc3_ = this.var_5079.splice(0, 1)[0];
                    this.processLoadedSample(_loc3_);
                    _loc2_ = getTimer();
                };
                if (((this.var_5078.length == 0) && (!(this.var_5082 == -1))))
                {
                    this.var_5083.ready = true;
                    _loc4_ = this.var_5082;
                    this.var_5082 = -1;
                    this.var_5083 = null;
                    events.dispatchEvent(new TraxSongLoadEvent(TraxSongLoadEvent.var_165, _loc4_));
                    if (this.var_5086)
                    {
                        this.processSampleMemoryUsage();
                    };
                };
            };
        }

        private function loadNextSong():void
        {
            var _loc1_:int;
            var _loc2_:TraxSequencer;
            if (((this.var_5083 == null) && (this.var_5084.length > 0)))
            {
                _loc1_ = this.var_5084.getKey(0);
                _loc2_ = this.var_5084.remove(_loc1_);
                if (((!(_loc2_ == null)) && (!(_loc2_.disposed))))
                {
                    this.validateSampleAvailability(_loc2_, true);
                    if (_loc2_.ready)
                    {
                        events.dispatchEvent(new TraxSongLoadEvent(TraxSongLoadEvent.var_165, _loc1_));
                    }
                    else
                    {
                        this.var_5083 = _loc2_;
                        this.var_5082 = _loc1_;
                    };
                };
            };
        }

        public function update(param1:uint):void
        {
            this.processLoadedSamples();
            this.loadNextSong();
        }

        private function logSampleUsage():void
        {
        }

        private function processSampleMemoryUsage():void
        {
            var _loc5_:int;
            var _loc6_:TraxSample;
            var _loc7_:Array;
            var _loc8_:uint;
            var _loc9_:int;
            var _loc10_:TraxSample;
            var _loc11_:int;
            var _loc12_:TraxSample;
            var _loc1_:uint;
            var _loc2_:Array = [];
            var _loc3_:Array = this.var_5038.samplesIdsInUse;
            var _loc4_:int;
            while (_loc4_ < this.var_5080.length)
            {
                _loc5_ = this.var_5080.getKey(_loc4_);
                _loc6_ = this.var_5080.getWithIndex(_loc4_);
                if (((!(_loc6_.usageCount == 0)) && (_loc3_.indexOf(_loc5_) == -1)))
                {
                    _loc2_.push(_loc6_);
                };
                _loc1_ = (_loc1_ + _loc6_.length);
                _loc4_++;
            };
            if (_loc1_ > var_175)
            {
                _loc7_ = [];
                Logger.log("Sample memory limit reached, clearing the oldest and least frequently used samples");
                _loc2_.sort(this.orderUsageAndTimeStamp);
                _loc8_ = 0;
                _loc9_ = 0;
                while (((_loc8_ < (_loc1_ - var_176)) && (_loc9_ < _loc2_.length)))
                {
                    _loc10_ = _loc2_[_loc9_++];
                    _loc8_ = (_loc8_ + _loc10_.length);
                    _loc7_.push(_loc10_.id);
                };
                _loc2_ = null;
                if (_loc7_.length > 0)
                {
                    for each (_loc11_ in _loc7_)
                    {
                        Logger.log(("Purging sample : " + _loc11_));
                        _loc12_ = (this.var_5080.getValue(_loc11_) as TraxSample);
                        _loc12_.dispose();
                        this.var_5080.remove(_loc11_);
                    };
                    this.var_5038.samplesUnloaded(_loc7_);
                };
            };
        }

        private function orderUsageAndTimeStamp(param1:TraxSample, param2:TraxSample):int
        {
            if (param1.usageCount < param2.usageCount)
            {
                return (-1);
            };
            if (param1.usageCount > param2.usageCount)
            {
                return (1);
            };
            if (param1.usageTimeStamp < param2.usageTimeStamp)
            {
                return (-1);
            };
            if (param1.usageTimeStamp > param2.usageTimeStamp)
            {
                return (1);
            };
            return (0);
        }


    }
}