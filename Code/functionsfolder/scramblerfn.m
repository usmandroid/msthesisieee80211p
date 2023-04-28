function output_bits = scramblerfn(input_bits, initial_state)

% Scrambler Polynomial - S(x) = x^7 + x^4 + 1

% The 127-bit sequence generated repeatedly by the scrambler shall be 
%(leftmost used first), when the all ones initial state is used.

% seq =[ 00001110 11110010 11001001 00000010 00100110 00101110 10110110 ...
%     00001100 11010100 11100111 10110100 00101010 11111010 01010001 ...
%     10111000 1111111 ];
 

% The same scrambler is used to scramble transmit data and to descramble 
% receive data. When transmitting, the initial state of the scrambler shall
% be set to a pseudorandom nonzero state. The seven LSBs of the SERVICE 
% field shall be set to all zeros prior to scrambling to enable estimation 
% of the initial state of the scrambler in the receiver.


%% MATLAB BUILT-IN SCRAMBLER

% % Calculation base
% N = 2;
% 
% % Initial states = initial_state
% 
% scr = comm.Scrambler(N,'1 + z^-4 + z^-7',initial_state);
% 
% output_bits1 = scr(input_bits);


%% CUSTOM BUILT SCRAMBLER
% initial_state = [1 0 1 1 1 0 1];
initial_state = [1 1 1 1 1 1 1];
%When the all ones initial state is used, the 127-bit sequence generated repeatedly by the scrambler (left-most used first) is
states = initial_state; 
%example:[0 1 1 0 1 0 0] -> [MSB ... LSB] that means... [state7 ... state1]
% input_bits = zeros(1,130);
orig = [0 0 0 0 1 1 1 0  1 1 1 1 0 0 1 0  1 1 0 0 1 0 0 1  0 0 0 0 0 0 1 0  0 0 1 0 0 1 1 0  0 0 1 0 1 1 1 0  1 0 1 1 0 1 1 0  0 0 0 0 1 1 0 0  1 1 0 1 0 1 0 0  1 1 1 0 0 1 1 1  1 0 1 1 0 1 0 0  0 0 1 0 1 0 1 0  1 1 1 1 1 0 1 0  0 1 0 1 0 0 0 1  1 0 1 1 1 0 0 0  1 1 1 1 1 1 1 ];
input_bits = orig;
for n=1:length(input_bits)
    
    save_state_4 = states(4);
    save_state_7 = states(7);
    
    output_bits(n) = xor(input_bits(n),xor(states(4),states(7)));
    
    states = circshift(states,1);
    
    states(1)= output_bits(n);

end

output_bits = double(output_bits)';

%%

% isequal(output_bits,output_bits1)

end