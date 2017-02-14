 function m2=fun_yanc(m)
 N=length(m);
 leng=0; 
if m(1)==0  
  for i=1:N      
   if m(i)==1    
        leng=i;   
         break;   
     end   
 end 
else     
 for i=1:N     
   if m(i)==0    
        leng=i;   
         break;     
   end     
end 
end  
leng1=leng-(floor(leng/20))*20; 
for i=1:(N-leng1)    
  m2(i)=m(i+leng1); 
end  
for i=(N-leng1):N   
   m2(i)=m(N-20+1);
 end 