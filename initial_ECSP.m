function [bs_loc,power_B,bid,cpi_B] = initial_BS
global f_i ntfg l_i ow

bs_ID=1;
bs_loc = [150,75];
power_B = 20;
bid = [100,100,100,100,100];
cpi_B = 30;
radius=200; % coverage, m
content; % caching space

%% 
f_i = -1.007173642425937e+03;
ntfg = 1100;
l_i = 6.13e+03 ;
ow = 6000;


function obj=bs(ID,position,radius,contentSize)
    obj.bs_ID=ID;
    obj.position=bs_loc;
    obj.radius=radius;
    obj.content=cell(contentSize,1);
end

function obj=updateContent(obj,content)
    % update storage with content
    if length(obj.content)<length(content)
        disp('Cannot update content due to storage overflow.');
    else
        obj.content=content;
    end
end

function sendSignal(obj,signal)
    communicationNetwork=getCommunicationNetwork();
    communicationNetwork.send(obj,signal);
end

function [message,sender]=receiveSignal(obj)
    message=communicationNetwork.receive(obj);
    sender=message.sender;
end

end