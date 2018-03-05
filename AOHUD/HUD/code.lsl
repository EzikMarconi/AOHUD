//for load config
key notecard_key = NULL_KEY;
integer iLine = 0;
key kQuery;
list correct_override=["Crouching","CrouchWalking","Falling Down","Flying","FlyingSlow","Hovering","Hovering Down",
    "Hovering Up","Jumping","Landing","PreJumping","Running","Sitting","Sitting on Ground","Standing","Standing Up",
    "Striding","Soft Landing","Taking Off","Turning Left","Turning Right","Walking"];

SetOverride(string from, string to)
{
    integer index = llListFindList(correct_override,[from]);
    if (index == -1)
    {
        llOwnerSay("Error: "+from+" animation state to be overriden not found");
        return;
    }
    llSetAnimationOverride( from, to);
}

default
{
    on_rez(integer start_param)
    {
        llResetScript();
    }
    state_entry()
    {
        llSetColor(<1.0, 1.0, 1.0>,ALL_SIDES);

        integer perm = llGetPermissions();
        if (perm & (PERMISSION_TRIGGER_ANIMATION | PERMISSION_OVERRIDE_ANIMATIONS))
        {
            key note = llGetInventoryKey("config.txt");
            notecard_key = note;
            iLine = 0;
            kQuery = llGetNotecardLine("config.txt", iLine);

        } else
        {
            llRequestPermissions(llGetOwner() , PERMISSION_OVERRIDE_ANIMATIONS |  PERMISSION_TRIGGER_ANIMATION);
        }
    }
    touch_start(integer a)
    {
        integer perm = llGetPermissions();
        if (perm & (PERMISSION_TRIGGER_ANIMATION | PERMISSION_OVERRIDE_ANIMATIONS))
        {
            state work;
        } else
    {
        llRequestPermissions(llGetOwner() , PERMISSION_OVERRIDE_ANIMATIONS |  PERMISSION_TRIGGER_ANIMATION);
    }

    }
    run_time_permissions(integer perm)
    {
        if (perm & (PERMISSION_TRIGGER_ANIMATION | PERMISSION_OVERRIDE_ANIMATIONS))
        {
            llResetAnimationOverride("ALL");
            key note = llGetInventoryKey("config.txt");
            if (note == notecard_key)
            {
                return;
            }

            notecard_key = note;
            iLine = 0;
            kQuery = llGetNotecardLine("config.txt", iLine);
        }
    }
    dataserver(key query_id, string data)
    {
        if (query_id == kQuery)
        {
            if (data == EOF)
            {
                //llOwnerSay("Finished reading configuration.");
                state work;
            }
            else
            {
                if(llGetSubString(data, 0, 0)!="#")
                {
                    list over=llParseString2List(data,[";"],[]);
                    if(llGetListLength(over)==2)
                    {
                        SetOverride(llList2String(over, 0),llList2String(over, 1));
                    } else {
                            llOwnerSay("Config error. Line:"+(string)iLine);
                    }

                }
                ++iLine;
                kQuery = llGetNotecardLine("config.txt", iLine);
            }
        }
    }
}
state hold
{
    on_rez(integer start_param)
    {
        llResetScript();
    }
    attach(key attached)
    {
        llResetScript();
    }
    state_entry()
    {
        llResetAnimationOverride("ALL");
        llSetColor(<1.0, 0.0, 0.0>,ALL_SIDES);
    }
    touch_start(integer a)
    {
        state default;
    }
}

state work
{
    on_rez(integer start_param)
    {
        llResetScript();
    }
    attach(key attached)
    {
        llResetScript();
    }
    state_entry()
    {
        llSetColor(<0.0, 1.0, 0.0>,ALL_SIDES);
    }
    touch_start(integer a)
    {
        state hold;
    }

}