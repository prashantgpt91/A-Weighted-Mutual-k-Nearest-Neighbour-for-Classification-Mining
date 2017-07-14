function [fresult]=class_predicton(noofclass,k,labels)
size_testdata=size(labels);
finalclass=zeros(size_testdata(1),1);
for i=1:size_testdata(1)
    final=zeros(2,noofclass);                   %%%%%%%%%%% 7 is no. of different classes
    for j=1:k
        if labels(i,j)~=0
        final(1,labels(i,j))=final(1,labels(i,j))+1;
        if final(2,labels(i,j))==0
            final(2,labels(i,j))=j;
        end
        end
    end
    final;
    max=0;maxi=k+1;maxc=0;
    
    for j=1:noofclass
        if final(1,j)>max
            max=final(1,j);
            maxc=j;
            maxi=final(2,j);
        else if final(1,j)==max && final(2,j)<maxi && final(1,j)~=0
                max=final(1,j);
                maxc=j;
                maxi=final(2,j);
            end
        end
    end
    finalclass(i,1)=maxc;
end

fresult=finalclass;
end