classdef sequence
	properties
		data
		offset
	end
	
	methods
		function s = sequence(data, offset)
			% SEQUENCE   Sequence object
			%            S = SEQUENCE(DATA, OFFSET) creates sequence S
			%            using DATA and OFFSET
			%
			%            Kevin Baltazar Reyes
			s.data = data;
			s.offset = offset;
		end
		
		function display(s)
			var = inputname(1);
			if (isempty(var))
				disp('ans =');
			else
				disp([var '=']);
			end
			switch length(s.data)
				case 0
					disp('    data: []')
				case 1
					disp(['    data: ', num2str(s.data)])
				otherwise
					disp(['    data: [' num2str(s.data) ']'])
			end
			disp(['  offset: ' num2str(s.offset)])
		end
		
		function y = flip(x)
			% FLIP Flip a Matlab sequence structure, x, so y = x[-n]
            d=x.data(end:-1:1);    %start with last input of x.data, count down by -1 each time until you reach 1
            o=-(x.offset+length(x.data)-1);     %offset of x PLUS length of sequence x MINUS 1
            y=sequence(d,o);
		end
		
		function y = shift(x, n0)
			% SHIFT Shift a Matlab sequence structure, x, by integer amount n0 so that y[n] = x[n - n0]
            d1=x.data;  %data sequence remains the same, we are only shifting the offset
            o1=(x.offset+n0);   %new offset = previous offset + value you are shifting
            y=sequence(d1,o1);
		end
		
		function z = plus(x, y)
			% PLUS  Add x and y. Either x and y will both be sequence structures, or one of them may be a number.
            if isa(x,'sequence')==0     %case where x is a constant, not a sequence
                z=sequence(y.data+x,y.offset);  %add constant x to every data pt in y sequence, print y offset
                return;
            end
            if isa(y,'sequence')==0            
                z=sequence(x.data+y,x.offset);
                return;
            end
                
            Lx=length(x.data);  %length of data in sequence x
            Ly=length(y.data);  %length of data in sequence y
            
            ody=y.offset-x.offset;  %difference between sequence offsets IF Y HAS GREATER OFFSET THAN X
            odx=x.offset-y.offset;  %%difference between sequence offsets IF X HAS GREATER OFFSET THAN Y
            
            x.data=[zeros(1,odx) x.data zeros(1,ody-(Lx-Ly))];  %add zeros to the beginning & end of sequence x as a "filler". You cannot perform operations between x & y if there is no data at a given index. The zeros are put in to fill these empty spots.
            y.data=[zeros(1,ody) y.data zeros(1,odx-(Ly-Lx))];
            
            off=min(x.offset,y.offset);     %minimum offset between x & y
            z=sequence(x.data+y.data,off);  %create sequence z as a result of adding sequence x & y together
            
            while z.data(end)==0    %removes the unnecessary zeros at the end of sequence z
                z.data(end)=[];
            end
            
            while z.data(1)==0  %removes the unnecessary zeros at the beginning of sequence z
                z.data(1)=[];
                z.offset=z.offset+1;    %updates the new offset every time a zero is removed
            end
            
		end
		
		function z = minus(x, y)
			% MINUS Subtract x and y. Either x and y will both be sequence structures, or one of them may be a number.
            if isa(x,'sequence')==0     
                z=sequence(y.data-x,y.offset); 
                return;
            end
            if isa(y,'sequence')==0            
                z=sequence(x.data-y,x.offset);
                return;
            end
                
            Lx=length(x.data);
            Ly=length(y.data);
            
            ody=y.offset-x.offset;  
            odx=x.offset-y.offset; 
            
            x.data=[zeros(1,odx) x.data zeros(1,ody-(Lx-Ly))];  
            y.data=[zeros(1,ody) y.data zeros(1,odx-(Ly-Lx))];
            
            off=min(x.offset,y.offset);
            z=sequence(x.data-y.data,off);
            
            while z.data(end)==0
                z.data(end)=[];
            end
            
            while z.data(1)==0
                z.data(1)=[];
                z.offset=z.offset+1;
            end
		end
		
		function z = times(x, y)
			% TIMES Multiply x and y (i.e. .*) Either x and y will both be sequence structures, or one of them may be a number.
            if isa(x,'sequence')==0  
                z=sequence(y.data*x,y.offset); 
                return;
            end
            if isa(y,'sequence')==0            
                z=sequence(x.data*y,x.offset);
                return;
            end
                
            Lx=length(x.data);
            Ly=length(y.data);
            
            ody=y.offset-x.offset;  
            odx=x.offset-y.offset;  
            
            x.data=[zeros(1,odx) x.data zeros(1,ody-(Lx-Ly))];  
            y.data=[zeros(1,ody) y.data zeros(1,odx-(Ly-Lx))];
            
            off=min(x.offset,y.offset);
            z=sequence(x.data.*y.data,off);
            
            while z.data(end)==0
                z.data(end)=[];
            end
            
            while z.data(1)==0
                z.data(1)=[];
                z.offset=z.offset+1;
            end
		end
		
		function stem(x)
			% STEM Display a Matlab sequence, x, using a stem plot.
            stem(x.data)    %plots all data in sequence x
        end
        
        function y = conv(x,h)
            %CONV two finite-length Matlab sequence objects, x and h
            %   returning sequence object y
            
            if (length(x.data) > length(h.data))    %if sequence h is shorter, convolve sequence h with matrix X (y=h*X)
                X = zeros(length(h.data), ((length(h.data)+length(x.data))-1));  %define X's dimensions and stuff with zeros:
                i=1;                                                            %       X row length = sequence h data length
                j=1;                                                            %       Y column length = length(h.data)+length(x.data)-1
                P = [x.data zeros(1,length(h.data)-1)]; %sequence x duplicated in P. length(x.data) + length of zeros stuffed after MUST EQUAL length of sequence y for flip&shift method
                for n = 1:(length(h.data))  %outer loop for row increment
                    for m = 1:((length(h.data)+length(x.data))-1)   %inner loop for column increment
                        X(i,j)=P(j);    %value stored in P's current index goes to corresponding X index
                        j=j+1;          %index points to next column (next value of data in P)
                    end
                    P = circshift(P,[0,1]); %circular shift-right on vector P. Value of 0 inputted one time to open data slot (leftmost slot)
                    i=i+1;  %index points to next row (P[k-n])
                    j=1;    %start from P's first data point (leftmost column)
                end
                y = sequence((h.data*X),(x.offset+h.offset)); %now that the matrix dimensions are correct, we can multiply them together
           
            else    %convolve x with matrix H (y=x*H)
                H = zeros(length(x.data), ((length(h.data)+length(x.data))-1));
                i=1;
                j=1;
                P = [h.data zeros(1,length(x.data)-1)];
                
                for n=1:(length(x.data))
                    for m = 1:((length(x.data)+length(h.data))-1)
                        H(i,j)=P(j);
                        j=j+1;
                    end
                    P = circshift(P,[0,1]);
                    i=i+1;
                    j=1;
                end
                
                y=sequence((x.data*H),(x.offset+h.offset));
            end
        end
        
        function x = deconv(y,h)    % x = y*H^(-1)
            % DECONV Convolve finite-length Matlab sequence object, y,
            %        given impulse response object, h
            %        returning sequence object, x.
        
            Lx = length(y.data)-length(h.data)+1;   %length of sequence x
            h_hat = zeros(Lx,Lx);    %define Lx by Lx matrix 
            F = [h.data zeros(1, Lx-length(h.data))];   %sequence h duplicated in F. Add zeros after h.data so the length of F == Lx
        
        
            %traverse vector F through Lx by Lx matrix h_hat. Shift right, cut
            %off data shifted out at the end of the vector
            for i=1:Lx
                h_hat(i,:) = [zeros(1,i-1) F(1:Lx-i+1)];     %shift right by 1 each row by adding one zero per row in front, and cutting 1 data per row at end
            end
            x = sequence(y.data(1:Lx)*inv(h_hat), y.offset-h.offset);   %only need to sample enough y.data to equal length(x.data). (length(y.data) MUST equal row & column length for h_hat
        end
        
        function y = even(x)
            % EVEN  Take a Matlab sequence object, x, which is possibly
            % complex, and create a Matlab sequence structure y, that
            % corresponds to the even part
            
            y = times(0.5, plus(x, flip(x)));     
        end
        
        function y = odd(x)
            % EVEN  Take a Matlab sequence object, x, which is possibly
            % complex, and create a Matlab sequence structure y, that
            % corresponds to the even part
            
            y = times(0.5, minus(x, flip(x)));
        end
        
        function y = trim(x)
            y = x;
             while x.data(end)==0    %removes the unnecessary zeros at the end of sequence z
                x.data(end)=[];
            end
            
            while x.data(1)==0  %removes the unnecessary zeros at the beginning of sequence z
                x.data(1)=[];
                x.offset=x.offset+1;    %updates the new offset every time a zero is removed
            end
        end
    end
end