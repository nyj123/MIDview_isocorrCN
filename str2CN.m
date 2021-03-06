%This function parses string of isotopeLabel(from Maven output) and
%finds out C and N labels. Deliminator '-' is used to make the judgement.
%examples:  str='C13-label-1', [Cnum,Nnum]=[1,0]
%str='N15-label-1',[Cnum,Nnum]=[0,1]
%str='C13N15-label-2-1',[Cnum,Nnum]=[2,1]
%str='C12 PARENT', [Cnum,Num]=[0,0]

function [Cnum,Nnum,errmsg]=str2CN(str)
      errmsg=0;
      sub_str=split(str,'-');
      num=length(sub_str);
      if num==1
          Cnum=0;
          Nnum=0;          
      elseif num==3
          if strcmp(str(1),'C')              
              Cnum=str2num(sub_str{end});             
              Nnum=0; 
          elseif strcmp(str(1),'N')
              Cnum=0;
              Nnum=str2num(sub_str{end}); 
          else
              fprintf('it only works for C/N label'); 
              errmsg=1;
          end
      elseif num==4          
            Cnum=str2num(sub_str{end-1});
            Nnum=str2num(sub_str{end});          
      else
          fprintf('something is wrong with the string');
          errmsg=2;          
      end
      if isempty(Cnum)||isempty(Nnum)
          fprintf('labeling not a number');
          errmsg=3;          
      end
