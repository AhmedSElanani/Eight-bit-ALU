library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity EightBitALU is
	
	
	port
	(
		-- Input ports
		X,Y	      : in  std_logic_vector(7 downto 0);
		W	         : in  std_logic_vector(3 downto 0);
		S,R,L,A,D	: in  std_logic;
		
		-- Output ports
		f	: out std_logic_vector(7 downto 0)
		
	);
end EightBitALU;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture Behaviour of EightBitALU is

	begin
	
	process(X,Y,w,S,R,L,A,D) is 
		-- Declaration(s)
		
	Constant U	: integer  :=	(to_integer(signed(y)));
	Variable P	: integer  ;

	begin 
	
	if (s='1') then
	
	case w is
			when "0000" =>
				f <= std_logic_vector( signed(X) + signed(Y) );
			when "0001" =>
				f <= std_logic_vector( signed(X) - signed(Y) );
			when "0010" =>
				f <= std_logic_vector(to_signed((to_integer(signed(X)) * to_integer(signed(Y))),8)) ;
			when "0011" =>
				f <= std_logic_vector(to_signed(to_integer(signed(X)) / to_integer(signed(Y)),8)) ;	
			when "0100" =>
				P:= ((to_integer(signed(X))) ** (U) );
				f <= std_logic_vector(to_signed(P,8)) ;	
			when "0101" =>
				f<= std_logic_vector(signed(X) mod signed(Y));					
			when "0110" =>
				f<= std_logic_vector(signed(X) REM signed(Y));
			when "0111" =>
				f<= std_logic_vector(abs(signed(X)));
			when "1000" =>
				f<= X and Y;
			when "1001" =>
				f<= X nand Y;
			when "1010" =>
				f<= X or Y;
			when "1011" =>
				f<= X nor Y;
			when "1100" =>
				f<= X xor Y;
			when "1101" =>
				f <= X XnOR y ;
			when "1110" =>
				f <= not X;
			when "1111" =>
				if (R = '1') then     --Rotate
					if (D = '1') then  --specifies direction
						f  <= std_logic_vector(rotate_right(signed(X),to_integer(signed(Y))));
						else
						f  <= std_logic_vector(rotate_left(signed(X),to_integer(signed(Y))));
						end if;
				elsif (L = '1') then     --Logic Shift
						if (D = '1') then  --Specifies Direction
						f  <= std_logic_vector(shift_right(unsigned(X),to_integer(unsigned(Y))));
						else
						f  <= std_logic_vector(shift_left(unsigned(X),to_integer(unsigned(Y))));
						end if;
				elsif (A = '1') then     --Arithmetic shift
						if (D = '1') then  --Specifies Direction
						f  <= std_logic_vector(shift_right(signed(X),to_integer(signed(Y))));
						else
						f  <= std_logic_vector(shift_left(signed(X),to_integer(signed(Y))));
						end if;
				else
				f <= (others => '0') ;		
				end if;
				
			when others => 
				f <= (others => '1') ;		
 end case;
	
	else
	
	case w is
		when "0000" =>
			f <= std_logic_vector(unsigned(X) + unsigned(Y) );
		when "0001" =>
			f <= std_logic_vector(unsigned(X) - unsigned(Y) );
		when "0010" =>
			f <= std_logic_vector(to_unsigned((to_integer(unsigned(x)) * to_integer(unsigned(y))),8)) ;
		when "0011" =>
			f <= std_logic_vector(to_unsigned(to_integer(unsigned(x)) / to_integer(unsigned(y)),8)) ;	
		when "0100" =>
			P:= ((to_integer(unsigned(X))) ** (U) );
			f <= std_logic_vector(to_unsigned(P,8)) ;	
		when "0101" =>
			f<= std_logic_vector(unsigned(X) mod unsigned(Y));					
		when "0110" =>
			f<= std_logic_vector(unsigned(X) REM unsigned(Y));
		when "0111" =>
			f<= std_logic_vector(abs(signed(X)));
		when "1000" =>
			f<= X and Y;
		when "1001" =>
			f<= X nand Y;
		when "1010" =>
			f<= X or Y;
		when "1011" =>
			f<= X nor Y;
		when "1100" =>
			f<= X xor Y;
		when "1101" =>
			f <= X XnOR y ;
		when "1110" =>
			f <= not X;
		when "1111" =>
			if (R = '1') then     --Rotate
				if (D = '1') then  --Specifies Direction
					f  <= std_logic_vector(rotate_right(signed(X),to_integer(signed(Y))));
					else
					f  <= std_logic_vector(rotate_left(signed(X),to_integer(signed(Y))));
					end if;
				elsif (L = '1') then    --Logic shift
						if (D = '1') then --specifies direction
							f  <= std_logic_vector(shift_right(unsigned(X),to_integer(unsigned(Y))));
						else
							f  <= std_logic_vector(shift_left(unsigned(X),to_integer(unsigned(Y))));
						end if;
				elsif (A = '1') then    --Arithmetic shift
						if (D = '1') then --specifies direction
							f  <= std_logic_vector(shift_right(signed(X),to_integer(signed(Y))));
						else
							f  <= std_logic_vector(shift_left(signed(X),to_integer(signed(Y))));
						end if;
						else
							f <= (others => '0') ;		
						end if;
				
						when others => 
							f <= (others => '1') ;		
 end case;
	end if;
	end process; 
end Behaviour;

