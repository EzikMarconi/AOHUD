//for load config
key notecard_key = NULL_KEY;
integer iLine = 0;
key kQuery;

SetOverride(string from, string to)
{
     //ToDo check "from" to correct animation state
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
        llRequestPermissions(llGetOwner() , PERMISSION_OVERRIDE_ANIMATIONS |  PERMISSION_TRIGGER_ANIMATION);
    }
    run_time_permissions(integer perm)
    {
        if (perm & (PERMISSION_TRIGGER_ANIMATION | PERMISSION_OVERRIDE_ANIMATIONS))
        {
            llOwnerSay("loading notecard");
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
                llOwnerSay("Finished reading configuration.");
            }
            else
            {            
                if(llGetSubString(data, 0, 0)!="#")    
                {
                llOwnerSay("Read notecard line: " + data);
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