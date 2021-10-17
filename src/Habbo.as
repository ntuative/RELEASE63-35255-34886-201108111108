package
{
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.system.Capabilities;
    import flash.system.System;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import flash.display.StageScaleMode;
    import flash.display.StageQuality;
    import flash.display.StageAlign;
    import flash.events.ProgressEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.utils.getDefinitionByName;
    import flash.display.Bitmap;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.display.Stage;

    public class Habbo extends MovieClip
    {

        protected static var PROCESSLOG_ENABLED:Boolean = false;
        private static var _crashed:Boolean = false;
        private static var _crashURL:String = "";
        public static const var_1:String = "client.init.start";
        public static const var_2:String = "client.init.swf.error";
        public static const var_3:String = "client.init.swf.loaded";
        private static const var_4:String = "client.starting";
        public static const var_5:String = "client.init.core.init";
        public static const var_6:String = "client.init.core.fail";
        public static const var_7:String = "crash_time";
        public static const var_8:String = "error_ctx";
        public static const var_9:String = "flash_version";
        public static const var_10:String = "avg_update";
        public static const var_11:String = "debug";
        public static const var_12:String = "error_desc";
        public static const var_13:String = "error_cat";
        public static const ERROR_VARIABLE_DATA:String = "error_data";
        public static const var_14:int = 9;
        public static const var_15:int = 11;
        public static const var_16:String = "fileLoadingBar";
        public static const var_17:String = "fileBarSprite";
        public static const var_18:String = "byteLoadingBar";
        public static const var_19:String = "byteBarSprite";
        public static const var_20:String = "background";
        public static const var_21:String = "habboLogo";
        public static const var_22:String = "textField";

        private var _disposed:Boolean = false;
        private var var_23:Boolean = false;
        private var var_24:DisplayObjectContainer;
        private var var_25:int = 0;
        private var var_26:String;
        private var var_27:TextField;
        private var var_28:Timer;
        private var var_30:Array;
        private var var_31:int = 0;

        private var habboLogoClass:Class = Habbo_habboLogoClass;
        private const var_29:Array = [[".", "..", "...", ""], [" [*    ]", " [ *   ]", " [  *  ]", " [   * ]", " [    *]", " [   * ]", " [  *  ]", " [ *   ]"], [".", "..", "....", "...", "..", ".", ""]];

        public function Habbo()
        {
            stop();
            if (stage)
            {
                this.onAddedToStage(null);
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            };
        }

        public static function trackLoginStep(param1:String):void
        {
            if (Habbo.PROCESSLOG_ENABLED)
            {
                Logger.log(("* HabboMain Login Step: " + param1));
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.logLoginStep", param1);
                }
                else
                {
                    Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
                };
            };
        }

        public static function reportCrash(param1:String, param2:int, param3:Error):void
        {
            var _loc4_:String;
            var _loc5_:URLRequest;
            var _loc6_:URLVariables;
            var _loc7_:String;
            if (!Habbo._crashed)
            {
                Habbo._crashed = true;
                _loc4_ = Habbo._crashURL;
                _loc5_ = new URLRequest(_loc4_);
                _loc6_ = new URLVariables();
                _loc6_[var_7] = new Date().getTime().toString();
                _loc7_ = "";
                _loc6_[var_8] = _loc7_;
                _loc6_[var_9] = Capabilities.version;
                _loc6_[var_10] = 0;
                _loc6_[var_12] = param1;
                _loc6_[var_13] = String(param2);
                if (param3 != null)
                {
                    _loc6_[ERROR_VARIABLE_DATA] = String(param3.getStackTrace());
                };
                _loc6_[var_11] = (("Memory usage: " + Math.round((System.totalMemory / (0x0400 * 0x0400)))) + " MB");
                _loc5_.data = _loc6_;
                _loc5_.method = URLRequestMethod.POST;
                navigateToURL(_loc5_, "_self");
            };
        }


        private function onAddedToStage(param1:Event):void
        {
            var _loc3_:String;
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            Habbo.PROCESSLOG_ENABLED = (stage.loaderInfo.parameters["processlog.enabled"] == "1");
            trackLoginStep(var_1);
            var _loc2_:String = stage.loaderInfo.parameters["client.fatal.error.url"];
            if (_loc2_ != null)
            {
                Habbo._crashURL = _loc2_;
            }
            else
            {
                _loc3_ = stage.loaderInfo.parameters["url.prefix"];
                if (_loc3_ != null)
                {
                    Habbo._crashURL = (_loc3_ + "/flash_client_error");
                };
            };
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.quality = StageQuality.LOW;
            stage.align = StageAlign.TOP_LEFT;
            stage.addEventListener(Event.RESIZE, this.onResize);
            root.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onPreLoadingProgress);
            root.loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onPreLoadingStatus);
            root.loaderInfo.addEventListener(Event.COMPLETE, this.onPreLoadingCompleted);
            root.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onPreLoadingFailed);
            this.var_30 = this.var_29[int((Math.random() * (this.var_29.length - 1)))];
            this.var_28 = new Timer(250, 0);
            this.var_28.addEventListener(TimerEvent.TIMER, this.onVisualizationUpdate);
            this.var_24 = this.createLoadingScreen();
            addChild(this.var_24);
            this.positionLoadingScreenDisplayElements(this.var_24);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.checkPreLoadingStatus();
        }

        private function dispose():void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            root.removeEventListener(Event.RESIZE, this.onResize);
            if (!this._disposed)
            {
                this._disposed = true;
                if (this.var_27)
                {
                    this.var_27 = null;
                };
                if (this.var_24)
                {
                    this.disposeLoadingScreen(this.var_24);
                    removeChild(this.var_24);
                    this.var_24 = null;
                };
                if (parent)
                {
                    parent.removeChild(this);
                };
            };
        }

        private function onPreLoadingProgress(param1:Event):void
        {
            this.checkPreLoadingStatus();
            if (this.var_24)
            {
                this.updateLoadingBar(this.var_24, (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal));
            };
        }

        private function onPreLoadingStatus(param1:HTTPStatusEvent):void
        {
            this.var_25 = param1.status;
        }

        private function onPreLoadingCompleted(event:Event):void
        {
            try
            {
                this.checkPreLoadingStatus();
            }
            catch(error:Error)
            {
                trackLoginStep(var_2);
                reportCrash(("Failed to finalize main swf preloading: " + error.message), var_14, error);
            };
        }

        private function onPreLoadingFailed(param1:IOErrorEvent):void
        {
            trackLoginStep(var_2);
            reportCrash(((("Failed to finalize main swf preloading: " + param1.text) + " / HTTP status: ") + this.var_25), var_14, null);
        }

        private function checkPreLoadingStatus():void
        {
            if (!this.var_23)
            {
                if (root.loaderInfo.bytesLoaded == root.loaderInfo.bytesTotal)
                {
                    this.finalizePreloading();
                };
            };
        }

        private function finalizePreloading():void
        {
            var _loc1_:Class;
            var _loc2_:Sprite;
            var _loc3_:HabboMain;
            if (!this.var_23)
            {
                this.var_23 = true;
                trackLoginStep(var_3);
                if (this.var_24)
                {
                    _loc2_ = (this.var_24.getChildByName(var_18) as Sprite);
                    _loc2_.visible = false;
                };
                root.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onPreLoadingProgress);
                root.loaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.onPreLoadingStatus);
                root.loaderInfo.removeEventListener(Event.COMPLETE, this.onPreLoadingCompleted);
                root.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onPreLoadingFailed);
                nextFrame();
                _loc1_ = Class(getDefinitionByName("HabboMain"));
                if (_loc1_)
                {
                    _loc3_ = (new _loc1_(this.var_24) as HabboMain);
                    if (_loc3_)
                    {
                        _loc3_.addEventListener(Event.REMOVED, this.onMainRemoved);
                        addChild(_loc3_);
                    };
                };
            };
        }

        private function onResize(param1:Event):void
        {
            if (param1.type == Event.RESIZE)
            {
                if (this.var_24)
                {
                    this.positionLoadingScreenDisplayElements(this.var_24);
                };
            };
        }

        private function onEnterFrame(param1:Event):void
        {
            parent.setChildIndex(this, (parent.numChildren - 1));
        }

        private function onMainRemoved(param1:Event):void
        {
            this.dispose();
        }

        private function onVisualizationUpdate(param1:Event):void
        {
            if (this.var_27)
            {
                if (this.var_31 >= this.var_30.length)
                {
                    this.var_31 = 0;
                };
                this.var_27.text = ((this.var_26 + "") + this.var_30[this.var_31]);
                this.var_31++;
            };
        }

        private function updateLoadingBar(param1:DisplayObjectContainer, param2:Number):void
        {
            var _loc11_:int;
            var _loc12_:int;
            var _loc3_:* = 200;
            var _loc4_:int = 20;
            var _loc5_:int = 1;
            var _loc6_:int = 1;
            var _loc7_:Sprite = (param1.getChildByName(var_16) as Sprite);
            var _loc8_:Sprite = (_loc7_.getChildByName(var_17) as Sprite);
            var _loc9_:Sprite = (param1.getChildByName(var_18) as Sprite);
            var _loc10_:Sprite = (_loc9_.getChildByName(var_19) as Sprite);
            _loc8_.x = (_loc5_ + _loc6_);
            _loc8_.y = (_loc5_ + _loc6_);
            _loc8_.graphics.clear();
            _loc11_ = ((_loc4_ - (_loc5_ * 2)) - (_loc6_ * 2));
            _loc12_ = 0;
            _loc8_.graphics.beginFill(12241619);
            _loc8_.graphics.drawRect(0, 0, _loc12_, (_loc11_ / 2));
            _loc8_.graphics.endFill();
            _loc8_.graphics.beginFill(9216429);
            _loc8_.graphics.drawRect(0, (_loc11_ / 2), _loc12_, ((_loc11_ / 2) + 1));
            _loc8_.graphics.endFill();
            _loc10_.x = (_loc5_ + _loc6_);
            _loc10_.y = (_loc5_ + _loc6_);
            _loc10_.graphics.clear();
            _loc11_ = ((_loc4_ - (_loc5_ * 2)) - (_loc6_ * 2));
            _loc12_ = (((_loc3_ - (_loc5_ * 2)) - (_loc6_ * 2)) * param2);
            _loc10_.graphics.beginFill(8030867);
            _loc10_.graphics.drawRect(0, 0, _loc12_, (_loc11_ / 2));
            _loc10_.graphics.endFill();
            _loc10_.graphics.beginFill(8159645);
            _loc10_.graphics.drawRect(0, (_loc11_ / 2), _loc12_, ((_loc11_ / 2) + 1));
            _loc10_.graphics.endFill();
        }

        public function createLoadingScreen():DisplayObjectContainer
        {
            var _loc5_:Sprite;
            var _loc6_:Sprite;
            var _loc1_:Sprite = new Sprite();
            var _loc2_:Sprite = new Sprite();
            _loc2_.name = var_20;
            _loc2_.graphics.clear();
            _loc2_.graphics.beginFill(0xFF000000);
            _loc2_.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            _loc1_.addChild(_loc2_);
            var _loc3_:Bitmap = (new this.habboLogoClass() as Bitmap);
            _loc3_.name = var_21;
            _loc1_.addChild(_loc3_);
            this.var_27 = new TextField();
            this.var_27.name = var_22;
            if (stage.loaderInfo.parameters[var_4] != null)
            {
                this.var_26 = stage.loaderInfo.parameters[var_4];
            }
            else
            {
                this.var_26 = var_4;
            };
            var _loc4_:TextFormat = new TextFormat();
            _loc4_.font = "Verdana";
            _loc4_.color = 0xFFFFFF;
            _loc4_.size = 9;
            this.var_27.defaultTextFormat = _loc4_;
            this.var_27.text = this.var_26;
            this.var_27.autoSize = TextFieldAutoSize.LEFT;
            _loc1_.addChild(this.var_27);
            _loc5_ = new Sprite();
            _loc5_.name = var_16;
            _loc5_.graphics.lineStyle(1, 0xFFFFFF);
            _loc5_.graphics.beginFill(2500143);
            _loc5_.graphics.drawRect(1, 0, (200 - 1), 0);
            _loc5_.graphics.drawRect(200, 1, 0, (20 - 1));
            _loc5_.graphics.drawRect(1, 20, (200 - 1), 0);
            _loc5_.graphics.drawRect(0, 1, 0, (20 - 1));
            _loc5_.graphics.endFill();
            _loc1_.addChild(_loc5_);
            _loc6_ = new Sprite();
            _loc6_.name = var_17;
            _loc5_.addChild(_loc6_);
            _loc5_ = new Sprite();
            _loc5_.name = var_18;
            _loc5_.graphics.lineStyle(1, 0x888888);
            _loc5_.graphics.beginFill(2500143);
            _loc5_.graphics.drawRect(1, 0, (200 - 1), 0);
            _loc5_.graphics.drawRect(200, 1, 0, (20 - 1));
            _loc5_.graphics.drawRect(1, 20, (200 - 1), 0);
            _loc5_.graphics.drawRect(0, 1, 0, (20 - 1));
            _loc5_.graphics.endFill();
            _loc1_.addChild(_loc5_);
            _loc6_ = new Sprite();
            _loc6_.name = var_19;
            _loc5_.addChild(_loc6_);
            _loc5_.visible = true;
            this.updateLoadingBar(_loc1_, 0);
            this.positionLoadingScreenDisplayElements(_loc1_);
            this.var_28.start();
            return (_loc1_);
        }

        public function disposeLoadingScreen(param1:DisplayObjectContainer):void
        {
            var _loc2_:DisplayObject;
            _loc2_ = param1.getChildByName(var_20);
            if (_loc2_)
            {
                param1.removeChild(_loc2_);
            };
            if (this.var_27)
            {
                param1.removeChild(this.var_27);
            };
            _loc2_ = param1.getChildByName(var_21);
            if (_loc2_)
            {
                param1.removeChild(_loc2_);
            };
            _loc2_ = param1.getChildByName(var_16);
            if (_loc2_)
            {
                param1.removeChild(_loc2_);
            };
            _loc2_ = param1.getChildByName(var_18);
            if (_loc2_)
            {
                param1.removeChild(_loc2_);
            };
            if (this.var_28)
            {
                this.var_28.stop();
                this.var_28 = null;
            };
        }

        private function positionLoadingScreenDisplayElements(param1:DisplayObjectContainer):void
        {
            var _loc2_:Stage = param1.stage;
            var _loc3_:Sprite = (param1.getChildByName(var_20) as Sprite);
            if (_loc3_)
            {
                _loc3_.x = 0;
                _loc3_.y = 0;
                _loc3_.graphics.clear();
                _loc3_.graphics.beginFill(0xFF000000);
                _loc3_.graphics.drawRect(0, 0, ((_loc2_) ? _loc2_.stageWidth : param1.width), ((_loc2_) ? _loc2_.stageHeight : param1.height));
            };
            var _loc4_:Bitmap = (param1.getChildByName(var_21) as Bitmap);
            if (_loc4_)
            {
                _loc4_.x = 117;
                _loc4_.y = 57;
            };
            var _loc5_:TextField = (param1.getChildByName(var_22) as TextField);
            if (_loc5_)
            {
                _loc5_.x = (191 - (_loc5_.width / 2));
                if (_loc4_)
                {
                    _loc5_.y = (((_loc4_.y + _loc4_.height) + 28) - 10);
                };
            };
            var _loc6_:Sprite = (param1.getChildByName(var_16) as Sprite);
            if (_loc6_)
            {
                _loc6_.x = 89;
                _loc6_.y = 149;
            };
            var _loc7_:Sprite = (param1.getChildByName(var_18) as Sprite);
            if (_loc7_)
            {
                _loc7_.x = 89;
                _loc7_.y = 179;
            };
        }


    }
}
