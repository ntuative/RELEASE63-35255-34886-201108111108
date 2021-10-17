package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.IFrameWindow;

    public class QuestTracker implements IDisposable 
    {

        private static const var_2181:int = 0;
        private static const var_2172:int = 1;
        private static const var_2171:int = 2;
        private static const var_2170:int = 3;
        private static const var_2191:int = 4;
        private static const var_2184:int = 5;
        private static const var_2190:int = 6;
        private static const var_2188:Array = [-2, -3, -2, 0, 2, 3, 2, 0, 2, 1, 0, 1];
        private static const var_2183:Array = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 4];
        private static const var_2177:int = 6;
        private static const var_2173:int = 4;
        private static const var_2175:int = 2;
        private static const var_2186:int = 200;
        private static const var_2176:Array = ["a", "b", "c", "d"];
        private static const var_2187:int = 10000;
        private static const var_2174:int = 0;
        private static const var_2189:int = -1;
        private static const var_2179:Point = new Point(10, 87);
        private static const var_2178:int = 162;
        private static const var_2180:Number = 0.01;
        private static const var_2182:Number = 100;
        private static const var_2185:int = 1000;
        private static const var_621:String = "quest_tracker";
        private static const var_2192:int = 10;

        private var var_4407:HabboQuestEngine;
        private var var_4465:QuestMessageData;
        private var _window:IWindowContainer;
        private var var_4466:Timer;
        private var var_4467:ProgressBar;
        private var var_4468:int = 0;
        private var var_4469:int = 0;
        private var var_4470:int = 0;
        private var var_4471:int = -1;
        private var var_4472:int = -1;
        private var var_4473:int = -1;
        private var var_4474:int;
        private var var_4475:int;
        private var var_4476:Boolean;

        public function QuestTracker(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
        }

        public function dispose():void
        {
            if (this.var_4407)
            {
                this.var_4407.toolbar.extensionView.detachExtension(var_621);
            };
            this.var_4407 = null;
            this.var_4465 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_4466)
            {
                this.var_4466.stop();
                this.var_4466 = null;
            };
            if (this.var_4467)
            {
                this.var_4467.dispose();
                this.var_4467 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this.var_4407 == null);
        }

        public function onQuestCompleted(param1:QuestMessageData):void
        {
            if (this._window)
            {
                this.clearPrompt();
                this.var_4465 = param1;
                this.var_4469 = 0;
                this.refreshTrackerDetails();
                this.var_4471 = 0;
                this.var_4468 = var_2170;
            };
        }

        public function onQuestCancelled():void
        {
            this.var_4465 = null;
            if (this._window)
            {
                this.clearPrompt();
                this.var_4467.refresh(0, 100, -1);
                this.var_4468 = var_2171;
            };
        }

        public function onRoomEnter():void
        {
            var _loc3_:int;
            var _loc1_:Boolean = Boolean(parseInt(this.var_4407.configuration.getKey("new.identity", "0")));
            var _loc2_:String = this.getDefaultCampaign();
            if ((((this.var_4466 == null) && (_loc1_)) && (!(_loc2_ == ""))))
            {
                _loc3_ = int(this.var_4407.configuration.getKey("questing.startQuestDelayInSeconds", "30"));
                this.var_4466 = new Timer((_loc3_ * 1000), 1);
                this.var_4466.addEventListener(TimerEvent.TIMER, this.onStartQuestTimer);
                this.var_4466.start();
                Logger.log(("Initialized start quest timer with period: " + _loc3_));
            };
        }

        public function onRoomExit():void
        {
            if (((!(this._window == null)) && (this._window.visible)))
            {
                this._window.findChildByName("more_info_txt").visible = false;
                this._window.findChildByName("more_info_region").visible = false;
            };
        }

        public function onQuest(param1:QuestMessageData):void
        {
            var _loc2_:Boolean = ((this._window) && (this._window.visible));
            if (param1.waitPeriodSeconds > 0)
            {
                if (_loc2_)
                {
                    this.setWindowVisible(false);
                };
                return;
            };
            this.var_4465 = param1;
            this.prepareTrackerWindow();
            this.refreshTrackerDetails();
            this.refreshPromptFrames();
            this.setWindowVisible(true);
            this.hideSuccessFrames();
            if (_loc2_)
            {
                if (this.var_4468 == var_2171)
                {
                    this.var_4468 = var_2172;
                };
                this.setupPrompt(this.var_4472, var_2173, false);
            }
            else
            {
                this._window.x = this.getOutScreenLocationX();
                this.var_4468 = var_2172;
                this.setupPrompt(var_2174, var_2175, false);
            };
        }

        private function refreshPromptFrames():void
        {
            if (!this.var_4407.isQuestWithPrompts(this.var_4465))
            {
                return;
            };
            var _loc1_:int;
            while (_loc1_ < var_2176.length)
            {
                this.var_4407.setupPromptFrameImage(this._window, this.var_4465, var_2176[_loc1_]);
                _loc1_++;
            };
        }

        private function prepareTrackerWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IWindowContainer(this.var_4407.getXmlWindow("QuestTracker"));
            this._window.findChildByName("more_info_region").procedure = this.onMoreInfo;
            new PendingImage(this.var_4407, this._window.findChildByName("quest_tracker_bg"), "quest_tracker_with_bar");
            var _loc1_:int = 1;
            while (_loc1_ <= var_2177)
            {
                new PendingImage(this.var_4407, this.getSuccessFrame(_loc1_), ("checkanim" + _loc1_));
                _loc1_++;
            };
            this.hideSuccessFrames();
            this.var_4467 = new ProgressBar(this.var_4407, IWindowContainer(this._window.findChildByName("content_cont")), var_2178, "quests.tracker.progress", false, var_2179);
        }

        private function hideSuccessFrames():void
        {
            var _loc1_:int = 1;
            while (_loc1_ <= var_2177)
            {
                this.getSuccessFrame(_loc1_).visible = false;
                _loc1_++;
            };
        }

        private function hidePromptFrames():void
        {
            var _loc1_:int;
            while (_loc1_ < var_2176.length)
            {
                this.getPromptFrame(var_2176[_loc1_]).visible = false;
                _loc1_++;
            };
        }

        private function getSuccessFrame(param1:int):IBitmapWrapperWindow
        {
            return (IBitmapWrapperWindow(this._window.findChildByName(("success_pic_" + param1))));
        }

        private function getPromptFrame(param1:String):IBitmapWrapperWindow
        {
            return (IBitmapWrapperWindow(this._window.findChildByName(("prompt_pic_" + param1))));
        }

        private function refreshTrackerDetails():void
        {
            this.var_4407.localization.registerParameter("quests.tracker.caption", "quest_name", this.var_4407.getQuestName(this.var_4465));
            this._window.findChildByName("desc_txt").caption = this.var_4407.getQuestDesc(this.var_4465);
            this._window.findChildByName("more_info_txt").visible = this.var_4407.currentlyInRoom;
            this._window.findChildByName("more_info_region").visible = this.var_4407.currentlyInRoom;
            var _loc1_:int = int(Math.round(((100 * this.var_4465.completedSteps) / this.var_4465.totalSteps)));
            this.var_4467.refresh(_loc1_, 100, this.var_4465.id);
            this.var_4407.setupQuestImage(this._window, this.var_4465);
        }

        private function onMoreInfo(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4407.questController.questDetails.showDetails(this.var_4465);
            };
        }

        public function update(param1:uint):void
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:int;
            if (this._window == null)
            {
                return;
            };
            this.var_4467.updateView();
            switch (this.var_4468)
            {
                case var_2172:
                    _loc2_ = this.getDefaultLocationX();
                    _loc3_ = (this._window.x - _loc2_);
                    if (_loc3_ > 0)
                    {
                        _loc4_ = Math.max(1, Math.round(((_loc3_ * param1) * var_2180)));
                        this._window.x = (this._window.x - _loc4_);
                    }
                    else
                    {
                        this.var_4468 = var_2181;
                        this._window.x = _loc2_;
                    };
                    return;
                case var_2171:
                    _loc2_ = this.getOutScreenLocationX();
                    _loc3_ = (this._window.width - this._window.x);
                    if (_loc3_ > 0)
                    {
                        _loc4_ = int(Math.max(1, Math.round(((param1 * var_2182) / _loc3_))));
                        this._window.x = (this._window.x + _loc4_);
                    }
                    else
                    {
                        this.var_4468 = var_2181;
                        this._window.x = _loc2_;
                        this.setWindowVisible(false);
                    };
                    return;
                case var_2170:
                    this.hideSuccessFrames();
                    this.getSuccessFrame(var_2183[this.var_4471]).visible = true;
                    this.var_4471++;
                    if (this.var_4471 >= var_2183.length)
                    {
                        this.var_4468 = var_2184;
                        this.var_4470 = var_2185;
                    };
                    return;
                case var_2190:
                    this.setQuestImageVisible(false);
                    this.hidePromptFrames();
                    this.var_4474 = (this.var_4474 - param1);
                    this.getPromptFrame(var_2176[this.var_4473]).visible = true;
                    if (this.var_4474 < 0)
                    {
                        this.var_4474 = var_2186;
                        this.var_4473++;
                        if (this.var_4473 >= var_2176.length)
                        {
                            this.var_4473 = 0;
                            this.var_4475--;
                            if (this.var_4475 < 1)
                            {
                                this.setupPrompt(var_2187, var_2175, true);
                                this.var_4468 = var_2181;
                            };
                        };
                    };
                    return;
                case var_2191:
                    if (this.var_4469 >= (var_2188.length - 1))
                    {
                        this._window.x = this.getDefaultLocationX();
                        this.var_4468 = var_2181;
                        this.setupPrompt(var_2187, var_2175, false);
                    }
                    else
                    {
                        this._window.x = (this.getDefaultLocationX() + var_2188[this.var_4469]);
                        this.var_4469++;
                    };
                    return;
                case var_2184:
                    this.var_4470 = (this.var_4470 - param1);
                    if (this.var_4470 < 0)
                    {
                        this.var_4468 = var_2181;
                        this.setWindowVisible(false);
                    };
                    return;
                case var_2181:
                    if (this.var_4472 != var_2189)
                    {
                        this.var_4472 = (this.var_4472 - param1);
                        if (this.var_4472 < 0)
                        {
                            this.var_4472 = var_2189;
                            if (((!(this.var_4465 == null)) && (this.var_4407.isQuestWithPrompts(this.var_4465))))
                            {
                                if (this.var_4476)
                                {
                                    this.startNudge();
                                }
                                else
                                {
                                    this.var_4468 = var_2190;
                                    this.var_4473 = 0;
                                    this.var_4474 = var_2186;
                                };
                            };
                        };
                    };
                    return;
            };
        }

        private function getDefaultLocationX():int
        {
            return (0);
        }

        private function getOutScreenLocationX():int
        {
            return (this._window.width + var_2192);
        }

        public function isVisible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        private function onStartQuestTimer(param1:TimerEvent):void
        {
            if (this.hasBlockingWindow())
            {
                Logger.log("Quest start blocked. Waiting some more");
                this.var_4466.reset();
                this.var_4466.start();
            }
            else
            {
                this.var_4407.questController.questDetails.openForNextQuest = (this.var_4407.configuration.getKey("questing.showDetailsForNextQuest") == "true");
                this.var_4407.send(new StartCampaignMessageComposer(this.getDefaultCampaign(), this.var_4407.configuration.getBoolean("questing.useWing", false)));
            };
        }

        private function getDefaultCampaign():String
        {
            var _loc1_:String = this.var_4407.configuration.getKey("questing.defaultCampaign");
            return ((_loc1_ == null) ? "" : _loc1_);
        }

        private function hasBlockingWindow():Boolean
        {
            var _loc2_:IDesktopWindow;
            var _loc1_:int;
            while (_loc1_ <= 2)
            {
                _loc2_ = this.var_4407.windowManager.getDesktop(_loc1_);
                if (((!(_loc2_ == null)) && (this.hasBlockingWindowInLayer(_loc2_))))
                {
                    return (true);
                };
                _loc1_++;
            };
            return (false);
        }

        private function hasBlockingWindowInLayer(param1:IWindowContainer):Boolean
        {
            var _loc2_:int;
            var _loc3_:IWindow;
            while (_loc2_ < param1.numChildren)
            {
                _loc3_ = param1.getChildAt(_loc2_);
                if (((!(_loc3_ == null)) && (_loc3_.visible)))
                {
                    if ((_loc3_ as IFrameWindow) != null)
                    {
                        if (_loc3_.name != "mod_start_panel")
                        {
                            return (true);
                        };
                    }
                    else
                    {
                        if (_loc3_.name == "welcome_screen")
                        {
                            return (true);
                        };
                    };
                };
                _loc2_++;
            };
            return (false);
        }

        private function setQuestImageVisible(param1:Boolean):void
        {
            this._window.findChildByName("quest_pic_bitmap").visible = param1;
        }

        private function clearPrompt():void
        {
            this.setupPrompt(var_2189, 0, false);
        }

        private function setupPrompt(param1:int, param2:int, param3:Boolean):void
        {
            this.setQuestImageVisible(true);
            this.hidePromptFrames();
            this.var_4472 = param1;
            this.var_4475 = param2;
            this.var_4476 = param3;
        }

        private function startNudge():void
        {
            this.var_4469 = 0;
            this.var_4468 = var_2191;
        }

        private function setWindowVisible(param1:Boolean):void
        {
            this._window.visible = param1;
            if (!param1)
            {
                this.var_4407.toolbar.extensionView.detachExtension(var_621);
            }
            else
            {
                this.var_4407.toolbar.extensionView.attachExtension(var_621, this._window);
            };
        }


    }
}