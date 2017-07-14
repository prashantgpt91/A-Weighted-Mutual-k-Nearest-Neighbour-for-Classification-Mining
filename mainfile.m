ar=zeros(6,5);
cr=zeros(6,5);
i=1;
for kk=3:7
   [ar(:,i) cr(:,i)]=main1(kk)
   
    i=i+1;
    
end

ar

 
%{
  plot([3,4,5,6,7],cr(1,:),'-or')
 hold on;
 plot([3,4,5,6,7],cr(2,:),'--or')
  hold on;
 plot([3,4,5,6,7],cr(3,:),'-ob')
  hold on;
 plot([3,4,5,6,7],cr(4,:),'--ob')
  hold on;
 plot([3,4,5,6,7],cr(5,:),'-om')
  hold on;
 plot([3,4,5,6,7],cr(6,:),'--om')
 set(gca,'xtick',0:10);
%}

