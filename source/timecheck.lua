
timeChk_samples={}
timeChk_prev=0
timeChk_done=false
TIMECHK_COUNT=10

function timeChk()
    if timeChk_done then
        return
    end
    if #timeChk_samples<TIMECHK_COUNT then
        local curr=time()
        if timeChk_prev>0 then
            table.insert(timeChk_samples,curr-timeChk_prev)
        end
        timeChk_prev=curr
    else
        local total=0
        for i=1,#timeChk_samples do 
            total=total+timeChk_samples[i]
        end
        if total/TIMECHK_COUNT<10 then
            trace("Incompatible time() function")
            trace("Please use dev build on Mac/Linux")
            exit()
        end
        timeChk_done=true
    end
end