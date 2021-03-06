function [M] = NVR_SHIFTX2PROB(TABLE,H,N,TYPES,SSTRUCT,NOES,ALLDISTS, ...
			   NTH,ROWIN,COLIN, SHIFTX_Filename);

%NVR_SHIFTX2PROB: This computes assignment probabilities based on the program SHIFTX, it is not meant
%             to be called by the user


%////////////////////////////////////////////////////////////////////////////////////////////
%//  NVR_SHIFTX2PROB.m
%//
%//  Version:		0.1
%//
%//  Description:	 This computes assignment probabilities based on BMRB statistics
%//
%// authors:
%//    initials    name            organization 					email
%//   ---------   --------------  ------------------------    ------------------------------
%//     CJL         Chris Langmead  Dartmouth College         langmead@dartmouth.edu
%//
%//
%// history:
%//     when        who     what
%//     --------    ----    ----------------------------------------------------------
%//     12/02/03    CJL 	 initial version for publication [Langmead et al, J Biomol NMR 2004]
%//
%////////////////////////////////////////////////////////////////////////////////////////////

%    NVR_SHIFTX2PROB
%    This library is free software; you can redistribute it and/or
%    modify it under the terms of the GNU Lesser General Public
%    License as published by the Free Software Foundation; either
%    version 2.1 of the License, or (at your option) any later version.

%    This library is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%    Lesser General Public License for more details.

%    You should have received a copy of the GNU Lesser General Public
%    License along with this library; if not, write to the Free Software
%    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

% 		Contact Info:
%							Bruce Randall Donald
%							HB 6211
%							Dartmouth College
%							Hanover, NH 03755
%							brd@cs.dartmouth.edu

% 		If you use publish any results derived from the use of this program please cite:
%		"An Expectation/Maximization Nuclear Vector Replacement Algorithm for Automated NMR Resonance Assignments," 
%		C. J. Langmead and B. R. Donald, 
%		Journal of Biomolecular NMR, 2004 (in press)


%  Copyright (C) 2003  Christopher James Langmead and Bruce R. Donald
%
%  <signature of Bruce Donald>, 2 December 2003
%  Bruce Donald, Professor of Computer Science

FILTERS=load('~njp/code/JBN-Submission-Snapshot-06-15-07/NVR/CHEMSHIFTSTATS/SHIFTXFILTERS');FILTERS=FILTERS.FILTERS;

[rn TY SS ha hn nf cb ca co]= textread(SHIFTX_Filename,'%f %s %s %f %f %f %f %f %f');

PRED = [rn  hn nf];

%get the scores for the two predictions
M=TABLE*0+1/size(TABLE,1);

for(i=1:size(TABLE,1))
   for(j=1:length(COLIN))
      
      T = TY(COLIN(j));
      S = SS(COLIN(j));
      
      h = H(i)-PRED(COLIN(j),2);
      n = N(i)-PRED(COLIN(j),3);
      
      if(strcmp(T,'A')==1)
         M(i,j)=getProb(h,n, S,FILTERS,1);
      elseif(strcmp(T,'C')==1)
         M(i,j)=getProb(h,n,S,FILTERS,2);
      elseif(strcmp(T,'D')==1)
         M(i,j)=getProb(h,n,S,FILTERS,3);
      elseif(strcmp(T,'E')==1)
         M(i,j)=getProb(h,n,S,FILTERS,4);
      elseif(strcmp(T,'F')==1)
         M(i,j)=getProb(h,n,S,FILTERS,5);
      elseif(strcmp(T,'G')==1)
         M(i,j)=getProb(h,n,S,FILTERS,6);
      elseif(strcmp(T,'H')==1)
         M(i,j)=getProb(h,n,S,FILTERS,7);
      elseif(strcmp(T,'I')==1)
         M(i,j)=getProb(h,n,S,FILTERS,8);
      elseif(strcmp(T,'K')==1)
         M(i,j)=getProb(h,n,S,FILTERS,9);
      elseif(strcmp(T,'L')==1)
         M(i,j)=getProb(h,n,S,FILTERS,10);
      elseif(strcmp(T,'M')==1)
         M(i,j)=getProb(h,n,S,FILTERS,11);
      elseif(strcmp(T,'N')==1)
         M(i,j)=getProb(h,n,S,FILTERS,12);
      elseif(strcmp(T,'Q')==1)
         M(i,j)=getProb(h,n,S,FILTERS,14);
      elseif(strcmp(T,'R')==1)
         M(i,j)=getProb(h,n,S,FILTERS,15);
      elseif(strcmp(T,'S')==1)
         M(i,j)=getProb(h,n,S,FILTERS,16);
      elseif(strcmp(T,'T')==1)
         M(i,j)=getProb(h,n,S,FILTERS,17);
      elseif(strcmp(T,'V')==1)
         M(i,j)=getProb(h,n,S,FILTERS,18);
      elseif(strcmp(T,'W')==1)
         M(i,j)=getProb(h,n,S,FILTERS,19);
      elseif(strcmp(T,'Y')==1)
         M(i,j)=getProb(h,n,S,FILTERS,20);
      else
         PROBLEM = TYPES(COLIN(j))   
      end
   end
   
   
   M(i,:) = M(i,:)/sum(M(i,:));%re-normalize
end

M = M .* TABLE;
%renornmalize
for(i=1:size(M,1))
   if(sum(M(i,:))==0)
      M(i,:)=1;
%     fprintf(1, 'shiftx bpg construction removed all entries from row #%d',i);
   end
%   else
   M(i,:)=M(i,:)/sum(M(i,:));
%   end
end

nlast = sum(sum(TABLE));
for(i=1:100)
   NP = NOE_PRUNE(TABLE(1:size(M,1),:),NOES,ALLDISTS,NTH,ROWIN,COLIN);
   TABLE(1:size(M,1),:)=and(TABLE(1:size(M,1),:),NP);
   if(sum(sum(TABLE)) == nlast)
      break;
   end
   nlast = sum(sum(TABLE));
end

M = M.*TABLE;

%renornmalize
for(i=1:size(M,1))
   if(sum(M(i,:))==0)
      M(i,:)=1;
   end
%     fprintf(1, 'shiftx bpg construction removed all entries from row #%d',i);
%   else
   M(i,:)=M(i,:)/sum(M(i,:));
%   end
end


function p = getProb(h,n,SSTYPE,FILTERS,TY)%


if(strcmp(SSTYPE,'C')==1)
   
   xH = FILTERS(3,TY,1,1);
   xHS = FILTERS(3,TY,1,2);
   xN = FILTERS(3,TY,2,1);
   xNS = FILTERS(3,TY,2,2);
   xHMX = FILTERS(3,TY,1,4);
   xHMN = FILTERS(3,TY,1,3);
   xNMX = FILTERS(3,TY,2,4);
   xNMN = FILTERS(3,TY,2,3);
   
elseif(strcmp(SSTYPE,'B')==1)
   
   xH = FILTERS(2,TY,1,1);
   xHS = FILTERS(2,TY,1,2);
   xN = FILTERS(2,TY,2,1);
   xNS = FILTERS(2,TY,2,2);
   xHMX = FILTERS(2,TY,1,4);
   xHMN = FILTERS(2,TY,1,3);
   xNMX = FILTERS(2,TY,2,4);
   xNMN = FILTERS(2,TY,2,3);
   
else
   xH = FILTERS(1,TY,1,1);
   xHS = FILTERS(1,TY,1,2);
   xN = FILTERS(1,TY,2,1);
   xNS = FILTERS(1,TY,2,2);
   xHMX = FILTERS(1,TY,1,4);
   xHMN = FILTERS(1,TY,1,3);
   xNMX = FILTERS(1,TY,2,4);
   xNMN = FILTERS(1,TY,2,3);
   
end

%correction factor

xHMX=xHMX*1.2;
xHMN =xHMN *1.2;
xNMX =xNMX *1.2;
xNMN =xNMN *1.2;

if(h>xH)
   if((h-xH)/xHS > xHMX)
      p=0;return
   else
      p1=normpdf(h,0,xHS);
   end
else
   if((xH-h)/xHS > xHMN)
      p=0;return
   else
      p1=normpdf(h,0,xHS);
   end
end
if(n>xN)
   if((n-xN)/xNS > xNMX)
      p=0;return
   else
      p2=normpdf(n,0,xNS);
   end
else
   if((xN-n)/xNS > xNMN)
      p=0;return
   else
      p2=normpdf(n,0,xNS);
   end
end

%input('d');

p = p1*p2;


