function [ THs ] = getThStats(CINsfile,V0,dt,use_single_exponential, lut1,lut2, nGroup,datafolder)

if ~exist('datafolder','var')
    datafolder = pwd;
end

timedLog('getting Th stats...');

load (CINsfile,'NumCINs','CINs','Labels');
N = NumCINs;
th = zeros(1,N);

for i = 1:N
    
    CIN = CINs{i};
    
    ts = CIN(:,1);
    [ V ]= edInteg (ts,V0,dt,use_single_exponential,lut1,lut2);

    th(i) = max(V);
end


THs = zeros(1,nGroup);
for i = 1:nGroup
    ind = Labels == i-1;
    THs(i) = min(th(ind))*0.3;
end

save ([datafolder,'/','THs'], 'THs')

    