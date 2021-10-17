package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.notifications.AchievementLevelUpData;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.filters.ColorMatrixFilter;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.GetAchievementShareIdComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class AchievementLevelUp implements IDisposable 
    {

        private static const var_2200:int = 2000;
        private static const var_2202:int = 500;
        private static const var_2206:int = 500;
        private static const var_4423:int = 300;
        private static const var_2205:int = 1400;
        private static const var_2210:Number = 1;
        private static const var_2209:int = 3;
        private static const var_2207:int = 0;
        private static const var_2203:int = 1;
        private static const var_2204:int = 2;
        private static const var_2208:int = 3;

        private var _window:IFrameWindow;
        private var var_4407:HabboQuestEngine;
        private var var_4043:AchievementLevelUpData;
        private var var_4424:Array = new Array();
        private var var_4425:int;
        private var var_4426:int = 0;
        private var var_4427:int;
        private var var_4428:int;
        private var var_4429:int;
        private var var_4430:int = 3;
        private var var_4431:BitmapData;
        private var var_4432:Point;
        private var var_4422:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        private var var_4433:ColorMatrixFilter = new ColorMatrixFilter(var_4422);
        private var var_4434:Animation;

        public function AchievementLevelUp(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
        }

        public function dispose():void
        {
            this.var_4407 = null;
            this.var_4424 = null;
            this.var_4043 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_4434)
            {
                this.var_4434.dispose();
                this.var_4434 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._window == null);
        }

        public function onLevelUp(param1:AchievementLevelUpData):void
        {
            this.var_4424.push(param1);
            this.var_4407.sessionDataManager.requestBadgeImage(param1.badgeCode);
            this.var_4407.sessionDataManager.requestBadgeImage(this.var_4407.localization.getPreviousLevelBadgeId(param1.badgeCode));
            if (((this._window == null) || (!(this._window.visible))))
            {
                this.var_4425 = var_2200;
            };
            this.prepare();
        }

        private function close():void
        {
            if (this._window)
            {
                this._window.visible = false;
                if (this.var_4424.length > 0)
                {
                    this.var_4425 = var_2202;
                };
            };
        }

        private function prepare():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IFrameWindow(this.var_4407.getXmlWindow("AchievementLevelUp"));
            this._window.findChildByTag("close").procedure = this.onCloseLink;
            this._window.findChildByName("ok_button").procedure = this.onOkButton;
            this._window.findChildByName("share_button").procedure = this.onShareButton;
            new PendingImage(this.var_4407, this._window.findChildByName("reward_icon"), "ach_receive_star");
            this._window.findChildByName("achievements_link_region").procedure = this.onAchievementsLink;
            this._window.findChildByName("close_link_region").procedure = this.onCloseLink;
            this.var_4434 = this.var_4407.getTwinkleAnimation(this._window);
            this._window.visible = false;
        }

        private function show():void
        {
            this.prepare();
            this.registerParameter("achievements.levelup.title", "category", this.var_4407.getAchievementCategoryName(this.var_4043.category));
            this.registerParameter("achievements.levelup.reward", "amount", ("" + this.var_4043.levelRewardPoints));
            this.registerParameter("achievements.levelup.reward", "currency_name", this.var_4407.getActivityPointName(this.var_4043.levelRewardPointType));
            this.registerParameter("achievements.levelup.score", "amount", ("" + this.var_4043.points));
            this.registerParameter("achievements.levelup.sharedesc", "amount", ("" + this.var_4043.bonusPoints));
            this._window.findChildByName("achievement_name_txt").caption = (("'" + this.var_4407.localization.getBadgeName(this.var_4043.badgeCode)) + "'");
            var _loc1_:Boolean = this.isFacebookPostingEnabled();
            this._window.findChildByName("achievements_link_region").visible = (!(_loc1_));
            this._window.findChildByName("close_link_region").visible = _loc1_;
            this._window.findChildByName("ok_button").visible = (!(_loc1_));
            this._window.findChildByName("share_button").visible = _loc1_;
            this._window.findChildByName("facebook_info_txt").visible = _loc1_;
            this.doFacebookLogging();
            if (this.var_4043.level > 1)
            {
                this.setFadeStatus(var_2203);
            }
            else
            {
                this.setFadeStatus(var_2204, var_2205);
            };
            this.var_4434.restart();
        }

        private function setFadeStatus(param1:int, param2:int=300):void
        {
            this.var_4431 = null;
            this.var_4426 = param1;
            this.var_4428 = param2;
            this.var_4427 = param2;
            this.var_4429 = var_2206;
        }

        private function isFacebookPostingEnabled():Boolean
        {
            return (((this.var_4043.bonusPoints > 0) && (this.isPostingEnabled())) && (this.var_4407.configuration.keyExists("facebook.user")));
        }

        private function isPostingEnabled():Boolean
        {
            return (!(this.var_4407.configuration.getKey("achievement.post.enabled", "1") == "0"));
        }

        private function doFacebookLogging():void
        {
            var _loc1_:Boolean = this.var_4407.configuration.keyExists("facebook.user");
            var _loc2_:String = this.var_4043.badgeCode;
            if (((this.var_4043.bonusPoints <= 0) || (!(this.isPostingEnabled()))))
            {
                this.var_4407.send(new EventLogMessageComposer("Achievements", _loc2_, "client.show.no_post"));
            }
            else
            {
                if (_loc1_)
                {
                    this.var_4407.send(new EventLogMessageComposer("Achievements", _loc2_, "client.show.post"));
                }
                else
                {
                    this.var_4407.send(new EventLogMessageComposer("Achievements", _loc2_, "client.show.no_fb"));
                };
            };
        }

        private function onOkButton(param1:WindowEvent, param2:IWindow=null):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.close();
            };
        }

        private function onCloseLink(param1:WindowEvent, param2:IWindow=null):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.close();
            };
        }

        private function onAchievementsLink(param1:WindowEvent, param2:IWindow=null):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4407.achievementController.show();
                this.close();
            };
        }

        private function onShareButton(param1:WindowEvent, param2:IWindow=null):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4407.send(new GetAchievementShareIdComposer(this.var_4043.achievementID));
                this.var_4407.send(new EventLogMessageComposer("Achievements", this.var_4043.badgeCode, "client.start_post"));
            };
        }

        public function update(param1:uint):void
        {
            if (this.var_4425 > 0)
            {
                this.checkDialogOpen(param1);
                return;
            };
            if (this.var_4434 != null)
            {
                this.var_4434.update(param1);
            };
            if (((this._window == null) || (this.var_4426 == var_2207)))
            {
                return;
            };
            switch (this.var_4426)
            {
                case var_2203:
                    this.var_4429 = (this.var_4429 - param1);
                    this.animateBadgeImage(true);
                    if (this.var_4429 < 0)
                    {
                        this.setFadeStatus(var_2208);
                    };
                    return;
                case var_2208:
                    this.var_4428 = (this.var_4428 - param1);
                    this.animateBadgeImage(true);
                    if (this.var_4428 < 0)
                    {
                        this.setFadeStatus(var_2204);
                    };
                    return;
                case var_2204:
                    this.var_4428 = (this.var_4428 - param1);
                    this.animateBadgeImage(false);
                    if (this.var_4428 < 0)
                    {
                        this.setFadeStatus(var_2207);
                    };
                    return;
            };
        }

        private function checkDialogOpen(param1:uint):void
        {
            this.var_4425 = (this.var_4425 - param1);
            if (this.var_4425 > 0)
            {
                return;
            };
            if (this.var_4424.length < 1)
            {
                return;
            };
            var _loc2_:AchievementLevelUpData = this.var_4424.pop();
            if (((this.var_4407.sessionDataManager.getBadgeImageWithInfo(_loc2_.badgeCode).placeHolder) || (this.var_4407.sessionDataManager.getBadgeImageWithInfo(this.var_4407.localization.getPreviousLevelBadgeId(_loc2_.badgeCode)).placeHolder)))
            {
                if (this.var_4430 > 0)
                {
                    this.var_4424.push(_loc2_);
                    this.var_4425 = var_2200;
                    this.var_4430--;
                    return;
                };
                this.var_4430 = var_2209;
            };
            this.var_4043 = _loc2_;
            this.show();
            this._window.center();
            this._window.visible = true;
            this._window.activate();
        }

        public function requestFacebookPostDialog(param1:String, param2:String):void
        {
            if ((((this._window == null) || (this.var_4043 == null)) || (!(this.var_4043.badgeCode == param1))))
            {
                Logger.log(((("Invalid facebook post: " + param1) + ", ") + ((this.var_4043 == null) ? "current is null" : this.var_4043.badgeCode)));
                return;
            };
            var _loc3_:String = this.getFacebookText("notifications.text.achievement_facebook");
            var _loc4_:String = this.getFacebookText("notifications.text.achievement_facebook_title");
            HabboWebTools.facebookAchievementPost(this.var_4043.badgeCode, _loc4_, _loc3_, param2);
            this.close();
        }

        private function getFacebookText(param1:String):String
        {
            var _loc2_:String = this.var_4407.sessionDataManager.userName;
            var _loc3_:String = this.var_4407.sessionDataManager.realName;
            var _loc4_:String = this.var_4407.localization.getAchievementNameForFacebook(this.var_4043.badgeCode, _loc2_, _loc3_, this.var_4043.level);
            var _loc5_:String = this.var_4407.localization.getAchievementDescForFacebook(this.var_4043.badgeCode, _loc2_, _loc3_, this.var_4043.level);
            this.registerParameter(param1, "badge_name", this.var_4407.localization.getBadgeName(this.var_4043.badgeCode));
            this.registerParameter(param1, "badge_desc", this.var_4407.localization.getBadgeDesc(this.var_4043.badgeCode));
            this.registerParameter(param1, "badge_name_fb", _loc4_);
            this.registerParameter(param1, "badge_desc_fb", _loc5_);
            this.registerParameter(param1, "level", this.var_4043.level.toString());
            this.registerParameter(param1, "name", _loc2_);
            this.registerParameter(param1, "realname", _loc3_);
            return (this.var_4407.localization.getKey(param1, param1));
        }

        private function registerParameter(param1:String, param2:String, param3:String):void
        {
            this.var_4407.localization.registerParameter(param1, param2, param3);
        }

        private function animateBadgeImage(param1:Boolean):void
        {
            this.changeBadgeColorFilter(param1);
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(this._window.findChildByName("achievement_pic_bitmap"));
            if (_loc2_.bitmap == null)
            {
                _loc2_.bitmap = new BitmapData(_loc2_.width, _loc2_.height, true, 0);
            };
            if (this.var_4431 == null)
            {
                this.var_4431 = ((param1) ? this.var_4407.sessionDataManager.getBadgeImage(this.var_4407.localization.getPreviousLevelBadgeId(this.var_4043.badgeCode)) : this.var_4407.sessionDataManager.getBadgeImage(this.var_4043.badgeCode));
                this.var_4432 = new Point(((_loc2_.width - this.var_4431.width) / 2), ((_loc2_.height - this.var_4431.height) / 2));
            };
            _loc2_.bitmap.fillRect(_loc2_.bitmap.rect, 0);
            _loc2_.bitmap.applyFilter(this.var_4431, this.var_4431.rect, this.var_4432, this.var_4433);
            _loc2_.invalidate(_loc2_.rectangle);
        }

        private function changeBadgeColorFilter(param1:Boolean):void
        {
            var _loc2_:int = Math.max(0, ((param1) ? (this.var_4427 - this.var_4428) : this.var_4428));
            var _loc3_:Number = ((_loc2_ / this.var_4427) * var_2210);
            this.var_4422[3] = _loc3_;
            this.var_4422[8] = _loc3_;
            this.var_4422[13] = _loc3_;
            this.var_4422[0] = (1 - _loc3_);
            this.var_4422[6] = (1 - _loc3_);
            this.var_4422[12] = (1 - _loc3_);
            this.var_4433.matrix = this.var_4422;
        }


    }
}