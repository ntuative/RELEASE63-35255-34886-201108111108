package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.Friend;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveBuddyMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class FriendRemoveView extends AlertView 
    {

        private var _selected:Array;

        public function FriendRemoveView(param1:HabboFriendList)
        {
            super(param1, "friend_remove_confirm");
            this._selected = param1.categories.getSelectedFriends();
        }

        override public function dispose():void
        {
            this._selected = null;
            super.dispose();
        }

        override internal function setupContent(param1:IWindowContainer):void
        {
            var _loc3_:Friend;
            var _loc4_:String;
            var _loc5_:Dictionary;
            param1.findChildByName("cancel").procedure = onClose;
            param1.findChildByName("ok").procedure = this.onRemove;
            var _loc2_:Array = new Array();
            for each (_loc3_ in this._selected)
            {
                _loc2_.push(_loc3_.name);
            };
            _loc4_ = Util.arrayToString(_loc2_);
            _loc5_ = new Dictionary();
            friendList.registerParameter("friendlist.removefriendconfirm.userlist", "user_names", _loc4_);
        }

        private function onRemove(param1:WindowEvent, param2:IWindow):void
        {
            var _loc4_:Friend;
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Remove Ok clicked");
            var _loc3_:RemoveBuddyMessageComposer = new RemoveBuddyMessageComposer();
            for each (_loc4_ in this._selected)
            {
                _loc3_.addRemovedFriend(_loc4_.id);
            };
            friendList.send(_loc3_);
            this.dispose();
        }


    }
}