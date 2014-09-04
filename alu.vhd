
--ctrl:
--"0000" - to AR
--"0001" - ar + from_bus
--"0010" - ar - from_bus
--"0011" -  ar+1
--"0100" - ar-1

entity alu is
	port(clk: in std_logic;
		from_bus: in std_logic_vector(15 downto 0);	
		ctrl : in std_logic_vector(5 downto 0);
		to_bus: out std_logic_vector(15 downto 0);		
		rst: in std_logic
		);
end alu;

architecture alu_def of alu is
	signal ar : std_logic_vector(7 downto 0) := (ar'range => '0');
	signal temp : std_logic_vector(8 downto 0) := (temp'range => '0');

	type sr_state is
		record
			overflow : std_logic;
			negative : std_logic;
			zero : std_logic;
		end record;
		
	signal sr : sr_state; --OVERFLOW,NEGATIVE,ZERO
begin

process(clk)
begin
if rising_edge(clk) then
	if rst = '1' then
		ar <= (ar'range => '0');
		sr <= ('0','0','0');
	else
				
		temp <= from_bus WHEN ctrl = "0000" ELSE
			(ar+from_bus) WHEN ctrl = "0001" ELSE
			(ar-from_bus) WHEN ctrl = "0010" ELSE
			(ar+1) WHEN ctrl = "0011" ELSE
			(ar-1) WHEN ctrl = "0100" ELSE
			'X';

		if temp == "000000000" then
			sr.zero <= '1';
		else
			sr.zero <= '0';
		end if;	
		if temp(8) ==  '1' then
			sr.overflow <= '1';
		else
			sr.overflow <= '0';
		end if;
		
		if temp(7) == '1' then
			sr.negative <= '1';
		else
			sr.negative <= '0';
		end if;
		
		ar <= temp(7 downto 0);
	end if;
end if;
end process;
end alu_def;
		