function [minind,mindist]=checkknn(trainingset1,kn)
var1=size(trainingset1);
    mindist=9999*ones(var1(1),kn);
    minind=zeros(var1(1),kn);
for i=1:1:var1(1)
    for j=1:1:var1(1)
        if j==i
            continue;
        end
        xx=[trainingset1(i,:);trainingset1(j,:)];
        d = pdist(xx,'euclidean');
        %d = sum(abs(trainingset1(i,:)-trainingset1(j,:)));
        kk=0;
        for k=kn:-1:1
             if d<mindist(i,k)
                 kk=k;
             else
                 break;
             end
        end
        
        if kk~=0
            
            for jj=kn:-1:kk+1
                mindist(i,jj)=mindist(i,jj-1);
                minind(i,jj)=minind(i,jj-1);
            end
            mindist(i,kk)=d;
            minind(i,kk)=j;
        end
    end
end
     
end         
             
%{

%}
