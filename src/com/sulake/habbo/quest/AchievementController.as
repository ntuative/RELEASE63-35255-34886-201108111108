package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import flash.geom.Matrix;
    import flash.filters.ColorMatrixFilter;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.session.BadgeInfo;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;

    public class AchievementController implements IDisposable, IUpdateReceiver 
    {

        private static const var_1430:int = 3;
        private static const var_1432:int = 8;
        private static const var_1433:int = 5;
        private static const var_1434:int = 6;
        private static const var_1431:int = 3;
        private static const var_1436:int = 2;
        private static const var_1435:int = 6;
        private static const var_1426:int = 180;
        private static const var_1428:int = 246;
        private static const var_1424:int = 45;
        private static const var_1427:Point = new Point(115, 93);
        private static const var_1429:Point = new Point(72, 1);
        private static const var_1438:int = 40;
        private static const var_1425:int = 20;
        private static const var_1437:int = 3;
        private static const var_1439:int = 10;

        private var var_4407:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var var_4409:IWindowContainer;
        private var var_4410:IWindowContainer;
        private var var_4411:IWindowContainer;
        private var var_4412:IWindowContainer;
        private var var_4413:IWindowContainer;
        private var var_4414:IWindowContainer;
        private var var_534:AchievementCategories;
        private var _category:AchievementCategory;
        private var var_3703:AchievementData;
        private var var_4405:Timer;
        private var var_4415:Dictionary = new Dictionary();
        private var var_4416:ProgressBar;
        private var var_4417:ProgressBar;
        private var var_4418:Matrix;
        private var var_4419:ColorMatrixFilter;
        private var var_4420:AchievementData;
        private var var_4406:Timer;
        private var var_4408:Dictionary = new Dictionary();
        private var var_4421:AchievementLevelUp;

        public function AchievementController(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
            this.var_4405 = new Timer(100, 1);
            this.var_4405.addEventListener(TimerEvent.TIMER, this.doBadgeRefresh);
            this.var_4406 = new Timer(2000, 1);
            this.var_4406.addEventListener(TimerEvent.TIMER, this.switchIntoPendingLevel);
            this.var_4421 = new AchievementLevelUp(this.var_4407);
            this.var_4418 = new Matrix();
            this.var_4419 = this.createGrayscaleFilter();
            this.var_4408[16] = 1;
            this.var_4408[28] = 6;
            this.var_4408[38] = 4;
            this.var_4408[39] = 3;
            this.var_4408[40] = 1;
        }

        public static function moveAllChildrenToColumn(param1:IWindowContainer, param2:int, param3:int):void
        {
            var _loc4_:int;
            var _loc5_:IWindow;
            while (_loc4_ < param1.numChildren)
            {
                _loc5_ = param1.getChildAt(_loc4_);
                if ((((!(_loc5_ == null)) && (_loc5_.visible)) && (_loc5_.height > 0)))
                {
                    _loc5_.y = param2;
                    param2 = (param2 + (_loc5_.height + param3));
                };
                _loc4_++;
            };
        }

        public static function getLowestPoint(param1:IWindowContainer):int
        {
            var _loc4_:IWindow;
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < param1.numChildren)
            {
                _loc4_ = param1.getChildAt(_loc3_);
                if (_loc4_.visible)
                {
                    _loc2_ = Math.max(_loc2_, (_loc4_.y + _loc4_.height));
                };
                _loc3_++;
            };
            return (_loc2_);
        }


        public function dispose():void
        {
            this.var_4407 = null;
            this.var_4415 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_4405)
            {
                this.var_4405.removeEventListener(TimerEvent.TIMER, this.doBadgeRefresh);
                this.var_4405.reset();
                this.var_4405 = null;
            };
            if (this.var_4406)
            {
                this.var_4406.removeEventListener(TimerEvent.TIMER, this.switchIntoPendingLevel);
                this.var_4406.reset();
                this.var_4406 = null;
            };
            if (this.var_4416)
            {
                this.var_4416.dispose();
                this.var_4416 = null;
            };
            if (this.var_4417)
            {
                this.var_4417.dispose();
                this.var_4417 = null;
            };
            if (this.var_4421)
            {
                this.var_4421.dispose();
                this.var_4421 = null;
            };
            this.var_4409 = null;
            this.var_4411 = null;
            this.var_4411 = null;
            this.var_4413 = null;
            this.var_4412 = null;
            this.var_4414 = null;
        }

        public function get disposed():Boolean
        {
            return (this.var_4407 == null);
        }

        public function isVisible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        public function close():void
        {
            if (this._window)
            {
                this._window.visible = false;
            };
        }

        public function onRoomExit():void
        {
            this.close();
        }

        public function onToolbarClick():void
        {
            if (this.isVisible())
            {
                this.close();
            }
            else
            {
                this.show();
            };
        }

        public function show():void
        {
            if (this.var_534 == null)
            {
                this.var_4407.send(new GetAchievementsComposer());
            }
            else
            {
                this.refresh();
                this._window.visible = true;
                this._window.activate();
            };
        }

        public function onAchievements(param1:Array, param2:String):void
        {
            if (this.var_534 == null)
            {
                this.var_534 = new AchievementCategories(param1);
            };
            this.refresh();
            this._window.visible = true;
            this._window.activate();
            var _loc3_:AchievementCategory = this.var_534.getCategoryByCode(param2);
            if (_loc3_ != null)
            {
                this.pickCategory(_loc3_);
            };
        }

        public function onAchievement(param1:AchievementData):void
        {
            var _loc2_:Boolean;
            if (this.var_534 != null)
            {
                _loc2_ = ((this.var_3703) && (this.var_3703.type == param1.type));
                if (((_loc2_) && (param1.level > this.var_3703.level)))
                {
                    this.var_3703.setMaxProgress();
                    this.var_4420 = param1;
                    this.var_4406.start();
                }
                else
                {
                    this.var_534.update(param1);
                    if (_loc2_)
                    {
                        this.var_3703 = param1;
                    };
                };
                if (((this._window) && (this._window.visible)))
                {
                    this.refresh();
                };
            };
        }

        private function refresh():void
        {
            this.prepareWindow();
            this.refreshCategoryList();
            this.refreshCategoryListFooter();
            this.refreshAchievementsHeader();
            this.refreshAchievementsFooter();
            this.refreshAchievementList();
            this.refreshAchievementDetails();
            moveAllChildrenToColumn(this._window.content, 0, 4);
            this._window.height = (getLowestPoint(this._window.content) + var_1424);
        }

        private function refreshCategoryList():void
        {
            var _loc3_:Boolean;
            if (this._category != null)
            {
                this.var_4409.visible = false;
                return;
            };
            this.var_4409.visible = true;
            var _loc1_:Array = this.var_534.categoryList;
            var _loc2_:int;
            while (true)
            {
                if (_loc2_ < _loc1_.length)
                {
                    this.refreshCategoryEntry(_loc2_, _loc1_[_loc2_]);
                }
                else
                {
                    _loc3_ = this.refreshCategoryEntry(_loc2_, null);
                    if (_loc3_) break;
                };
                _loc2_++;
            };
            this.var_4409.height = getLowestPoint(this.var_4409);
        }

        private function refreshCategoryListFooter():void
        {
            if (this._category != null)
            {
                this.var_4414.visible = false;
                return;
            };
            this.var_4414.visible = true;
            this.var_4417.refresh(this.var_534.getProgress(), this.var_534.getMaxProgress(), 0);
        }

        private function refreshAchievementList():void
        {
            var _loc3_:Boolean;
            if (this._category == null)
            {
                this.var_4410.visible = false;
                return;
            };
            this.var_4410.visible = true;
            Logger.log((((this._category.code + " has ") + this._category.achievements.length) + " achievemenets"));
            var _loc1_:Array = this._category.achievements;
            var _loc2_:int;
            while (true)
            {
                if (_loc2_ < _loc1_.length)
                {
                    this.refreshAchievementEntry(_loc2_, _loc1_[_loc2_]);
                }
                else
                {
                    _loc3_ = this.refreshAchievementEntry(_loc2_, null);
                    if (_loc3_) break;
                };
                _loc2_++;
            };
            this.var_4410.height = getLowestPoint(this.var_4410);
        }

        private function refreshAchievementsHeader():void
        {
            if (this._category == null)
            {
                this.var_4413.visible = false;
                return;
            };
            this.var_4413.visible = true;
            this.var_4413.findChildByName("category_name_txt").caption = this.var_4407.getAchievementCategoryName(this._category.code);
            this.var_4407.localization.registerParameter("achievements.details.categoryprogress", "progress", ("" + this._category.getProgress()));
            this.var_4407.localization.registerParameter("achievements.details.categoryprogress", "limit", ("" + this._category.getMaxProgress()));
            this.var_4407.setupAchievementCategoryImage(this.var_4413, this._category, false);
        }

        private function refreshAchievementsFooter():void
        {
            if (this._category == null)
            {
                this.var_4412.visible = false;
                return;
            };
            this.var_4412.visible = true;
        }

        private function refreshAchievementDetails():void
        {
            if (this.var_3703 == null)
            {
                this.var_4411.visible = false;
                return;
            };
            this.var_4411.visible = true;
            var _loc1_:String = this.getAchievedBadgeId(this.var_3703);
            this.var_4411.findChildByName("achievement_name_txt").caption = this.var_4407.localization.getBadgeName(_loc1_);
            var _loc2_:String = this.var_4407.localization.getBadgeDesc(_loc1_);
            this.var_4411.findChildByName("achievement_desc_txt").caption = ((_loc2_ == null) ? "" : _loc2_);
            this.var_4407.localization.registerParameter("achievements.details.level", "level", ("" + ((this.var_3703.finalLevel) ? this.var_3703.level : (this.var_3703.level - 1))));
            this.var_4407.localization.registerParameter("achievements.details.level", "limit", ("" + this.var_3703.levelCount));
            this.var_4407.refreshReward((!(this.var_3703.finalLevel)), this.var_4411, this.var_3703.levelRewardPointType, this.var_3703.levelRewardPoints);
            this.refreshBadgeImageLarge(this.var_4411, this.var_3703);
            this.var_4416.refresh(this.var_3703.currentPoints, this.var_3703.scoreLimit, ((this.var_3703.type * 10000) + this.var_3703.level));
            this.var_4416.visible = (!(this.var_3703.finalLevel));
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IFrameWindow(this.var_4407.getXmlWindow("Achievements"));
            this._window.findChildByTag("close").procedure = this.onWindowClose;
            this._window.findChildByName("back_button").procedure = this.onBack;
            this._window.center();
            this._window.y = var_1425;
            this.var_4409 = IWindowContainer(this._window.findChildByName("categories_cont"));
            this.var_4413 = IWindowContainer(this._window.findChildByName("achievements_header_cont"));
            this.var_4410 = IWindowContainer(this._window.findChildByName("achievements_cont"));
            this.var_4411 = IWindowContainer(this._window.findChildByName("achievement_cont"));
            this.var_4412 = IWindowContainer(this._window.findChildByName("achievements_footer_cont"));
            this.var_4414 = IWindowContainer(this._window.findChildByName("categories_footer_cont"));
            this.var_4416 = new ProgressBar(this.var_4407, this.var_4411, var_1426, "achievements.details.progress", true, var_1427);
            this.var_4417 = new ProgressBar(this.var_4407, this.var_4414, var_1428, "achievements.categories.totalprogress", true, var_1429);
        }

        private function refreshCategoryEntry(param1:int, param2:AchievementCategory):Boolean
        {
            var _loc3_:IWindowContainer = IWindowContainer(this.var_4409.getChildByName(("" + param1)));
            var _loc4_:int = int(Math.floor((param1 / var_1430)));
            var _loc5_:* = (_loc4_ < var_1431);
            if (_loc3_ == null)
            {
                if (((param2 == null) && (!(_loc5_))))
                {
                    return (true);
                };
                _loc3_ = IWindowContainer(this.var_4407.getXmlWindow("AchievementCategory"));
                _loc3_.name = ("" + param1);
                this.var_4409.addChild(_loc3_);
                new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc3_.findChildByName("category_bg_act")), "achievement_bkg_active1");
                new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc3_.findChildByName("category_bg_act_hover")), "achievement_bkg_active2");
                new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc3_.findChildByName("category_bg_inact")), "achievement_category_bkg_empty_3");
                _loc3_.findChildByName("category_region").procedure = this.onSelectCategory;
                _loc3_.x = ((_loc3_.width + var_1432) * (param1 % var_1430));
                _loc3_.y = (((_loc3_.height + var_1433) * Math.floor((param1 / var_1430))) + var_1434);
            };
            _loc3_.findChildByName("category_region").id = param1;
            _loc3_.findChildByName("category_region").visible = (!(param2 == null));
            _loc3_.findChildByName("category_bg_inact").visible = (param2 == null);
            _loc3_.findChildByName("category_bg_act").visible = (!(param2 == null));
            _loc3_.findChildByName("category_bg_act_hover").visible = false;
            _loc3_.findChildByName("header_txt").visible = (!(param2 == null));
            _loc3_.findChildByName("completion_txt").visible = (!(param2 == null));
            _loc3_.findChildByName("category_pic_bitmap").visible = (!(param2 == null));
            if (param2)
            {
                _loc3_.findChildByName("header_txt").caption = this.var_4407.getAchievementCategoryName(param2.code);
                _loc3_.findChildByName("completion_txt").caption = ((param2.getProgress() + "/") + param2.getMaxProgress());
                this.var_4407.setupAchievementCategoryImage(_loc3_, param2, true);
                _loc3_.visible = true;
            }
            else
            {
                if (_loc5_)
                {
                    _loc3_.visible = true;
                }
                else
                {
                    _loc3_.visible = false;
                };
            };
            return (false);
        }

        private function refreshAchievementEntry(param1:int, param2:AchievementData):Boolean
        {
            var _loc9_:IBitmapWrapperWindow;
            var _loc3_:IWindowContainer = IWindowContainer(this.var_4410.getChildByName(("" + param1)));
            var _loc4_:int = int(Math.floor((param1 / var_1435)));
            var _loc5_:* = (_loc4_ < var_1436);
            if (_loc3_ == null)
            {
                if (((param2 == null) && (!(_loc5_))))
                {
                    return (true);
                };
                _loc3_ = IWindowContainer(this.var_4407.getXmlWindow("Achievement"));
                _loc3_.name = ("" + param1);
                this.var_4410.addChild(_loc3_);
                _loc9_ = (_loc3_.findChildByName("achievement_pic_bitmap") as IBitmapWrapperWindow);
                _loc9_.bitmap = new BitmapData(_loc9_.width, _loc9_.height, true, 0xFFFFFF);
                new PendingImage(this.var_4407, _loc3_.findChildByName("bg_selected_bitmap"), "achievement_active");
                new PendingImage(this.var_4407, _loc3_.findChildByName("bg_unselected_bitmap"), "achievement_inactive");
                _loc3_.x = (_loc3_.width * (param1 % var_1435));
                _loc3_.y = ((_loc3_.height * _loc4_) + var_1437);
                _loc3_.findChildByName("bg_region").procedure = this.onSelectAchievement;
            };
            var _loc6_:IWindow = _loc3_.findChildByName("bg_region");
            _loc6_.id = param1;
            _loc6_.visible = (!(param2 == null));
            var _loc7_:IWindow = _loc3_.findChildByName("bg_unselected_bitmap");
            var _loc8_:IWindow = _loc3_.findChildByName("bg_selected_bitmap");
            this.refreshBadgeImage(_loc3_, param2);
            if (param2)
            {
                _loc7_.visible = (!(param2 == this.var_3703));
                _loc8_.visible = (param2 == this.var_3703);
                _loc3_.visible = true;
            }
            else
            {
                if (_loc5_)
                {
                    _loc8_.visible = false;
                    _loc7_.visible = true;
                    _loc3_.visible = true;
                }
                else
                {
                    _loc3_.visible = false;
                };
            };
            return (false);
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.close();
            };
        }

        private function onSelectCategory(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:int = param2.id;
            Logger.log(("Category index: " + _loc3_));
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.pickCategory(this.var_534.categoryList[_loc3_]);
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_624)
                {
                    this.refreshMouseOver(-999);
                }
                else
                {
                    if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                    {
                        this.refreshMouseOver(_loc3_);
                    };
                };
            };
        }

        private function pickCategory(param1:AchievementCategory):void
        {
            this._category = param1;
            this.var_3703 = this._category.achievements[0];
            Logger.log(("Category: " + this._category.code));
            this.refresh();
            this.var_4407.send(new EventLogMessageComposer("Achievements", this._category.code, "Category selected"));
        }

        private function refreshMouseOver(param1:int):void
        {
            var _loc3_:Boolean;
            var _loc4_:IWindowContainer;
            var _loc5_:IWindow;
            var _loc2_:int;
            while (_loc2_ < this.var_4409.numChildren)
            {
                _loc3_ = (_loc2_ == param1);
                _loc4_ = IWindowContainer(this.var_4409.getChildAt(_loc2_));
                _loc4_.findChildByName("category_bg_act").visible = ((!(_loc3_)) && (_loc2_ < this.var_534.categoryList.length));
                _loc4_.findChildByName("category_bg_act_hover").visible = _loc3_;
                _loc5_ = _loc4_.findChildByName("hover_container");
                _loc5_.x = ((_loc3_) ? 0 : 1);
                _loc5_.y = ((_loc3_) ? 0 : 1);
                _loc2_++;
            };
        }

        private function onSelectAchievement(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:int = param2.id;
            this.var_3703 = this._category.achievements[_loc3_];
            this.refresh();
            this.var_4407.send(new EventLogMessageComposer("Achievements", ("" + this.var_3703.type), "Achievement selected"));
        }

        private function onBack(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this._category = null;
            this.var_3703 = null;
            this.refresh();
        }

        private function refreshBadgeImage(param1:IWindowContainer, param2:AchievementData):void
        {
            var _loc9_:BadgeInfo;
            var _loc3_:IBitmapWrapperWindow = (param1.findChildByName("achievement_pic_bitmap") as IBitmapWrapperWindow);
            if (param2 == null)
            {
                _loc3_.visible = false;
                return;
            };
            var _loc4_:String = this.getAchievedBadgeId(param2);
            var _loc5_:BitmapData = this.var_4415[_loc4_];
            var _loc6_:Boolean;
            if (_loc5_ == null)
            {
                _loc9_ = this.var_4407.sessionDataManager.getBadgeImageWithInfo(_loc4_);
                _loc5_ = _loc9_.image;
                _loc6_ = _loc9_.placeHolder;
                this.var_4415[_loc4_] = _loc5_;
            };
            var _loc7_:int = ((var_1438 - _loc5_.height) + this.getPositionFix(param2.type));
            var _loc8_:Point = new Point(((_loc3_.width - _loc5_.width) / 2), ((_loc6_) ? var_1439 : _loc7_));
            _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0xFFFFFF);
            if (param2.firstLevelAchieved)
            {
                _loc3_.bitmap.copyPixels(_loc5_, _loc5_.rect, _loc8_, null, null, true);
            }
            else
            {
                _loc3_.bitmap.applyFilter(_loc5_, _loc5_.rect, _loc8_, this.var_4419);
            };
            _loc3_.visible = false;
            _loc3_.visible = true;
        }

        private function refreshBadgeImageLarge(param1:IWindowContainer, param2:AchievementData):void
        {
            var _loc3_:IBitmapWrapperWindow = (param1.findChildByName("achievement_pic_bitmap") as IBitmapWrapperWindow);
            var _loc4_:String = this.getAchievedBadgeId(param2);
            var _loc5_:BitmapData = this.var_4415[_loc4_];
            if (_loc5_ == null)
            {
                _loc5_ = this.var_4407.sessionDataManager.getBadgeImage(_loc4_);
                this.var_4415[_loc4_] = _loc5_;
            };
            if (_loc3_.bitmap == null)
            {
                _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true, 0xFFFFFF);
            };
            var _loc6_:int = (2 * ((var_1438 - _loc5_.height) + this.getPositionFix(param2.type)));
            this.var_4418.identity();
            this.var_4418.scale(2, 2);
            this.var_4418.translate(((_loc3_.width - (_loc5_.width * 2)) / 2), _loc6_);
            _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0xFFFFFF);
            _loc3_.bitmap.draw(_loc5_, this.var_4418);
            if (!param2.firstLevelAchieved)
            {
                _loc3_.bitmap.applyFilter(_loc3_.bitmap, _loc3_.bitmap.rect, new Point(0, 0), this.var_4419);
            };
            _loc3_.visible = false;
            _loc3_.visible = true;
        }

        private function doBadgeRefresh(param1:TimerEvent):void
        {
            this.var_4405.reset();
            this.refresh();
        }

        private function switchIntoPendingLevel(param1:TimerEvent):void
        {
            this.var_3703 = this.var_4420;
            this.var_534.update(this.var_4420);
            this.var_4420 = null;
            this.refresh();
        }

        public function onBadgeImageReady(param1:BadgeImageReadyEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            this.var_4415[param1.badgeId] = param1.badgeImage;
            if (!this.var_4405.running)
            {
                this.var_4405.start();
            };
        }

        private function createGrayscaleFilter():ColorMatrixFilter
        {
            var _loc1_:Number = (1 / 3);
            var _loc2_:Number = (1 - (_loc1_ * 2));
            var _loc3_:Array = [_loc2_, _loc1_, _loc1_, 0, 0, _loc1_, _loc2_, _loc1_, 0, 0, _loc1_, _loc1_, _loc2_, 0, 0, 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_loc3_));
        }

        public function update(param1:uint):void
        {
            if (this.var_4416 != null)
            {
                this.var_4416.updateView();
            };
            if (this.var_4417 != null)
            {
                this.var_4417.updateView();
            };
            if (this.var_4421 != null)
            {
                this.var_4421.update(param1);
            };
        }

        private function getAchievedBadgeId(param1:AchievementData):String
        {
            return ((param1.finalLevel) ? param1.badgeId : this.var_4407.localization.getPreviousLevelBadgeId(param1.badgeId));
        }

        private function getPositionFix(param1:int):int
        {
            return ((this.var_4408[param1]) ? this.var_4408[param1] : 0);
        }

        public function get levelUpDialog():AchievementLevelUp
        {
            return (this.var_4421);
        }


    }
}