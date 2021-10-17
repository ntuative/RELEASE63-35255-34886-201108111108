package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetRoomSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveableRoomSettingsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.DeleteRoomMessageComposer;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveAllRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
    import com.sulake.habbo.navigator.*;

    public class RoomSettingsCtrl 
    {

        private var var_4316:Boolean;
        private var _owner:IRoomSettingsCtrlOwner;
        private var var_3465:int;
        private var _navigator:HabboNavigator;
        private var var_4317:RoomSettingsData;
        private var var_4318:int;
        private var _window:IWindowContainer;
        private var _active:Boolean;
        private var var_4319:Boolean;
        private var var_4320:Boolean;
        private var var_4321:TextFieldManager;
        private var var_4322:TextFieldManager;
        private var var_4241:TextFieldManager;
        private var var_4242:TextFieldManager;
        private var var_4323:TextFieldManager;
        private var var_4324:TextFieldManager;
        private var var_4325:ICheckBoxWindow;
        private var var_4326:ICheckBoxWindow;
        private var var_4327:ICheckBoxWindow;
        private var var_4328:ICheckBoxWindow;
        private var var_4329:ITextWindow;
        private var var_4330:IDropMenuWindow;
        private var var_4331:IDropMenuWindow;
        private var var_4332:IWindowContainer;
        private var var_4333:IWindowContainer;
        private var var_4334:IWindowContainer;
        private var var_4335:IWindowContainer;
        private var var_4336:IWindowContainer;
        private var var_4337:IWindowContainer;
        private var var_4338:IWindowContainer;
        private var var_4339:ITextWindow;

        public function RoomSettingsCtrl(param1:HabboNavigator, param2:IRoomSettingsCtrlOwner, param3:Boolean)
        {
            this._navigator = param1;
            this._owner = param2;
            this.var_4316 = param3;
        }

        public function set active(param1:Boolean):void
        {
            this._active = param1;
        }

        public function get active():Boolean
        {
            return (this._active);
        }

        public function resetView():void
        {
            this.var_4320 = false;
        }

        public function load(param1:int):void
        {
            this.var_3465 = param1;
            this._navigator.send(new GetRoomSettingsMessageComposer(this.var_3465));
            if (this.var_4338 != null)
            {
                this.var_4338.visible = false;
            };
        }

        public function onRoomSettings(param1:RoomSettingsData):void
        {
            if (param1.roomId != this.var_3465)
            {
                return;
            };
            this.var_4317 = param1;
            this._active = true;
            this.var_4319 = true;
            this._owner.roomSettingsRefreshNeeded();
        }

        public function onFlatControllerAdded(param1:int, param2:FlatControllerData):void
        {
            if (param1 != this.var_3465)
            {
                return;
            };
            if (this.var_4317 == null)
            {
                return;
            };
            if (!this.controllerExists(param2.userId))
            {
                this.var_4317.controllers.splice(0, 0, param2);
                this.var_4317.controllerCount++;
            };
            if (this.var_4320)
            {
                this._owner.roomSettingsRefreshNeeded();
            };
        }

        private function controllerExists(param1:int):Boolean
        {
            var _loc3_:FlatControllerData;
            var _loc2_:int;
            while (_loc2_ < this.var_4317.controllers.length)
            {
                _loc3_ = this.var_4317.controllers[_loc2_];
                if (_loc3_.userId == param1)
                {
                    return (true);
                };
                _loc2_++;
            };
            return (false);
        }

        public function onFlatControllerRemoved(param1:int, param2:int):void
        {
            var _loc4_:FlatControllerData;
            if (param1 != this.var_3465)
            {
                return;
            };
            if (this.var_4317 == null)
            {
                return;
            };
            this.var_4317.controllerCount--;
            var _loc3_:int;
            while (_loc3_ < this.var_4317.controllers.length)
            {
                _loc4_ = this.var_4317.controllers[_loc3_];
                if (_loc4_.userId == param2)
                {
                    this.var_4317.controllers.splice(_loc3_, 1);
                }
                else
                {
                    _loc3_++;
                };
            };
            if (this.var_4320)
            {
                this._owner.roomSettingsRefreshNeeded();
            };
        }

        public function onRoomSettingsSaved(param1:int):void
        {
            if (((!(param1 == this.var_3465)) || (this.var_4318 < 1)))
            {
                return;
            };
            this.close();
            this._owner.roomSettingsRefreshNeeded();
        }

        public function onRoomSettingsSaveError(param1:int, param2:int, param3:String):void
        {
            if (((!(param1 == this.var_3465)) || (this.var_4318 < 1)))
            {
                return;
            };
            this.var_4318 = 0;
            if (param2 == RoomSettingsSaveErrorMessageParser.var_1917)
            {
                this.var_4321.displayError("${navigator.roomsettings.roomnameismandatory}");
            }
            else
            {
                if (param2 == RoomSettingsSaveErrorMessageParser.var_1918)
                {
                    this.var_4321.displayError("${navigator.roomsettings.unacceptablewords}");
                }
                else
                {
                    if (param2 == RoomSettingsSaveErrorMessageParser.var_1919)
                    {
                        this.var_4322.displayError("${navigator.roomsettings.unacceptablewords}");
                    }
                    else
                    {
                        if (param2 == RoomSettingsSaveErrorMessageParser.var_1920)
                        {
                            this.setTagError(this.var_4241, param3, "${navigator.roomsettings.unacceptablewords}");
                            this.setTagError(this.var_4242, param3, "${navigator.roomsettings.unacceptablewords}");
                        }
                        else
                        {
                            if (param2 == RoomSettingsSaveErrorMessageParser.var_1921)
                            {
                                this.setTagError(this.var_4241, param3, "${navigator.roomsettings.nonuserchoosabletag}");
                                this.setTagError(this.var_4242, param3, "${navigator.roomsettings.nonuserchoosabletag}");
                            }
                            else
                            {
                                if (param2 == RoomSettingsSaveErrorMessageParser.var_1922)
                                {
                                    this.var_4323.displayError("${navigator.roomsettings.passwordismandatory}");
                                }
                                else
                                {
                                    this.var_4321.displayError(("Update failed: error " + param2));
                                };
                            };
                        };
                    };
                };
            };
        }

        private function setTagError(param1:TextFieldManager, param2:String, param3:String):void
        {
            if (param2 == param1.getText().toLowerCase())
            {
                param1.displayError(param3);
            };
        }

        public function close():void
        {
            this._active = false;
            this.var_3465 = 0;
            this.var_4317 = null;
            this.var_4318 = 0;
        }

        private function clearErrors():void
        {
            this.var_4321.clearErrors();
            this.var_4322.clearErrors();
            this.var_4241.clearErrors();
            this.var_4242.clearErrors();
            this.var_4323.clearErrors();
            this.var_4324.clearErrors();
        }

        private function prepareWindow(param1:IWindowContainer):void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IWindowContainer(this._navigator.getXmlWindow("ros_room_settings"));
            param1.addChildAt(this._window, 0);
            var _loc2_:IRadioButtonWindow = (this._window.findChildByName("doormode_password") as IRadioButtonWindow);
            _loc2_.addEventListener(WindowEvent.var_575, this.onDoorModePasswordSelect);
            _loc2_.addEventListener(WindowEvent.var_577, this.onDoorModePasswordUnselect);
            this.getSaveButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSaveButtonClick);
            this.getCancelButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelButtonClick);
            this.getDeleteButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onDeleteButtonClick);
            this.getEditThumbnailButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onEditThumbnailButtonClick);
            this.getRemoveAllFlatCtrlsButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRemoveAllFlatCtrlsClick);
            this.getRemoveFlatCtrlsButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRemoveFlatCtrlClick);
            this.var_4321 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("room_name")), 60);
            this.var_4322 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("description")), 0xFF);
            this.var_4241 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("tag1")), 30);
            this.var_4242 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("tag2")), 30);
            this.var_4323 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("password")), 30);
            this.var_4324 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("password_confirm")), 30);
            this.var_4325 = ICheckBoxWindow(this._window.findChildByName("allow_pets_checkbox"));
            this.var_4326 = ICheckBoxWindow(this._window.findChildByName("allow_foodconsume_checkbox"));
            this.var_4327 = ICheckBoxWindow(this._window.findChildByName("allow_walk_through_checkbox"));
            this.var_4328 = ICheckBoxWindow(this._window.findChildByName("hide_walls_checkbox"));
            this.var_4329 = (this._window.findChildByName("hide_walls_text") as ITextWindow);
            this.var_4330 = IDropMenuWindow(this._window.findChildByName("wall_thickness"));
            this.var_4331 = IDropMenuWindow(this._window.findChildByName("floor_thickness"));
            this.var_4332 = IWindowContainer(this._window.findChildByName("thumbnail_container"));
            this.var_4333 = IWindowContainer(this._window.findChildByName("basic_settings_container"));
            this.var_4334 = IWindowContainer(this._window.findChildByName("advanced_settings_container"));
            this.var_4335 = IWindowContainer(this._window.findChildByName("switch_view_container"));
            this.var_4336 = IWindowContainer(this._window.findChildByName("footer_container"));
            this.var_4337 = IWindowContainer(this._window.findChildByName("flat_controllers_container"));
            this.var_4338 = IWindowContainer(this._window.findChildByName("password_container"));
            this.var_4339 = ITextWindow(this._window.findChildByName("switch_view_text"));
            this.var_4339.mouseThreshold = 0;
            this.var_4339.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSwitchView);
            this.var_4338.visible = false;
            if (!this.var_4316)
            {
                this._window.color = 0xFFFFFFFF;
                Util.setColors(this._window, 0xFF000000);
            };
        }

        private function getSaveButton():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("save")));
        }

        private function getCancelButton():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("cancel")));
        }

        private function getDeleteButton():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("delete")));
        }

        private function getEditThumbnailButton():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("edit_thumbnail")));
        }

        private function getRemoveAllFlatCtrlsButton():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("remove_all_flat_ctrls")));
        }

        private function getRemoveFlatCtrlsButton():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("remove_flat_ctrl")));
        }

        public function refresh(param1:IWindowContainer):void
        {
            if (!this._active)
            {
                return;
            };
            this.prepareWindow(param1);
            Util.hideChildren(this._window);
            this.var_4335.visible = this.var_4316;
            this.populateForm();
            if (this.var_4320)
            {
                this.var_4334.visible = true;
                this.var_4336.visible = true;
                this.refreshFlatControllers();
                this.var_4334.height = (Util.getLowestPoint(this.var_4334) + 4);
            }
            else
            {
                this.var_4333.visible = true;
                this.var_4336.visible = true;
                this.var_4332.visible = this.var_4316;
                this.var_4333.height = (Util.getLowestPoint(this.var_4333) + 4);
            };
            this.var_4339.text = ((this.var_4320) ? "${navigator.roomsettings.tobasicsettings}" : "${navigator.roomsettings.toadvancedsettings}");
            Util.moveChildrenToColumn(this._window, [this.var_4333.name, this.var_4334.name, this.var_4336.name, this.var_4335.name], 0, 0);
            this._window.height = (Util.getLowestPoint(this._window) + 4);
            this._window.visible = true;
        }

        private function disableWindow(param1:IWindow):void
        {
            if (param1 != null)
            {
                param1.disable();
                param1.blend = 0.5;
            };
        }

        private function enableWindow(param1:IWindow):void
        {
            if (param1 != null)
            {
                param1.enable();
                param1.blend = 1;
            };
        }

        private function getThicknessSelectionIndex(param1:int):int
        {
            switch (param1)
            {
                case -2:
                    return (0);
                case -1:
                    return (1);
                case 1:
                    return (3);
                default:
                    return (2);
            };
        }

        private function populateForm():void
        {
            var _loc4_:IRadioButtonWindow;
            var _loc5_:IRadioButtonWindow;
            if (!this.var_4319)
            {
                return;
            };
            this.var_4319 = false;
            var _loc1_:RoomSettingsData = this.var_4317;
            this.var_4321.setText(_loc1_.name);
            this.var_4322.setText(_loc1_.description);
            this.var_4323.setText("");
            this.var_4324.setText("");
            var _loc2_:ISelectorWindow = (this._window.findChildByName("doormode") as ISelectorWindow);
            var _loc3_:IRadioButtonWindow = (this._window.findChildByName("doormode_password") as IRadioButtonWindow);
            switch (_loc1_.doorMode)
            {
                case RoomSettingsData.var_939:
                    _loc4_ = (this._window.findChildByName("doormode_doorbell") as IRadioButtonWindow);
                    _loc2_.setSelected(_loc4_);
                    break;
                case RoomSettingsData.var_940:
                    _loc2_.setSelected(_loc3_);
                    break;
                default:
                    _loc5_ = (this._window.findChildByName("doormode_open") as IRadioButtonWindow);
                    _loc2_.setSelected(_loc5_);
            };
            this.changePasswordField((_loc1_.doorMode == RoomSettingsData.var_940));
            Logger.log(("CATEGORY ID: " + _loc1_.categoryId));
            this.setCategorySelection(_loc1_.categoryId);
            this.refreshMaxVisitors(_loc1_);
            this.setTag(this.var_4241, _loc1_.tags[0]);
            this.setTag(this.var_4242, _loc1_.tags[1]);
            if (this.var_4325)
            {
                if (_loc1_.allowPets)
                {
                    this.var_4325.select();
                }
                else
                {
                    this.var_4325.unselect();
                };
            };
            if (this.var_4326)
            {
                if (_loc1_.allowFoodConsume)
                {
                    this.var_4326.select();
                }
                else
                {
                    this.var_4326.unselect();
                };
            };
            if (this.var_4327)
            {
                if (_loc1_.allowWalkThrough)
                {
                    this.var_4327.select();
                }
                else
                {
                    this.var_4327.unselect();
                };
            };
            if (!this.VIPFeaturesAllowed())
            {
                this.disableWindow(this.var_4328);
                this.disableWindow(this.var_4330);
                this.disableWindow(this.var_4331);
                this.disableWindow(this.var_4329);
            }
            else
            {
                this.enableWindow(this.var_4328);
                this.enableWindow(this.var_4330);
                this.enableWindow(this.var_4331);
                this.enableWindow(this.var_4329);
            };
            if (this.var_4328)
            {
                if (_loc1_.hideWalls)
                {
                    this.var_4328.select();
                }
                else
                {
                    this.var_4328.unselect();
                };
            };
            if (this.var_4330)
            {
                this.var_4330.selection = this.getThicknessSelectionIndex(_loc1_.wallThickness);
            };
            if (this.var_4331)
            {
                this.var_4331.selection = this.getThicknessSelectionIndex(_loc1_.floorThickness);
            };
            this.clearErrors();
        }

        private function VIPFeaturesAllowed():Boolean
        {
            return (this._navigator.sessionData.hasUserRight("fuse_hide_room_walls", HabboClubLevelEnum.var_114));
        }

        private function setTag(param1:TextFieldManager, param2:String):void
        {
            param1.setText(((param2 == null) ? "" : param2));
        }

        private function refreshMaxVisitors(param1:RoomSettingsData):void
        {
            var _loc2_:Array = new Array();
            var _loc3_:int = -1;
            var _loc4_:int;
            var _loc5_:int = 10;
            while (_loc5_ <= param1.maximumVisitorsLimit)
            {
                _loc2_.push(("" + _loc5_));
                if (_loc5_ == param1.maximumVisitors)
                {
                    _loc3_ = _loc4_;
                };
                _loc4_++;
                _loc5_ = (_loc5_ + 5);
            };
            var _loc6_:IDropMenuWindow = (this._window.findChildByName("maxvisitors") as IDropMenuWindow);
            _loc6_.populate(_loc2_);
            _loc6_.selection = ((_loc3_ > -1) ? _loc3_ : 0);
        }

        private function setCategorySelection(param1:int):void
        {
            var _loc6_:FlatCategory;
            var _loc2_:IDropMenuWindow = (this._window.findChildByName("categories") as IDropMenuWindow);
            var _loc3_:Array = new Array();
            var _loc4_:int;
            var _loc5_:int;
            for each (_loc6_ in this._navigator.data.allCategories)
            {
                if (((_loc6_.visible) || (param1 == _loc6_.nodeId)))
                {
                    _loc3_.push(_loc6_.nodeName);
                    if (param1 == _loc6_.nodeId)
                    {
                        _loc4_ = _loc5_;
                    };
                    _loc5_++;
                };
            };
            _loc2_.populate(_loc3_);
            _loc2_.selection = _loc4_;
        }

        private function getFlatCategoryByIndex(param1:int, param2:int):FlatCategory
        {
            var _loc4_:FlatCategory;
            var _loc3_:int;
            for each (_loc4_ in this._navigator.data.allCategories)
            {
                if (((_loc4_.visible) || (param1 == _loc4_.nodeId)))
                {
                    if (param2 == _loc3_)
                    {
                        return (_loc4_);
                    };
                    _loc3_++;
                };
            };
            return (null);
        }

        private function onEditThumbnailButtonClick(param1:WindowMouseEvent):void
        {
            this._navigator.roomInfoViewCtrl.startThumbnailEdit();
        }

        private function onSwitchView(param1:WindowEvent):void
        {
            this.var_4320 = (!(this.var_4320));
            this._owner.roomSettingsRefreshNeeded();
        }

        private function onSaveButtonClick(param1:WindowMouseEvent):void
        {
            var _loc8_:String;
            var _loc9_:String;
            if ((((this.var_4317 == null) || (this._window == null)) || (this._window.disposed)))
            {
                return;
            };
            var _loc2_:SaveableRoomSettingsData = new SaveableRoomSettingsData();
            _loc2_.roomId = this.var_4317.roomId;
            _loc2_.name = this.var_4321.getText();
            _loc2_.description = this.var_4322.getText();
            var _loc3_:ISelectorWindow = (this._window.findChildByName("doormode") as ISelectorWindow);
            var _loc4_:IWindow = _loc3_.getSelected();
            switch (_loc4_.name)
            {
                case "doormode_doorbell":
                    _loc2_.doorMode = RoomSettingsFlatInfo.var_939;
                    break;
                case "doormode_password":
                    _loc2_.doorMode = RoomSettingsFlatInfo.var_940;
                    break;
                default:
                    _loc2_.doorMode = RoomSettingsFlatInfo.var_1914;
            };
            if (_loc2_.doorMode == RoomSettingsFlatInfo.var_940)
            {
                _loc8_ = this.var_4323.getText();
                _loc9_ = this.var_4324.getText();
                if (_loc8_ != _loc9_)
                {
                    this.var_4323.clearErrors();
                    this.var_4324.displayError("${navigator.roomsettings.invalidconfirm}");
                    return;
                };
                if (_loc8_ != "")
                {
                    _loc2_.password = _loc8_;
                };
            };
            var _loc5_:IDropMenuWindow = (this._window.findChildByName("categories") as IDropMenuWindow);
            var _loc6_:FlatCategory = this.getFlatCategoryByIndex(this.var_4317.categoryId, _loc5_.selection);
            _loc2_.categoryId = _loc6_.nodeId;
            var _loc7_:IDropMenuWindow = (this._window.findChildByName("maxvisitors") as IDropMenuWindow);
            _loc2_.maximumVisitors = (10 + (_loc7_.selection * 5));
            _loc2_.allowPets = this.var_4325.isSelected;
            _loc2_.allowFoodConsume = this.var_4326.isSelected;
            _loc2_.allowWalkThrough = this.var_4327.isSelected;
            _loc2_.hideWalls = this.var_4328.isSelected;
            _loc2_.wallThickness = (this.var_4330.selection - 2);
            _loc2_.floorThickness = (this.var_4331.selection - 2);
            _loc2_.tags = new Array();
            this.addTag(this.var_4241, _loc2_.tags);
            this.addTag(this.var_4242, _loc2_.tags);
            this.clearErrors();
            this.var_4318 = _loc2_.roomId;
            this._navigator.send(new SaveRoomSettingsMessageComposer(_loc2_));
        }

        private function addTag(param1:TextFieldManager, param2:Array):void
        {
            if (param1.getText() != "")
            {
                param2.push(param1.getText());
            };
        }

        private function onCancelButtonClick(param1:WindowMouseEvent):void
        {
            this.close();
            this._owner.roomSettingsRefreshNeeded();
        }

        private function onDeleteButtonClick(param1:WindowMouseEvent):void
        {
            Logger.log(("[RoomSettingsCtrl.onDeleteButtonClick] " + this.var_3465));
            if (this.var_4317 == null)
            {
                return;
            };
            this._navigator.registerParameter("navigator.roomsettings.deleteroom.confirm.message", "room_name", this.var_4317.name);
            var _loc2_:ConfirmDialogView = new ConfirmDialogView(IFrameWindow(this._navigator.getXmlWindow("ros_room_delete_confirm")), this, this.onConfirmRoomDelete, [this.var_3465]);
            _loc2_.show();
        }

        private function onConfirmRoomDelete(param1:WindowMouseEvent, param2:int):void
        {
            var _loc3_:GuestRoomSearchResultData;
            this._navigator.send(new DeleteRoomMessageComposer(param2));
            this.close();
            this._owner.roomSettingsRefreshNeeded();
            if (this._navigator.data.guestRoomSearchResults != null)
            {
                _loc3_ = this._navigator.data.guestRoomSearchResults;
                this._navigator.mainViewCtrl.startSearch(this._navigator.tabs.getSelected().id, _loc3_.searchType, _loc3_.searchParam);
            };
        }

        private function onDoorModePasswordSelect(param1:WindowEvent):void
        {
            this.changePasswordField(true);
        }

        private function onDoorModePasswordUnselect(param1:WindowEvent):void
        {
            this.changePasswordField(false);
        }

        private function changePasswordField(param1:Boolean):void
        {
            this.var_4338.visible = param1;
            this._owner.roomSettingsRefreshNeeded();
        }

        private function refreshFlatControllers():void
        {
            var _loc5_:IWindow;
            var _loc6_:IWindow;
            var _loc7_:IWindowContainer;
            var _loc8_:Boolean;
            var _loc9_:int;
            var _loc10_:FlatControllerData;
            if (((this.var_4337 == null) || (this.var_4337.disposed)))
            {
                return;
            };
            Util.hideChildren(this.var_4337);
            var _loc1_:IWindow = this.var_4337.findChildByName("ruler");
            if (_loc1_ != null)
            {
                _loc1_.visible = true;
            };
            var _loc2_:IWindow = this.var_4337.findChildByName("flat_ctrls_caption_txt");
            if (_loc2_ != null)
            {
                this._navigator.registerParameter("navigator.roomsettings.flatctrls.caption", "cnt", ("" + this.var_4317.controllerCount));
                _loc2_.visible = true;
            };
            var _loc3_:IWindowContainer = IWindowContainer(this.var_4337.findChildByName("flat_controller_list"));
            if (_loc3_ != null)
            {
                Util.hideChildren(_loc3_);
                if (this.var_4317 != null)
                {
                    _loc8_ = false;
                    _loc9_ = 0;
                    while (_loc9_ < this.var_4317.controllers.length)
                    {
                        _loc10_ = this.var_4317.controllers[_loc9_];
                        this.refreshFlatController(_loc3_, _loc9_, _loc10_);
                        if (_loc10_.selected)
                        {
                            _loc8_ = true;
                        };
                        _loc9_++;
                    };
                };
                Util.layoutChildrenInArea(_loc3_, _loc3_.width, 15);
                _loc3_.height = Util.getLowestPoint(_loc3_);
                _loc5_ = this.var_4337.findChildByName("flat_ctrls_info_txt");
                _loc6_ = this.var_4337.findChildByName("flat_ctrls_limit_txt");
                _loc7_ = IWindowContainer(this.var_4337.findChildByName("flat_controllers_footer"));
                if (((!(this.var_4317 == null)) && (this.var_4317.controllers.length > 0)))
                {
                    _loc3_.visible = true;
                    _loc7_.visible = true;
                    _loc5_.visible = true;
                    if (this.var_4317.controllerCount > this.var_4317.controllers.length)
                    {
                        this._navigator.registerParameter("navigator.roomsettings.flatctrls.limitinfo", "cnt", ("" + this.var_4317.controllers.length));
                        _loc6_.visible = true;
                    };
                    Util.moveChildrenToColumn(this.var_4337, ["flat_ctrls_caption_txt", "flat_ctrls_limit_txt", "flat_controller_list", "flat_ctrls_info_txt", "flat_controllers_footer"], _loc2_.y, 5);
                }
                else
                {
                    _loc7_.visible = false;
                    _loc5_.visible = false;
                    _loc7_.y = ((_loc3_.y + _loc3_.height) + 5);
                };
            };
            var _loc4_:IButtonWindow = IButtonWindow(this.var_4337.findChildByName("remove_flat_ctrl"));
            if (_loc4_ != null)
            {
                if (_loc8_)
                {
                    _loc4_.enable();
                }
                else
                {
                    _loc4_.disable();
                };
            };
            this.var_4337.height = Util.getLowestPoint(this.var_4337);
        }

        private function refreshFlatController(param1:IWindowContainer, param2:int, param3:FlatControllerData):void
        {
            var _loc6_:ITextWindow;
            var _loc4_:String = ("fc." + param2);
            var _loc5_:IWindowContainer = IWindowContainer(param1.getChildByName(_loc4_));
            if (param3 == null)
            {
                if (_loc5_ != null)
                {
                    _loc5_.visible = false;
                };
            }
            else
            {
                if (_loc5_ == null)
                {
                    _loc5_ = this.getFlatControllerContainer(_loc4_);
                    param1.addChild(_loc5_);
                    _loc5_.addChild(this._navigator.getXmlWindow("ros_flat_controller"));
                };
                _loc6_ = ITextWindow(_loc5_.findChildByName("flat_controller"));
                _loc6_.text = param3.userName;
                _loc6_.id = param3.userId;
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onFlatControllerClick);
                _loc6_.width = (_loc6_.textWidth + 5);
                _loc5_.width = (_loc6_.width + 3);
                _loc5_.height = _loc6_.height;
                _loc6_.color = ((param3.selected) ? 0xFFFFFFFF : 4286216826);
                Logger.log(((((("HUMP: " + param3.userName) + ", ") + param3.selected) + ", ") + _loc6_.textBackgroundColor));
                _loc5_.visible = true;
            };
        }

        private function getFlatControllerContainer(param1:String):IWindowContainer
        {
            return (IWindowContainer(this._navigator.windowManager.createWindow(param1, "", HabboWindowType.var_218, HabboWindowStyle.var_613, HabboWindowParam.var_159, new Rectangle(0, 0, 100, 20))));
        }

        private function onFlatControllerClick(param1:WindowEvent):void
        {
            var _loc2_:ITextWindow = ITextWindow(param1.target);
            var _loc3_:int = _loc2_.id;
            Logger.log(((("FC clicked: " + _loc2_.name) + ", ") + _loc3_));
            var _loc4_:FlatControllerData = this.getFlatCtrl(_loc3_);
            if (_loc4_ == null)
            {
                Logger.log(("Couldn't find fc: " + _loc3_));
                return;
            };
            _loc4_.selected = (!(_loc4_.selected));
            this._owner.roomSettingsRefreshNeeded();
        }

        private function getFlatCtrl(param1:int):FlatControllerData
        {
            var _loc2_:FlatControllerData;
            if (this.var_4317 != null)
            {
                for each (_loc2_ in this.var_4317.controllers)
                {
                    if (_loc2_.userId == param1)
                    {
                        return (_loc2_);
                    };
                };
            };
            return (null);
        }

        private function onRemoveAllFlatCtrlsClick(param1:WindowEvent):void
        {
            Logger.log("Remove all clicked: ");
            this._navigator.send(new RemoveAllRightsMessageComposer(this.var_3465));
        }

        private function onRemoveFlatCtrlClick(param1:WindowEvent):void
        {
            var _loc3_:FlatControllerData;
            var _loc4_:RemoveRightsMessageComposer;
            Logger.log("Remove clicked: ");
            if (this.var_4317 == null)
            {
                return;
            };
            var _loc2_:Array = new Array();
            for each (_loc3_ in this.var_4317.controllers)
            {
                if (_loc3_.selected)
                {
                    _loc2_.push(_loc3_.userId);
                };
            };
            _loc4_ = new RemoveRightsMessageComposer(_loc2_);
            this._navigator.send(_loc4_);
        }


    }
}