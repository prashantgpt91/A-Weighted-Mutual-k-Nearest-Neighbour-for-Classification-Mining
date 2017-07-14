 function [accarr certarr]=main1(kk)
ordata=load('ilpd1.txt');                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%        CHANGE
sizedata=size(ordata);
noofclass=2;                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         CHANGE
k=kk;
accofknn=0;
accofwknn=0;
accofknnst=0;
accofmknn=0;
accofwmknn=0;
accofwknnstar=0;
certainityknn=0;
certainitywknn=0;
certainityknnst=0;
certainitywknnst=0;
certainitymknn=0;
certainitywmknn=0;

%%breaking of testsets & traningsets 10 fold

for iif=1:10
    iif;
    data=ordata;
    sd=size(data);
    
    meandata=mean(data(:,[1:sd(2)-1]));          %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE
    stddata=std(data(:,[1:sd(2)-1]));            %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE
    for i=1:sd(2)-1                              %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE
        for j=1:sd(1)
            data(j,i)=((data(j,i)-meandata(i))/stddata(i));              %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE
        end
    end
    %data;
   
    [testdata,trainingdata]=breaktesttraining(iif,data);
    
%%%%%%%%%%%%%%%     elimination of zeros in trainingset

trainingdata=eliminatezero(trainingdata);
size_testdata=size(testdata);
size_trainingdata=size(trainingdata);

testset=testdata(:,[1:size_testdata(2)-1]);                           %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE
testlabel=testdata(:,size_testdata(2));                                            %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE
trainingset=trainingdata(:,[1:size_trainingdata(2)-1]);               %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE
traininglabel=trainingdata(:,size_testdata(2));                                        %%%%%%%%%%%%%%%%%%%%%%%%%      CHANGE

%%%%%%%%%%%%%     knn application
[minind1 , mindist1]=obtain_sort_dist_ind(trainingset,testset,k);
resultofknn=zeros(size_testdata(1),k);
for i=1:size_testdata(1)
    for j=1:k   
           resultofknn(i,j)=traininglabel(minind1(i,j),:);
   end
end
resultofknn;

%%%%%%%%%%%%%%  prediction of class using classlabels of knn

fresultofknn=class_predicton(noofclass,k,resultofknn);

%%%%%%%%%%%%% acc of knn

c=0;
for j=1:size_testdata(1)
     if fresultofknn(j,:)==testlabel(j,:)
        c=c+1;
    end
end
accofknn=accofknn+(c/(size_testdata(1)))*100;

%%%%%%%%%%%%%  certainity of knn

certainityknn=certainityknn+certainity(fresultofknn,resultofknn,mindist1,noofclass,k);

%%%%%%%%%%%%%%%%%%  wknn application

resultofwknn=classusingarray(resultofknn,mindist1,k,noofclass);

%%%%%%%%%%%% acc of wknn
c=0;
for j=1:size_testdata(1)
     if resultofwknn(j,:)==testlabel(j,:)
        c=c+1;
    end
end
accofwknn=accofwknn+(c/(size_testdata(1)))*100;

%%%%%%%%%%%%%  certainity of wknn

certainitywknn=certainitywknn+certainity(resultofwknn,resultofknn,mindist1,noofclass,k);

%%%%%%%%%%%%%%%%%   removing noises from traning set  and appl. of mknn and knnst.


[minind,mindist]=checkknn(trainingset,k);
tempind=minind;
tempdist=mindist;
[trainingset,traininglabel]=makenoisezero(minind,trainingset,traininglabel);
trainingdata=[trainingset traininglabel];
trainingdata=eliminatezero(trainingdata);
size_trainingdata=size(trainingdata);
trainingset=trainingdata(:,[1:size_trainingdata(2)-1]);
traininglabel=trainingdata(:,size_trainingdata(2));

%%%%%%%%%%%%%%%%%%%%%%%     appl. of knnstar.

[minind1 , mindist1]=obtain_sort_dist_ind(trainingset,testset,k);
resultofknnst=zeros(size_testdata(1),k);
for i=1:size_testdata(1)
    for j=1:k   
           resultofknnst(i,j)=traininglabel(minind1(i,j),:);
   end
end

resultofknnst;

%%%%%%%% final class prediction for knnstar

fresultofknnst=class_predicton(noofclass,k,resultofknnst);

%%%%%%%%%%%%%%%%%%%%%%     accuracy of knnstar.

c=0; 
for j=1:size_testdata(1)
     if fresultofknnst(j,:)==testlabel(j,:)
        c=c+1;
    end
end
accofknnst=accofknnst+(c/(size_testdata(1)))*100;

%%%%%%%%%%%%%  certainity of knnst

certainityknnst=certainityknnst+certainity(fresultofknnst,resultofknnst,mindist1,noofclass,k);

%%%%%%%%%%%%%%%%%%  wknnstar application

resultofwknnst=classusingarray(resultofknnst,mindist1,k,noofclass);

%%%%%%%%%%%% acc of wknnst
c=0;
for j=1:size_testdata(1)
     if resultofwknnst(j,:)==testlabel(j,:)
        c=c+1;
    end
end
accofwknnstar=accofwknnstar+(c/(size_testdata(1)))*100;

%%%%%%%%%%%%%  certainity of wknnst

certainitywknnst=certainitywknnst+certainity(resultofwknnst,resultofknnst,mindist1,noofclass,k);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  mknn using minind1 & mindist1(finding mknns)

%[minind,mindist]=checkknn(trainingset,k);    
minind=tempind;
mindist=tempdist;
resultofmknn=zeros(size_testdata(1),k);
for i=1:size_testdata(1)
    for j=1:k
        xx=[trainingset(minind1(i,j),:);testset(i,:)];
        d = pdist(xx,'euclidean');
        %%%%%d = sum(abs(trainingset(minindtest(i,j),:)-testset(i,:)));
        if d<=mindist(minind1(i,j),k)
            resultofmknn(i,j)=traininglabel(minind1(i,j),:);
        else
            resultofmknn(i,j)=0;
        end
    end
end
resultofmknn;

%%%%%%%%%%%%%%%%%%%%  final class of mknn

fresultofmknn=class_predicton(noofclass,k,resultofmknn);

%%%%%%%%%  accuracy of mknn
c=0;cc=0;
for i=1:size_testdata(1)
    if fresultofmknn(i,:)==0
        cc=cc+1;
    else if fresultofmknn(i,:)==testlabel(i,:)
        c=c+1;
        end
    end
end

accofmknn=accofmknn+(c/(size_testdata(1)-cc))*100;

%%%%%%%%%%%%%  certainity of mknn

certainitymknn=certainitymknn+certainity(fresultofmknn,resultofmknn,mindist1,noofclass,k);

%%%%%%%%%%%%%  wmknn

fresultofwmknn=classusingarray(resultofmknn,mindist1,k,noofclass);

%%%%%%%%%%%%%%%%% accuracy of wmknn
c=0;cc=0;
for i=1:size_testdata(1)
    if fresultofwmknn(i,:)==0
        cc=cc+1;
    else if fresultofwmknn(i,:)==testlabel(i,:)
        c=c+1;
        end
    end
end
accofwmknn=accofwmknn+(c/(size_testdata(1)-cc))*100;

%%%%%%%%%%%%%  certainity of wmknn

certainitywmknn=certainitywmknn+certainity(fresultofwmknn,resultofmknn,mindist1,noofclass,k);

end 
accarr=zeros(6,1);
certarr=zeros(6,1);
accofknn=accofknn/10;
accarr(1,1)=accofknn;
certainityknn=certainityknn/10;
certarr(1,1)=certainityknn;
accofwknn=accofwknn/10;
accarr(2,1)=accofwknn;
certainitywknn=certainitywknn/10;
certarr(2,1)=certainitywknn;
accofknnst=accofknnst/10;
accarr(3,1)=accofknnst;
certainityknnst=certainityknnst/10;
certarr(3,1)=certainityknnst;
accofwknnstar=accofwknnstar/10;
accarr(4,1)=accofwknnstar;
certainitywknnst=certainitywknnst/10;
certarr(4,1)=certainitywknnst;
accofmknn=accofmknn/10;
accarr(5,1)=accofmknn;
certainitymknn=certainitymknn/10;
certarr(5,1)=certainitymknn;
accofwmknn=accofwmknn/10;
accarr(6,1)=accofwmknn;
certainitywmknn=certainitywmknn/10;
certarr(6,1)=certainitywmknn;
end