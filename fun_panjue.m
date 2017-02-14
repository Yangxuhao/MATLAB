function m1=fun_panjue(w)
 N=length(w);
 if w(10)>0    
  m1(1:10)=0;
 else     
 m1(1:10)=1; 
end  
for i=11:N   
  if w(i)>0   
     m1(i)=0;  
   else     
    m1(i)=1;  
   end 
end
